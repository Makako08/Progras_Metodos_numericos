function [root,fx,ea,iter]=bisect(func,xl,xu,es,maxit,varargin) 

if nargin<3,error('se requieren al menos 3 argumentos de entrada'),end %revisa si el usuario ingreso las entradas necesarias
test = func(xl,varargin{:})*func(xu,varargin{:}); 
if test>0,error('no hay cambio de signo'),end %revisa que dentro del intervalo haya algun cambio de signo
if nargin<4|isempty(es), es=0.0001;end 
if nargin<5|isempty(maxit), maxit=50;end %criterio de parada para la cantidad maxima de iteraciones
iter = 0; xr = xl; ea = 100; %se inicia con la iteracion 0, y un error de 100
while (1) %inicia el ciclo para el calculo de la raiz
    xrold = xr; %retiene el valor de xr, lo guarda en 'memoria'
    xr = (xl + xu)/2; % metodo de biseccion
    iter = iter + 1; %contador
    if xr ~= 0,ea = abs((xr - xrold)/xr) * 100;end  %calculo del error
    test = func(xl,varargin{:})*func(xr,varargin{:}); %revisa el signo
    if test < 0 % si es menor a 0 cambia xu por xr
        xu = xr; 
    elseif test > 0 %si es mayor a 0 cambia xl por xr
        xl = xr; 
    else 
        ea = 0; 
    end 
    if ea <= es | iter >= maxit,break,end %criterio de parada cuando se encuentra un error relativo menor
end 
root = xr; fx = func(xr, varargin{:});

%t = 0.05;
%r = 280;
%l = 7.5;
%q = 0.01;


%fc = @(c) (exp((-t/(2*l))*r) * cos(sqrt((1/(l*c)) - (((1/(2*l))^2)*(r)^2)) *(t)))-(q);
