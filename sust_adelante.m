function[sol]=sust_adelante(A,b)

    [n,m] = size(A);
    sol(1)=b(1)/A(1,1);
    for k=2:n
        suma=0;
        for j=1:k-1
                suma = suma + A(k,j)*sol(j);
        end
        sol(k)=(b(k)-suma)/A(k,k);
    end
end