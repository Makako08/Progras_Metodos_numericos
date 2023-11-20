syms x %Esto dice que x es una variable suimbólica, usar para meter funciones
f = input("Ingrese la funcion en base x: ")
a = input("Ingrese el valor de a: ")
b = input("Ingrese el valor de b: ")
prec = input("Ingrese la presicion deseada: ")
itermax = input("Ingrese las iteraciones máximas deseadas: ")

n = 1;
Iant = 0;
error = prec+1;

while error>prec & n < itermax
[I] = Trapecio(f,a,b,n);
error = abs(I-Iant);
Iant = I;
n = n+1;

end

disp("El valor de la integral es: ")
vpa(I)

disp("El error obtenido es: ")
vpa(error)


disp("La cantidad de subintervalos es de: ")
n-1



