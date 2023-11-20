function w_z = regresionLineal(Z, w)
    % Realizar una regresi�n lineal para obtener la funci�n w(z)

    % Asegurarse de que Z y w tienen la misma longitud
    if length(Z) ~= length(w)
        error('Los vectores Z y w deben tener la misma longitud.');
    end

    % Realizar la regresi�n lineal
    X = [ones(size(Z))', Z'];
    coef = X \ w';

    % Coeficientes de la regresi�n lineal
    a = coef(2);
    b = coef(1);

    % Funci�n w(z) obtenida de la regresi�n lineal
    w_z = a * Z + b;
end
