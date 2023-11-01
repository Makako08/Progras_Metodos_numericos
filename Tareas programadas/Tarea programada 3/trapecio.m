function[I]=trapecio(f,a,b,n)

    h=(b-a)/n;
    suma=0;

    fa=subs(f,'x',a);
    fb=subs(f,'x',b);

    for i=1:n-1
        xi=a+i*h;
        fxi=subs(f,'x',xi);
        suma = suma + (2*fxi);
    end

    I=(h/2)*(suma+fa+fb);
end
