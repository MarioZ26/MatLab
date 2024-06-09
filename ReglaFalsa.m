clear
clc
% Regla Falsa
function ReglaFalsa_solver(f, x0, x1, n_iter, error_porcentual)
    % Convertir error porcentual a decimal
    error_porcentual = error_porcentual / 100;

    % Inicializar variables
    x_anterior = x0;
    x_actual = x1;
    iteraciones = 0;
    error = inf;

    % Crear tabla para almacenar resultados
    tabla = zeros(n_iter, 3);

    % Regla falsa
    while iteraciones < n_iter && error > error_porcentual
        % Calcular x siguiente
        x_siguiente = x_anterior - (f(x_anterior) * (x_actual - x_anterior)) / (f(x_actual) - f(x_anterior));
        
        % Calcular error
        error = abs((x_siguiente - x_actual) / x_siguiente) * 100;
        
        % Actualizar variables
        x_anterior = x_actual;
        x_actual = x_siguiente;
        iteraciones = iteraciones + 1;
        
        % Almacenar resultados en tabla
        tabla(iteraciones, 1) = iteraciones;
        tabla(iteraciones, 2) = x_actual;
        tabla(iteraciones, 3) = error;
    end

    % Mostrar resultados
    fprintf('Solución algebraica: x = %f\n', x_actual);
    fprintf('Error porcentual: %f %%\n', error);

    % Mostrar tabla
    fprintf('Tabla de resultados:\n');
    fprintf('Iteración\tValor de x\tError porcentual\n');
    for i = 1:iteraciones
        fprintf('%d\t%f\t%f %%\n', tabla(i, 1), tabla(i, 2), tabla(i, 3));
    end

    % Graficar función y raíz
    x = -10:0.1:10;
    y = arrayfun(f, x);
    plot(x, y);
    hold on;
    plot(x_actual, f(x_actual), 'ro');
    xlabel('x');
    ylabel('f(x)');
    title('Gráfica de la función y la raíz');
end

% Ingresar datos
fprintf('Ingrese la ecuación (en términos de x): ');
ecuacion = input('f(x) = ','s');
f = @(x) eval(ecuacion);

fprintf('Ingrese el valor inicial x0: ');
x0 = input('');

fprintf('Ingrese el valor inicial x1: ');
x1 = input('');

fprintf('Ingrese el número de iteraciones: ');
n_iter = input('');

fprintf('Ingrese el error porcentual: ');
error_porcentual = input('');

% Llamar a la función ReglaFalsa_solver
ReglaFalsa_solver(f, x0, x1, n_iter, error_porcentual);