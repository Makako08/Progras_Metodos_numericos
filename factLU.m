function[L,U]=factLU(A)
[n,m] = size(A);
L=eye(n)

U=A;
for k=1:n-1
    for i=k+1:n
        L(i,k)=(U(i,k)/U(k,k));
        for j=n:-1:k
            U(i,j) = U(i,j) - ((U(i,k)/U(k,k))*U(k,j));
        end
    end
end




end