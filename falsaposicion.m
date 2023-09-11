function[xr,error,n]=falsaposicion()
syms x;
f=input('ingrese la funcion en base x: ')
xl= input('Ingrese el valor de xl: ')
xu= input('Ingrese el valor de xu: ')
es= input('Ingrese el error relativo deseado: ')
maxit= input('Ingrese el numero maximo de iteraciones: ')

fxl=subs(f,'x',xl);
fxu=subs(f,'x',xu);
if fxl*fxu>0
    disp('El intervalo no contiene la raiz')
    xr='nd';
    error='nd';
    n=0;
    return
end

for n=1:maxit
    xr(n) = xu-((fxu*(xl-xu))/(fxl-fxu));
    xr(n) = double(xr(n));
    fxr=subs(f,'x',xr(n));
    if fxl*fxr<0
        xu=xr(n);
        fxu=fxr;
    else
        xl=xr(n);
        fxl=fxr;
    end
    if n>1
        error=abs(xr(n)-xr(n-1));
        if error < es
            break
        end
    end
end