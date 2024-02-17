mu_oil = 3; % cP
mu_water = 1; % cP
rho_oil = 0.9; % g/cm^3
x = 10; % cm
t = 200; % segundos
h_water = 6; % cm
h_oil = 4; % cm
v = 9; % cm/s

% Par�metros para la resoluci�n num�rica
dx = 0.1; % tama�o del paso espacial
dt = 1; % tama�o del paso temporal
nx = round(x / dx) + 1; % n�mero de puntos espaciales
nt = round(t / dt) + 1; % n�mero de puntos temporales

% Inicializaci�n de las velocidades
v_oil = zeros(nx, nt);
v_oil(:, 1) = v;
v_water = zeros(nx, nt);
v_water(:, 1) = v;

% Matrices para el m�todo impl�cito
A_oil = diag(ones(nx, 1)) - (dt * mu_oil / rho_oil) * diag(ones(nx-1, 1), -1) + (2 * dt * mu_oil / rho_oil) * diag(ones(nx, 1)) - (dt * mu_oil / rho_oil) * diag(ones(nx-1, 1), 1);
A_water = diag(ones(nx, 1)) - (dt * mu_water / rho_oil) * diag(ones(nx-1, 1), -1) + (2 * dt * mu_water / rho_oil) * diag(ones(nx, 1)) - (dt * mu_water / rho_oil) * diag(ones(nx-1, 1), 1);

% Condiciones de contorno
A_oil(1, 1) = 1;
A_oil(1, 2) = 0;
A_oil(nx, nx-1) = 0;
A_oil(nx, nx) = 1;

A_water(1, 1) = 1;
A_water(1, 2) = 0;
A_water(nx, nx-1) = 0;
A_water(nx, nx) = 1;

% Resoluci�n num�rica de las ecuaciones diferenciales parciales
for j = 2:nt
    % Ecuaciones de movimiento para el oil (m�todo impl�cito)
    v_oil(:, j) = A_oil \ v_oil(:, j-1);
    
    % Ecuaciones de movimiento para el water (m�todo impl�cito)
    v_water(:, j) = A_water \ v_water(:, j-1);
end

% C�lculo de velocidades promedio para el oil utilizando la regla de Simpson
integral_oil_simpson = SimpsonComp(@(h) v_oil(:, end), h_water, h_water + h_oil, nx);

% C�lculo de velocidades promedio para el water utilizando la regla de Simpson
integral_water_simpson = SimpsonComp(@(h) v_water(:, end), 0, h_water, nx);

% Velocidad promedio
v_oil_avg_simpson = integral_oil_simpson / h_oil;
v_water_avg_simpson = integral_water_simpson / h_water;

% Imprimir resultados
fprintf('Velocidad promedio de oil (Simpson) a %d segundos: %.2f cm/s\n', t, v_oil_avg_simpson);
fprintf('Velocidad promedio de water (Simpson) a %d segundos: %.2f cm/s\n', t, v_water_avg_simpson);

% Imprimir resultados de las integrales
fprintf('Integral de oil (Simpson) a %d segundos: %.2f\n', t, integral_oil_simpson);
fprintf('Integral de water (Simpson) a %d segundos: %.2f\n', t, integral_water_simpson);

