function [L, U, perm] = factorizacionLU(A)
    [m, n] = size(A);
    if m ~= n
        error('La matriz debe ser cuadrada para la factorización LU.');
    end

    L = eye(n);  
    U = A;      
    perm = 1:n;  

    for k = 1:n
        % Pivoteo parcial
        [maxval, maxrow] = max(abs(U(k:n, k)));
        maxrow = maxrow + k - 1;

        % Intercambia filas en U y L
        if maxrow ~= k
            % Intercambia filas en U
            U([k, maxrow], k:n) = U([maxrow, k], k:n);

            % Intercambia filas en L 
            if k > 1
                L([k, maxrow], 1:k-1) = L([maxrow, k], 1:k-1);
            end

            % Actualiza el vector de permutación
            perm([k, maxrow]) = perm([maxrow, k]);
        end

        % Realiza eliminación gaussiana en la columna k de U y actualiza L
        for i = k+1:n
            factor = U(i, k) / U(k, k);
            L(i, k) = factor;
            U(i, k:n) = U(i, k:n) - factor * U(k, k:n);
        end
    end
end
