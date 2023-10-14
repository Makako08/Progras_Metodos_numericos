% Definir los datos del problema
angulo = 60;  % Ángulo de 60 grados
F1_mag = 1000;  % Magnitud de la fuerza aplicada en el nodo 1

% Calcular las componentes de la fuerza aplicada en el nodo 1
F1_h = F1_mag * cosd(angulo);
F1_v = F1_mag * sind(angulo);

% Matrices de coeficientes después de reorganizar las ecuaciones
A = [0.819, 0, -0.574;
     0, 1, 0.574;
     0.574, 0, 0.819];
 
b = [F1_h; 0; F1_v];

% a) Resolver el sistema utilizando Gauss-Seidel
fprintf('Resolviendo el sistema utilizando Gauss-Seidel:\n');
tic;
[X_gaussseidel, ~, ~] = gaussseidel(A, b, 0.01, 1000);
tiempo_gaussseidel = toc;

% Calcular todas las fuerzas y componentes para Gauss-Seidel
F1 = sqrt(F1_h^2 + F1_v^2);
F3_h = X_gaussseidel(1);
F2_h = X_gaussseidel(2);
F3_v = X_gaussseidel(3);
F2_v = -F3_h / 0.574;
F2 = sqrt(F2_h^2 + F2_v^2);
F3 = F1_h - F3_h;

% Mostrar los valores calculados con Gauss-Seidel
fprintf('Reacciones y fuerzas calculadas con Gauss-Seidel:\n');
fprintf('F1_h = %.2f lb\n', F1_h);
fprintf('F3_h = %.2f lb\n', F3_h);
fprintf('F1_v = %.2f lb\n', F1_v);
fprintf('F2_h = %.2f lb\n', F2_h);
fprintf('F2_v = %.2f lb\n', F2_v);
fprintf('F3_v = %.2f lb\n', F3_v);
fprintf('F1 = %.2f lb\n', F1);
fprintf('F2 = %.2f lb\n', F2);
fprintf('F3 = %.2f lb\n', F3);
fprintf('Tiempo de ejecución de Gauss-Seidel: %f segundos\n', tiempo_gaussseidel);

% b) Resolver el sistema utilizando la factorización LU
fprintf('\nResolviendo el sistema utilizando Factorización LU:\n');
tic;
[L, U] = factorizacionLU(A);
Y = sustadelante(L, b);
X_LU = sustatras(U, Y);
tiempo_LU = toc;

% Calcular todas las fuerzas y componentes para Factorización LU
F1 = sqrt(F1_h^2 + F1_v^2);
F3_h = X_LU(1);
F2_h = X_LU(2);
F3_v = X_LU(3);
F2_v = -F3_h / 0.574;
F2 = sqrt(F2_h^2 + F2_v^2);
F3 = F1_h - F3_h;

% Mostrar los valores calculados con Factorización LU
fprintf('Reacciones y fuerzas calculadas con Factorización LU:\n');
fprintf('F1_h = %.2f lb\n', F1_h);
fprintf('F3_h = %.2f lb\n', F3_h);
fprintf('F1_v = %.2f lb\n', F1_v);
fprintf('F2_h = %.2f lb\n', F2_h);
fprintf('F2_v = %.2f lb\n', F2_v);
fprintf('F3_v = %.2f lb\n', F3_v);
fprintf('F1 = %.2f lb\n', F1);
fprintf('F2 = %.2f lb\n', F2);
fprintf('F3 = %.2f lb\n', F3);
fprintf('Tiempo de ejecución de Factorización LU: %f segundos\n', tiempo_LU);
