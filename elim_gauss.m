function[U, y]=elim_gauss(A, b)

[n,m] = size(A);
U=A;
y = b;
for k=1:n-1
    for i=k+1:n
        factor = U(i,k) / U(k,k);
        for j=n:-1:k
            U(i,j) = U(i,j) - factor * U(k,j);
        end
        y(i) = y(i) - factor * y(k); % Actualizar el vector b
    end
end
end