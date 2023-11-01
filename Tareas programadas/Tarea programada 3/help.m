function pressure
    clc, clear
    
    g = 9.81;
    D = 75;
    rho = 1000;
    Z = 0:12.5:75;
    w = [122 130 135 160 175 190 200];
    
    
    p = @(z) rho * g * (D - z);
    
    
    I1 = @(z) rho * g * w(Z == z) * (D - z);  
    I2 = @(z) rho * g * z * w(Z == z) * (D - z);  
    
   
    [ft_simpson, ~, ~] = llamadasimpson(I1, 0, D, 1e-6, 1000);
    [d_simpson] = llamadasimpson(I2, 0, D, 1e-6, 1000) / ft_simpson;
    
    
    [ft_trapezoidal, ~, ~] = llamadatrapecio(I1, 0, D, 1e-6, 1000);
    [d_trapezoidal] = llamadatrapecio(I2, 0, D, 1e-6, 1000) / ft_trapezoidal;
    
    
    error_simpson = abs(ft_simpson - ft_trapezoidal);
    error_trapezoidal = abs(ft_trapezoidal - ft_simpson);
    
    
    disp('Datos de entrada:');
    fprintf('  g = %6.2f m/s^2\n', g);
    fprintf('  D = %6.2f m\n', D);
    fprintf('rho = %6.2f kg/m^3\n', rho);
    
    disp('Resultados:');
    disp('--------------------------------------------------------------');
    fprintf('| Método           | Fuerza Total (ft)       | Línea de Acción de la Fuerza (d) | Error |\n');
    disp('--------------------------------------------------------------');
    fprintf('| Simpson          | %10.4e N         | %10.4f m               | %10.4e N |\n', ft_simpson, d_simpson, error_simpson);
    fprintf('| Trapezoidal      | %10.4e N         | %10.4f m               | %10.4e N |\n', ft_trapezoidal, d_trapezoidal, error_trapezoidal);
    disp('--------------------------------------------------------------');
    
    
    function [I, error, n] = llamadasimpson(f, a, b, prec, itermax)
        % Simpson's rule for numerical integration
        h = (b - a) / 2;
        n = 2;
        I = (f(a) + 4 * f(a + h) + f(b)) * h / 3;
        Iant = I;
        error = prec + 1;
        
        while error >= prec & itermax >= n
            h = h / 2;
            sum_odd = 0;
            sum_even = 0;
            
            for i = 1:n
                x = a + (2 * i - 1) * h;
                sum_odd = sum_odd + f(x);
            end
            
            for i = 1:n-1
                x = a + 2 * i * h;
                sum_even = sum_even + f(x);
            end
            
            I = (f(a) + 4 * sum_odd + 2 * sum_even + f(b)) * h / 3;
            error = abs(I - Iant);
            Iant = I;
            n = n * 2;
        end
    end

    
    function [I, error, n] = llamadatrapecio(f, a, b, prec, itermax)
        h = (b - a);
        n = 1;
        I = (f(a) + f(b)) * h / 2;
        Iant = I;
        error = prec + 1;
        
        while error >= prec & itermax >= n
            h = h / 2;
            sum_even = 0;
            
            for i = 1:n
                x = a + i * h;
                sum_even = sum_even + f(x);
            end
            
            I = (f(a) + 2 * sum_even + f(b)) * h / 2;
            error = abs(I - Iant);
            Iant = I;
            n = n * 2;
        end
    end
end

