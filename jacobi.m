%{
function x=jacobi(A,b)

%DATOS
%A=MATRIZ CUADRADA
%b=VECTOR
%RESULTADOS
%x=VECTOR SOULUCION
[n n]=size (A);
x=zeros(n,1);
y=zeros(n,1);
error=0.0005;
NTOL=8;
flag=1;
k=3;
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
        disp(y)
    end
      
    for i=1:n
        if abs(y(i)-x(i))>error
            flag=0;
        end
        x(i)=y(i);
        
    end
    if(NTOL==k) || (flag==1)
        break
    end
end
%}

%% Jacobi Method
%% Solution of x in Ax=b using Jacobi Method
% * _*Initailize 'A' 'b' & intial guess 'x'*_
%%
A=[2 -1	 0;
   -1 3	-1;
    0 -1 2]
b=[1 8 -5]'
x=[0 0 0]'
n=size(x,1);
normVal=Inf; 
%% 
% * _*Tolerence for method*_
tol=0.01; itr=0; itrMax = 20; filas = 0; result = [];
%% Algorithm: Jacobi Method
%%
while normVal>tol & itr<itrMax
    xold=x;
    
    for i=1:n
        sigma=0;
        
        for j=1:n
            
            if j~=i
                sigma=sigma+A(i,j)*x(j);
            end
            
        end
        
        x(i)=(1/A(i,i))*(b(i)-sigma);
        result(fil, i) = (1/A(i,i))*(b(i)-sigma);
    end
    
    itr=itr+1;
    normVal=abs(xold-x);
end
%%
fprintf('Solution of the system is : \n%f\n%f\n%f\n%f in %d iterations',x,itr);
disp(itr);