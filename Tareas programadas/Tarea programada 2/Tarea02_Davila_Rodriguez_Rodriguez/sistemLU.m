function sol = sistemLU(A, b)
    % Obtener factorización LU de la matriz A
    [L, U] = factorizacionLU(A);

    % Resolver Ly = b utilizando sustitución hacia adelante
    y = sustadelante(L, b);

    % Resolver Ux = y utilizando sustitución hacia atrás
    sol = sustatras(U, y);
end
