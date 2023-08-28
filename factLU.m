function [L, U] = factLU(A)
    [n, m] = size(A);
    U = A;
    L = eye(n);

    %Ciclo para iterar por toda la matriz
    for k =1:n-1
        %Recorro filas
        for i=k+1:n
            %Recorro columnas de derecha a izquierda para evitar problemas
            %de sustiitución de valores
            for j=n:-1:k
               U(i,j) = U(i,j)-(U(i,k)/U(k,k))*U(k,j);
               L(i,j)= (U(i,k)/U(k,k));
            end
        end
    end
end