% Definir los datos del problema
angulo = 60;  % Ángulo de 60 grados
F1_mag = -1000;  % Magnitud de la fuerza aplicada en el nodo 1

% Calcular las componentes de la fuerza aplicada en el nodo 1
F1_h = F1_mag * cosd(angulo);
F1_v = F1_mag * sind(angulo);

% Matrices de coeficientes después de reorganizar las ecuaciones

A = [0.819, 0, -0.574, 0, 0, 0;
     0, 1, 0.574, 0, 0, 0;
     0.574, 0, 0.819, 0, 0, 0;
     -0.819, -1, 0, -1, 0, 0;
     -0.574, 0, 0, 0, -1, 0;
     0, 0, -0.819, 0, 0, -1]; 
      
 
b = [F1_h; 0; F1_v; 0; 0; 0];

% a) Resolver el sistema utilizando Gauss-Seidel
fprintf('Resolviendo el sistema utilizando Gauss-Seidel:\n');
[X_gaussseidel, ~, ~] = gaussseidel(A, b, 0.01, 1000);

% Calcular todas las fuerzas y componentes para Gauss-Seidel
F1 = X_gaussseidel(1);
F2 = X_gaussseidel(2);
F3 = X_gaussseidel(3);
H2 = X_gaussseidel(4);
V2 = X_gaussseidel(5);
V3 = X_gaussseidel(6);

% Mostrar los valores calculados con Gauss-Seidel
fprintf('Reacciones y fuerzas calculadas con Gauss-Seidel:\n');
fprintf('F1 = %.2f lb\n', F1);
fprintf('F2 = %.2f lb\n', F2);
fprintf('F3 = %.2f lb\n', F3);
fprintf('H2 = %.2f lb\n', H2);
fprintf('V2 = %.2f lb\n', V2);
fprintf('V3 = %.2f lb\n', V3);

% b) Resolver el sistema utilizando la factorización LU
fprintf('\nResolviendo el sistema utilizando Factorización LU:\n');
[L, U] = factorizacionLU(A);
Y = sustadelante(L, b);
X_LU = sustatras(U, Y);

% Calcular todas las fuerzas y componentes para Factorización LU
F1 = X_LU(1);
F2 = X_LU(2);
F3 = X_LU(3);
H2 = X_LU(4);
V2 = X_LU(5);
V3 = X_LU(6);


% Mostrar los valores calculados con Factorización LU
fprintf('Reacciones y fuerzas calculadas con Factorización LU:\n');
fprintf('F1 = %.2f lb\n', F1);
fprintf('F2 = %.2f lb\n', F2);
fprintf('F3 = %.2f lb\n', F3);
fprintf('H2 = %.2f lb\n', H2);
fprintf('V2 = %.2f lb\n', V2);
fprintf('V3 = %.2f lb\n', V3);





A = [-1, 0, 0, 0, -0.707, 0, 0.707, 0, 0, 0;
     1, -0.866, 0, 0.5, 0, 0, 0, 0, 0, 0;
     0, 0.866, 1, 0, 0, 0, 0, 0, 0, 0;
     0, 0.5, 0, 0.866, 0, 0, 0, 0, 0, 0;
     0, 0, 0, -0.866, -0.707, 0, 0, 0, 0, 0;
     0, 0, -1, -0.5, 0.707, 1, 0, 0, 0, 0;
     0, 0, 0, 0, 0.707, 0, 0.707, 0, 0, 0;
     0, -0.5, 0, 0, 0, 0, 0, -1, 0, 0;
     0, 0, 0, 0, 0, -1, -0.707, 0, -1, 0;
     0, 0, 0, 0, 0, 0, -0.707, 0, 0, -1]; 
      
 
b = [0; 0; 0; -200; 0; 0; -400; 0; 0; 0];

% a) Resolver el sistema utilizando Gauss-Seidel
fprintf('Resolviendo el sistema utilizando Gauss-Seidel:\n');
[X_gaussseidel, ~, ~] = gaussseidel(A, b, 0.01, 1000);

% Calcular todas las fuerzas y componentes para Gauss-Seidel
F1 = X_gaussseidel(1);
F2 = X_gaussseidel(2);
F3 = X_gaussseidel(3);
F4 = X_gaussseidel(4);
F5 = X_gaussseidel(5);
F6 = X_gaussseidel(6);
F7 = X_gaussseidel(7);
V3 = X_gaussseidel(8);
H5 = X_gaussseidel(9);
V5 = X_gaussseidel(10);

% Mostrar los valores calculados con Gauss-Seidel
fprintf('Reacciones y fuerzas calculadas con Gauss-Seidel:\n');
fprintf('F1 = %.2f lb\n', F1);
fprintf('F2 = %.2f lb\n', F2);
fprintf('F3 = %.2f lb\n', F3);
fprintf('F4 = %.2f lb\n', F4);
fprintf('F5 = %.2f lb\n', F5);
fprintf('F6 = %.2f lb\n', F6);
fprintf('F7 = %.2f lb\n', F7);
fprintf('V3 = %.2f lb\n', V3);
fprintf('H5 = %.2f lb\n', H5);
fprintf('V5 = %.2f lb\n', V5);

% b) Resolver el sistema utilizando la factorización LU
fprintf('\nResolviendo el sistema utilizando Factorización LU:\n');
[L, U] = factorizacionLU(A);
Y = sustadelante(L, b);
X_LU = sustatras(U, Y);

% Calcular todas las fuerzas y componentes para Factorización LU
F1 = X_LU(1);
F2 = X_LU(2);
F3 = X_LU(3);
F4 = X_LU(4);
F5 = X_LU(5);
F6 = X_LU(6);
F7 = X_LU(7);
V3 = X_LU(8);
H5 = X_LU(9);
V5 = X_LU(10);


% Mostrar los valores calculados con Factorización LU
fprintf('Reacciones y fuerzas calculadas con Factorización LU:\n');
fprintf('F1 = %.2f lb\n', F1);
fprintf('F2 = %.2f lb\n', F2);
fprintf('F3 = %.2f lb\n', F3);
fprintf('F4 = %.2f lb\n', F4)
fprintf('F5 = %.2f lb\n', F5)
fprintf('F6 = %.2f lb\n', F6)
fprintf('F7 = %.2f lb\n', F7)
fprintf('V3 = %.2f lb\n', V3);
fprintf('H5 = %.2f lb\n', H5);
fprintf('V5 = %.2f lb\n', V5);