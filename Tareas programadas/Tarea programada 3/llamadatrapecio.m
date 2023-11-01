syms x;

f=input("Ingrese la funcion en base x: ")
a=input("Ingrese el valor de a: ")
b=input("Ingrese el valor de b: ")
prec=input("Ingrese la presicion deseada: ")
itermax=input("Ingrese la iteracion maxima: ")

n=1;
Iant=0;
error=prec+20;

while error>=prec & itermax>=n

    [I]=trapecio(f,a,b,n);
    error=abs(I-Iant);
    Iant=I;
    n=n+1;


end
disp("El valor de la integral es ")
vpa(I)
disp("El valor del error es ")
vpa(error)
disp("La cantidad de subintervalos es ")
n-1