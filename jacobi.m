function[sol,error, i]=jacobi(A,b)
[n,m] = size(A);
itr=0;
sol=zeros(1,n);
it=input('ingrese el numero maximo de iteraciones: ')
for i=2:it+1 %numero a ingresar por usuario max itr
    for k=1:n
    suma=0;
    
        for j=1:n
            if j == k
                suma = suma;
            else
                suma = suma + A(k,j)*sol(i-1,j);
            end
        end
    sol(i,k)=(b(k)-suma)/A(k,k);
    end
    error(i)=norm(sol(i,:)-sol(i-1,:),4);
end
i=i-1;
end