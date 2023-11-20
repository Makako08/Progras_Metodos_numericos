function examen2()
    % Se piden los valores de entrada
    k1 = 0.01; %input('Ingrese el valor de la viscocidad dinámica de la primer sustancia (k1): ');
    k2 = 0.033; %input('Ingrese el valor de la viscocidad dinámica de la segunda sustancia (k2): ');
    x = 10; %input('Ingrese el valor de la distancia entre láminas (x): ');
    n = 20; %input('Ingrese el número de intervalos deseados (n): ');
    t = 100; %input('Ingrese el tiempo total que se desea calcular (t): ');
    dt = 5; %input('Ingrese el tamaño del intervalo de tiempo (dt): ');
    v0 = 9; %input('Ingrese la velocidad inicial de la placa superior: ');
    i = 6; %input('Ingrese la distancia a la cuál se encuentra la interfaz entre sustancias (i): ');

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
    X(2)

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

    for i_tiempo = 2:length(T)
        for i_longitud = 1:length(X)
            if i <= i_longitud
                lambda = lambda2;
            else
                lambda = lambda1;
            end

            [L, U] = factLU(matriz(lambda1, lambda2, length(X), i));        
            % Corregir la llamada a la función vector eliminando el argumento vb
            b_anterior = vector(lambda, Mr(i_tiempo - 1, :), matriz(lambda1, lambda2, length(X), i), vb);

            y = sust_adelante(L, b_anterior');
            x = sust_atras(U, y);
            Mr(i_tiempo, :) = x';
        end
    end
end


function M = matriz(lambda1, lambda2, nx, i)
    % Función para generar la matriz
    M = zeros(nx, nx);
    
    for j = 1:nx
        if j < i
            M(j, j) = 1 + 2 * lambda1;
        elseif j == i
            M(j, j) = 1 + lambda1 / lambda2;
        else
            M(j, j) = 1 + 2 * lambda2;
        end
        
        if j > 1
            M(j, j - 1) = -lambda1 * (j < i) - lambda2 * (j >= i);
        end
        
        if j < nx
            M(j, j + 1) = -lambda1 * (j < i) - lambda2 * (j >= i);
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
   
    %Sustitución hacia adelante
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [L, U] = factLU(A)
    [n, m] = size(A);
    L = eye(n);
    U = A;

    for k = 1:n-1
        for i = k+1:n
            L(i, k) = U(i, k) / U(k, k);
            for j = n:-1:k
                U(i, j) = U(i, j) - ((U(i, k) / U(k, k)) * U(k, j));
            end
        end
    end
end

function sol = sust_adelante(A, b)
    [n, m] = size(A);
    sol(1) = b(1) / A(1, 1);

    for k = 2:n
        suma = 0;
        for j = 1:k-1
            suma = suma + A(k, j) * sol(j);
        end
        sol(k) = (b(k) - suma) / A(k, k);
    end
end

function sol = sust_atras(A, b)
    [n, m] = size(A);
    sol(n) = b(n) / A(n, n);

    for k = n-1:-1:1
        suma = 0;
        for j = k+1:n
            suma = suma + A(k, j) * sol(j);
        end
        sol(k) = (b(k) - suma) / A(k, k);
    end
end
