%subs(f,"x",valor_a_evaluar)

function[I]=Trapecio(f,a,b,n)

    suma = 0;
    h =(b-a)/n;
    fa = subs(f,"x",a);
    fb = subs(f,"x",b);

    for i=1:n-1
        xi = a+(h*i);
        fxi = subs(f,"x",xi);
        suma = suma + 2*fxi;
    end
    
    I = (h/2)*(fa+suma+fb);
    
    
end