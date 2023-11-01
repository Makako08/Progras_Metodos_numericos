function w_z = regresionLineal(Z, w)
    % Realizar una regresión lineal para obtener la función w(z)

    % Asegurarse de que Z y w tienen la misma longitud
    if length(Z) ~= length(w)
        error('Los vectores Z y w deben tener la misma longitud.');
    end

    % Realizar la regresión lineal
    X = [ones(size(Z))', Z'];
    coef = X \ w';

    % Coeficientes de la regresión lineal
    a = coef(2);
    b = coef(1);

    % Función w(z) obtenida de la regresión lineal
    w_z = a * Z + b;
end
