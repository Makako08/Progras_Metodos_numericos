%n = tamaño de la matriz

%Función de eliminación gaussiana
function[U] = elim_gauss(A)
    %Obtengo el tamaño de la matriz de entrada
    [n, m] = size(A);
    U = A;

    %Ciclo para iterar por toda la matriz
    for k =1:n-1
        %Recorro filas
        for i=k+1:n
            %Recorro columnas de derecha a izquierda para evitar problemas
            %de sustiitución de valores
            for j=n:-1:k
               U(i,j) = U(i,j)-(U(i,k)/U(k,k))*U(k,j);
            end 
        end
    end
end