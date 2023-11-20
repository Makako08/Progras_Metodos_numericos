function[I]=simpson(f,a,b,n)

    h=(b-a)/n;
    suma=0;

    fa=subs(f,'x',a);
    fb=subs(f,'x',b);

    for i=1:n-1
        xi=a+i*h;
        fxi=subs(f,'x',xi);
        if mod(i,2) == 0 %pares
            suma = suma + (2*fxi);
        else %impares
            suma = suma + (4*fxi);
        end
    end

    I=(h/3)*(suma+fa+fb);
end
