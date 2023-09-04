function[sol]=gauss_seidel(A,b)
    
    [n,m] = size(A);
    
    %Ciclo para iterar por toda la matriz
    for k =1:n
       suma = 0;
        for j=k+1:n
          suma = suma+A(k,j)*sol(j);
        end
        sol(k)=(b(k)-suma)/A(k,k);
       
    end
end



A=input('Ingresa la matriz de coeficiente del sistema entre []:');
b=input('Ingresa el vector de términos independientes entre []:');
x=input('Ingresa el vector inicial entre []:');
ep=input('Ingresa el epsilon para el criterio de convergencia:');
Nmax=input('Ingresa el número máximo de iteraciones:');
b=b';
x=x';
n=length(x);
k=1;
while k<=Nmax
    v=x;
    for i=1:1:n
        suma=A(i,1:i-1)*x(1:i-1)+A(i,i+1:n)*x(i+1:n);
        x(i)=(b(i)-suma)/A(i,i);
    end 
    norma=norm(v-x);
    if norma<=ep
        fprintf('\n   El método converge \n')
        fprintf('\n La solución en la iteracion: %4.0f  es: \n',k)
        for i=1:1:n 
            fprintf('      x(%1i)=%6.8f\n',i,x(i))
        end
        fprintf('      Norma=%8.6e\n',norma)
        centinela=2;
        break
    else
        fprintf('\nPara la iteración: %4.0f\n',k)
        for i=1:1:n
            fprintf('       x(%1i)=%6.8f\n',i,x(i))
        end
        fprintf('       Norma =%8.6e\n',norma)
        centinela=1;
    end
    k=k+1;
end