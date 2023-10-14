function[I]=simpson(f,a,b,n)
    suma = 0;
    h =(b-a)/n;
    fa = subs(f,"x",a);
    fb = subs(f,"x",b);

    for i=1:n-1
        if mod(i, 2) == 0
            xi = a+(h*i);
            fxi = subs(f,"x",xi);
            suma = suma + 2*fxi;
        elseif mod(i, 2) ~= 0
            xi = a+(h*i);
            fxi = subs(f,"x",xi);
            suma = suma + 4*fxi;            
        end
    end
    
    I = (h/3)*(fa+suma+fb);

end
