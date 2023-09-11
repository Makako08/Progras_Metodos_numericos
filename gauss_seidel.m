function[sol, error, i] = gauss_seidel(A, b)
    [n, m] = size(A);
    sol = zeros(1, n);
    it = input('Ingrese el número máximo de iteraciones: ');

    for i = 2:it + 1
        for k = 1:n
            suma = 0;
            
            % Uso de valores más recientes (anteriores a k) o valores de la iteración anterior (mayores que k)
            for j = 1:n
                if j < k
                    suma = suma + A(k, j) * sol(i, j);  % Uso del valor más reciente
                elseif j > k
                    suma = suma + A(k, j) * sol(i - 1, j);  % Uso del valor de la iteración anterior
                end
            end
            sol(i, k) = (b(k) - suma) / A(k, k);
        end
        error(i) = norm(sol(i, :) - sol(i - 1, :), 4);
    end
    i = i - 1;
end