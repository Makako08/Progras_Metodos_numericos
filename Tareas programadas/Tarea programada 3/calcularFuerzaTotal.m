function calcularFuerzaTotal(D, g, rho, w_z, f)
    % Valores de entrada
    disp(['D = ', num2str(D), ' m']);
    disp(['g = ', num2str(g), ' m/s^2']);
    disp(['rho = ', num2str(rho), ' kg/m^3']);

    % Intervalo de integración
    Z = 0:12.5:D;

    % Calcular la integral usando el método de Simpson
    a = 0;
    b = D;
    prec = 1000;
    itermax = 10000;
    disp('Método de Simpson:');
    [I_Simpson, error_Simpson, n_Simpson] = llamadasimpson(f, a, b, prec, itermax);
    disp(['Valor de la integral: ', num2str(I_Simpson)]);
    disp(['Error: ', num2str(error_Simpson)]);
    disp(['Cantidad de subintervalos: ', num2str(n_Simpson)]);

    % Calcular la integral usando el método del trapecio
    disp('Método del Trapecio:');
    [I_Trapecio, error_Trapecio, n_Trapecio] = llamadatrapecio(f, a, b, prec, itermax);
    disp(['Valor de la integral: ', num2str(I_Trapecio)]);
    disp(['Error: ', num2str(error_Trapecio)]);
    disp(['Cantidad de subintervalos: ', num2str(n_Trapecio)]);
end
