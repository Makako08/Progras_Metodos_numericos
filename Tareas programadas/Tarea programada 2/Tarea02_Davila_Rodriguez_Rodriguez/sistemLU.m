function sol = sistemLU(A, b)
    % Obtener factorizaci�n LU de la matriz A
    [L, U] = factorizacionLU(A);

    % Resolver Ly = b utilizando sustituci�n hacia adelante
    y = sustadelante(L, b);

    % Resolver Ux = y utilizando sustituci�n hacia atr�s
    sol = sustatras(U, y);
end
