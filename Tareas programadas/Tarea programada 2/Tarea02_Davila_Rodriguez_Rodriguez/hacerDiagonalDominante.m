function A_diagonal_dominante = hacerDiagonalDominante(A)
    [m, n] = size(A);

    for i = 1:m
        suma_fila = sum(abs(A(i,:)));
        if 2*abs(A(i,i)) <= suma_fila
            [~, idx] = max(abs(A(i:m,i)));
            idx = idx + i - 1;
            A([i idx],:) = A([idx i],:);
        end
    end

    A_diagonal_dominante = A;
end