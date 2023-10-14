function sol = sustatras(A, b)
    [n, m] = size(A);
    
    if n ~= m
        error('La matriz A debe ser cuadrada (matriz triangular superior).');
    end
    
    if length(b) ~= n
        error('El tamaño del vector b debe coincidir con el número de filas de A.');
    end

    sol = zeros(n, 1);

    for i = n:-1:1
        sol(i) = (b(i) - A(i, i+1:end) * sol(i+1:end)) / A(i, i);
    end
end
