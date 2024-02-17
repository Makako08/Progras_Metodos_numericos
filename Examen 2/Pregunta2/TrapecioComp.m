function [I] = TrapecioComp(f, a, b, n)
    h = (b - a) / n;
    x = a:h:b;
    I = sum(f(x)) - (0.5 * (f(a) + f(b)));
    I = h * I;
end
