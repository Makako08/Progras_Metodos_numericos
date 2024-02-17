mu_aceite = 3; % cP
mu_H2O = 1; % cP
rho_aceite = 0.9; % g/cm^3
x = 10; % cm
t = 200; % segundos
h_agua = 6; % cm
h_aceite = 4; % cm 
v = 9; % cm/s 

% Función de velocidad de los fluidos en términos de la posición x
v_aceite_func = @(z) (v / (2 * mu_aceite)) * exp(-(z - h_agua - h_aceite / 2).^2 / (4 * mu_aceite / v * t));
v_H2O_func = @(z) (v / (2 * mu_H2O)) * exp(-(z - h_agua / 2).^2 / (4 * mu_H2O / v * t));

% Trapecio
n = 1000; % número de subintervalos
integral_aceite = TrapecioComp(@(z) v_aceite_func(z), h_agua, h_agua + h_aceite, n);
integral_H2O = TrapecioComp(@(z) v_H2O_func(z), 0, h_agua, n);

% V promedio
v_aceite_avg = integral_aceite / h_aceite;
v_H2O_avg = integral_H2O / h_agua;

fprintf('Velocidad promedio de aceite: %.2f cm/s\n', v_aceite_avg);
fprintf('Velocidad promedio de agua: %.2f cm/s\n', v_H2O_avg);
fprintf('Integral de aceite: %.2f cm\n', integral_aceite);
fprintf('Integral de agua: %.2f cm\n', integral_H2O);