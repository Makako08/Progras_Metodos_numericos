function I = SimpsonComp(f, a, b, n)
    h = (b - a) / n;  % Ancho de cada subintervalo
    x = a:h:b;  % Puntos de evaluación
    y = feval(f, x);  % Valores de la función en los puntos de evaluación
    
    I = 0;
    
    for i = 1:2:n-1
        I = I + y(i) + 4 * y(i+1) + y(i+2);
    end
    
    I = h / 3 * I;
end