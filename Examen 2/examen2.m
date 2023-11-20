function Examen()
    % Se piden los valores de entrada
    k1 = input('Ingrese el valor de la viscocidad dinámica de la primer sustancia (k1): ');
    k2 = input('Ingrese el valor de la viscocidad dinámica de la segunda sustancia (k2): ');
    x = input('Ingrese el valor de la distancia entre láminas (x): ');
    n = input('Ingrese el número de intervalos deseados (n): ');
    t = input('Ingrese el tiempo total que se desea calcular (t): ');
    dt = input('Ingrese el tamaño del intervalo de tiempo (dt): ');
    v0 = input('Ingrese la velocidad inicial de la placa superior: ');
    i = input('Ingrese la distancia a la cuál se encuentra la interfaz entre sustancias (i): ');

    % Se verifica que las condiciones necesarias de tiempo se cumplan:
    dx = x / n;
    dt_min_1 = 0.5 * dx / k1;
    dt_min_2 = 0.5 * dx / k2;
    
    if dt_min_1 < dt || dt_min_2 < dt
        disp('El dt seleccionado no es válido.');
        return;
    end

    % Se verifica que las condiciones necesarias de distancia se cumplan:
    if rem(n, x) ~= 0 || rem(i, dx) ~= 0
        disp('El n seleccionado no es válido para la distancia x seleccionada.');
        return;
    end

    % Se calculan las constantes faltantes:
    X = 0:dx:x; % Vector de posiciones

    % Se crea el vector de tiempos
    T = 0:dt:t;

    lambda1 = k1 * dt / dx;
    lambda2 = k2 * dt / dx;

    % Se realiza el cálculo de velocidades utilizando Gauss-Seidel
    Mr_GS = calcularVelocidadesGaussSeidel(X, T, v0, i, lambda1, lambda2);
    
    vb = zeros(size(X)); % o cualquier valor inicial que desees
    
    % Se realiza el cálculo de velocidades utilizando Factorización LU
    Mr_LU = calcularVelocidadesLU(X, T, v0, i, lambda1, lambda2, vb);

    % Se grafican los resultados
    graficarResultados(X, Mr_GS, T, 'Gauss-Seidel');
    graficarResultados(X, Mr_LU, T, 'Factorización LU');
end

function Mr = calcularVelocidadesGaussSeidel(X, T, v0, i, lambda1, lambda2)
    % Inicialización de la matriz de resultados
    Mr = zeros(length(T), length(X));
    Mr(1, end) = v0; % Condición inicial

    % Cálculo de velocidades utilizando Gauss-Seidel
    for i_tiempo = 2:length(T)
        for i_longitud = 1:length(X)
            if i_longitud == length(X) || i_longitud == 1
                anterior = Mr(i_tiempo - 1, i_longitud);
                Mr(i_tiempo, i_longitud) = anterior;
            elseif i_longitud < i / X(2) + 1
                anterior = Mr(i_tiempo - 1, i_longitud);
                derecha = Mr(i_tiempo - 1, i_longitud + 1);
                izquierda = Mr(i_tiempo - 1, i_longitud - 1);
                Mr(i_tiempo, i_longitud) = anterior + lambda1 * (izquierda - 2 * anterior + derecha);
            elseif i_longitud == i / X(2) + 1
                derecha = Mr(i_tiempo - 1, i_longitud + 1);
                izquierda = Mr(i_tiempo - 1, i_longitud - 1);
                Mr(i_tiempo, i_longitud) = (derecha + (lambda1 / lambda2) * izquierda) / (1 + lambda1 / lambda2);
            elseif i_longitud > i / X(2) + 1
                anterior = Mr(i_tiempo - 1, i_longitud);
                derecha = Mr(i_tiempo - 1, i_longitud + 1);
                izquierda = Mr(i_tiempo - 1, i_longitud - 1);
                Mr(i_tiempo, i_longitud) = anterior + lambda2 * (izquierda - 2 * anterior + derecha);
            end
        end
    end
end

function Mr = calcularVelocidadesLU(X, T, v0, i, lambda1, lambda2, vb)
    % Inicialización de la matriz de resultados
    Mr = zeros(length(T), length(X));
    Mr(1, end) = v0; % Condición inicial

    % Cálculo de velocidades utilizando Factorización LU
    M = matriz(lambda1, length(X));
    L = tril(M, -1) + eye(length(X));
    U = triu(M);

    for i_tiempo = 2:length(T)
        b_anterior = vector(lambda1, Mr(i_tiempo - 1, :), M, vb);
        y = sustitucionHaciaAdelante(L, b_anterior');
        x = sustitucionHaciaAtras(U, y);
        Mr(i_tiempo, :) = x';
    end
end

function graficarResultados(X, Mr, T, metodo)
    % Crear animación
    figure;
    hLine = plot(nan);
    axis([0 max(X) 0 max(X)]);
    set(hLine, 'YData', X);
    xlabel('Velocidad del fluído');
    ylabel('Posición (distancia entre placas)');

    for i = 1:length(Mr)
        r = Mr(i, :);

        ylim = get(gca, 'ylim');
        hold on
        plot([ylim(1) ylim(2)], [0 0], 'k')

        tiempo = T(i);
        str = ['Gráfico: ' metodo ', Tiempo: ' num2str(tiempo)];
        title(str);

        set(hLine, 'XData', r);
        drawnow
        pause(0.05)
    end
end

function M = matriz(lambda, nx)
    % Función para generar la matriz
    M = zeros(nx, nx);
    for i = 1:nx
        M(i, i) = 1 + 2 * lambda;
        if i > 1
            M(i, i - 1) = -lambda;
        end
        if i < nx
            M(i, i + 1) = -lambda;
        end
    end
end
function b = vector(lambda, Mr_prev, M, vb)
    % Función para generar el vector de constantes
    b = zeros(size(Mr_prev));
    n = length(Mr_prev);

    for i = 1:n
        if i == 1
            b(i) = lambda * (Mr_prev(i + 1) - 2 * Mr_prev(i) + M(i)) + vb(i);
        elseif i == n
            b(i) = lambda * (M(i) - 2 * Mr_prev(i) + Mr_prev(i - 1)) + vb(i);
        else
            b(i) = lambda * (Mr_prev(i + 1) - 2 * Mr_prev(i) + Mr_prev(i - 1)) + vb(i);
        end
    end
end

function y = sustitucionHaciaAdelante(L, b)
    % Sustitución hacia adelante
    n = length(b);
    y = zeros(size(b));

    for i = 1:n
        y(i) = (b(i) - L(i, 1:i - 1) * y(1:i - 1)) / L(i, i);
    end
end

function x = sustitucionHaciaAtras(U, y)
    % Sustitución hacia atrás
    n = length(y);
    x = zeros(size(y));

    for i = n:-1:1
        x(i) = (y(i) - U(i, i + 1:n) * x(i + 1:n)) / U(i, i);
    end
end