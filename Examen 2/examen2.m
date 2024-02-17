function examen2()
    % Se piden los valores de entrada
    k1 = 0.01; %input('Ingrese el valor de la viscosidad dinámica de la primer sustancia (k1): ');
    k2 = 0.03; %input('Ingrese el valor de la viscosidad dinámica de la segunda sustancia (k2): ');
    x = 10; %input('Ingrese el valor de la distancia entre láminas (x): ');
    n = 20; %input('Ingrese el número de intervalos deseados (n): ');
    t = 2000; %input('Ingrese el tiempo total que se desea calcular (t): ');
    dt = 5; %input('Ingrese el tamaño del intervalo de tiempo (dt): ');
    v0 = 9; %input('Ingrese la velocidad inicial de la placa superior: ');
    i = 6; %input('Ingrese la distancia a la cuál se encuentra la interfaz entre sustancias (i): ');
    
    precision = 0.05;
    itermax = 100;
    
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
    X = 0:dx:x; % Vector de posiciones = 21
    % Se crea el vector de tiempos = 101
    T = 0:dt:t;

    lambda1 = k1 * dt / dx;
    lambda2 = k2 * dt / dx;
    
    %Se crea la matriz con la que se trabajará
    matA = matriz(lambda1, lambda2, length(X), i);
    
    % Se realiza el cálculo de velocidades utilizando Gauss-Seidel
    tic;
    Mr_GS = calcularVelocidadesGaussSeidel(X, T, v0, i, lambda1, lambda2, precision, itermax);
    tiempo = toc; % Detener temporizador y almacenar tiempo de ejecución
    disp('Tiempo de ejecución Gauss-Seidel:');
    disp(tiempo);
    
    vb = 0;
    
    % Se realiza el cálculo de velocidades utilizando Factorización LU
    tic;
    Mr_LU = calcularVelocidadesLU(X, T, v0, i, lambda1, lambda2, matA);
    tiempo = toc; % Detener temporizador y almacenar tiempo de ejecución
    disp('Tiempo de ejecución LU:');
    disp(tiempo);
    
    % Se grafican los resultados
    graficarResultados(X, Mr_GS, T, 'Gauss-Seidel');
    graficarResultados(X, Mr_LU, T, 'Factorización LU');
end

function [Mr] = calcularVelocidadesGaussSeidel(X, T, v0, i, lambda1, lambda2, precision, itermax)
    % Inicialización de la matriz de resultados
    Mr = zeros(length(T), length(X));
    Mr(1, end) = v0; % Condición inicial
    
    %tiempo = zeros(1, length(T)); % Vector para almacenar el tiempo de ejecución

    % Cálculo de velocidades utilizando Gauss-Seidel con parámetros adicionales
    for i_tiempo = 2:length(T)
        for iter = 1:itermax
            Mr(i_tiempo, :) = calcularNuevaIteracionGaussSeidel(Mr(i_tiempo - 1, :), X, i, lambda1, lambda2);
            % Verificar convergencia
            if norm(Mr(i_tiempo, :) - Mr(i_tiempo - 1, :)) < precision
                break;
            end
        end
        
    end
end

function nuevo = calcularNuevaIteracionGaussSeidel(anterior, X, i, lambda1, lambda2)
    nuevo = anterior;
    for i_longitud = 2:length(X)-1
        if i_longitud < i / X(2) + 1
            derecha = nuevo(i_longitud + 1);
            izquierda = nuevo(i_longitud - 1);
            nuevo(i_longitud) = nuevo(i_longitud) + lambda1 * (izquierda - 2 * nuevo(i_longitud) + derecha);
        elseif i_longitud == i / X(2) + 1
            derecha = nuevo(i_longitud + 1);
            izquierda = nuevo(i_longitud - 1);
            nuevo(i_longitud) = (derecha + (lambda1 / lambda2) * izquierda) / (1 + lambda1 / lambda2);
        elseif i_longitud > i / X(2) + 1
            derecha = nuevo(i_longitud + 1);
            izquierda = nuevo(i_longitud - 1);
            nuevo(i_longitud) = nuevo(i_longitud) + lambda2 * (izquierda - 2 * nuevo(i_longitud) + derecha);
        end
    end
end

function Mr = calcularVelocidadesLU(X, T, v0, i, lambda1, lambda2, matA)
    % Inicialización de la matriz de resultados
    Mr = zeros(length(T), length(X));
    %Mr(:,end) = 9;
    %Mr(:,1) = 0;
    [L, U] = factLU(matA);
    
    for i_tiempo = 2:length(T)
        for i_longitud = 1:length(X)
            if i <= i_longitud
                lambda = lambda2;
                vb = v0;
            else
                lambda = lambda1;
                vb = 0;
                
            end
            
            b_anterior = vector(lambda, Mr(i_tiempo - 1, :), vb);

            y = sust_adelante(L, b_anterior');
            x = sust_atras(U, y);
            Mr(i_tiempo, :) = x';
            Mr(:,1) = 0;
            Mr(:,end) = 9;
            
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


function b = vector(lambda, prev, vb)
    % Función para generar el vector de constantes

    n = length(prev);
    b = zeros(size(prev));

    for p = 1:n
        if p == 1
            b(p) = 0;
        elseif p==2
            b(p) = lambda * vb + prev(p);
        elseif p == n-1
            b(p) = lambda * vb + prev(p);
        elseif p == n 
            b(p) = 9;
        else
            b(p) = prev(p);
        end
    end
end


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
