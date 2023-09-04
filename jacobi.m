function x=jacobi(A,b)
%DATOS
%A=MATRIZ CUADRADA
%b=VECTOR
%RESULTADOS
%x=VECTOR SOULUCION
[n n]=size (A);
x=zeros(n,1);
y=zeros(n,1)
error=0.0005;
NTOL=50;
flag=1;
k=10;
%PROGRAMA EN SI METODO DE JACOBI
while 1 
    flag=1;
    for i=1:n
        suma=0;
        for j=1:n
            if i~=j
                suma=suma+A(i,j)*x(j)/A(i,i);
            end
        end
        y(i)=b(i)/A(i,i)-suma;
    end
      
    for i=1:n
        if abs(y(i)-x(i))>error
            flag=0;
        end
        x(i)=y(i);
        
    end
    if(NTOL==k) | (flag==1)
        break
    end
end