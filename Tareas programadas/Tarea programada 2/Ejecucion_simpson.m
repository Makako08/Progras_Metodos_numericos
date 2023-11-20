syms x %Esto dice que x es una variable suimbólica, usar para meter funciones
f = input("Ingrese la funcion en base x: ")
a = input("Ingrese el valor de a: ")
b = input("Ingrese el valor de b: ")
prec = input("Ingrese la presicion deseada: ")
itermax = input("Ingrese las iteraciones máximas deseadas: ")

iter = 0
n = 2;
Iant = 0;
error = prec+1;

while error>prec && n<itermax
[I] = simpson(f,a,b,n);
error = abs(I-Iant);
Iant = I;
n = n+2;

iter=iter+1;
end

disp("El valor de la integral es: ")
vpa(I)

disp("El error obtenido es: ")
vpa(error)


disp("La cantidad de subintervalos es de: ")
n-2
