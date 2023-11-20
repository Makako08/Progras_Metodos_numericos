function datos
    clc, clear
    
    g = 9.81;
    D = 75;
    rho = 1000;
    Z = 0:12.5:75;
    w = [122 130 135 160 175 190 200];
    
  
    p = @(z) rho * g * (D - z);
    
    I1 = @(z) rho * g * w(Z == z) * (D - z);  
    I2 = @(z) rho * g * z * w(Z == z) * (D - z);  
    [ft_simpson, n_simpson] = simpson(I1, 0, D); 
    [d_simpson] = simpson(I2, 0, D) / simpson(I1, 0, D);  
    

    [ft_trapecio, n_trapecio] = trapecio(I1, 0, D);  
    [d_trapecio] = trapecio(I2, 0, D) / trapecio(I1, 0, D);  
    

    error_simpson = abs(ft_simpson - ft_trapecio);
    error_trapecio = abs(ft_trapecio - ft_simpson);
    

    disp('Datos de entrada:');
    fprintf('  g = %6.2f m/s^2\n', g);
    fprintf('  D = %6.2f m\n', D);
    fprintf('rho = %6.2f kg/m^3\n', rho);
   
    
    disp('Resultados:');
    fprintf('Método           | Fuerza Total (ft)    | Línea de Acción de la Fuerza (d)      | Error\n');
    disp('----------------------------------------------------------------------------------------------');
    fprintf('Simpson          | %10.4e N         | %10.4f m                          | %10.4e N\n', ft_simpson, d_simpson, error_simpson);
    fprintf('Trapecio         | %10.4e N         | %10.4f m                          | %10.4e N\n', ft_trapecio, d_trapecio, error_trapecio);
    
    
    function [I, n] = simpson(f, a, b)
        h = Z(2) - Z(1); 
        n = (b - a) / h;  
        
        F = 0;  
        for i = 0:n
            if i == 0 || i == n
                c = 1;  
            elseif mod(i, 2) ~= 0
                c = 4;  
            elseif mod(i, 2) == 0
                c = 2;  
            end
            F = F + c * f(a + i * h);
        end
        
        I = (h / 3) * F;  
    end

 
    function [I, n] = trapecio(f, a, b)
        h = Z(2) - Z(1);  
        n = (b - a) / h;  

        F = 0;  
        for i = 0:n
            if i == 0 || i == n
                c = 1;  
            else
                c = 2;  
            end
            F = F + c * f(a + i * h);
        end
        
        I = (h / 2) * F;  
    end
end

