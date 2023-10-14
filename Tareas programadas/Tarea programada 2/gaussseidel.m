function [X, error, iter] = gaussseidel(A, b, Tol, iterMax)
    [m, n] = size(A);

    if m ~= n
        error('La matriz A debe ser cuadrada.');
    end

    if length(b) ~= m
        error('El tama�o del vector b debe coincidir con el n�mero de filas de A.');
    end

    % Inicializar la matriz X con ceros
    X = zeros(m, 1);

    % Inicializar el vector de errores
    error = zeros(iterMax, 1);

    % Realizar iteraciones
    for iter = 1:iterMax
        X_ant = X;  % Almacenar la soluci�n anterior

        for i = 1:m
            suma = A(i, :) * X - A(i, i) * X(i);
            X(i) = (b(i) - suma) / A(i, i);
        end

        % Calcular el error en esta iteraci�n utilizando norma 4
        error(iter) = norm(X - X_ant, 4);

        % Verificar la convergencia
        if error(iter) < Tol
            break;
        end
    end

    % Recortar el vector de errores al n�mero de iteraciones realizadas
    error = error(1:iter);

    % Si no se alcanza la tolerancia, mostrar un mensaje de advertencia
    if iter == iterMax && error(iter) > Tol
        warning('El m�todo de Gauss-Seidel no ha convergido dentro del n�mero m�ximo de iteraciones.');
    end
end

function esDominante = esDiagonalDominante(A)
    [m, n] = size(A);
    esDominante = true;

    for i = 1:m
        diagonal = abs(A(i, i));
        suma = sum(abs(A(i, :))) - diagonal;

        if diagonal <= suma
            esDominante = false;
            break;
        end
    end
end
