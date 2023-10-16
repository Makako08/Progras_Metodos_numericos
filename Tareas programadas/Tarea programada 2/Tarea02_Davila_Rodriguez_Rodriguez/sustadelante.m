function sol = sustadelante(A, b)
    [n, m] = size(A);
    
    if n ~= m
        error('La matriz A debe ser cuadrada (matriz triangular inferior).');
    end
    
    if length(b) ~= n
        error('El tamaño del vector b debe coincidir con el número de filas de A.');
    end

    sol = zeros(n, 1);

    for i = 1:n
        sol(i) = (b(i) - A(i, 1:i-1) * sol(1:i-1)) / A(i, i);
    end
end
