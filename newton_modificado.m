% Limpiamos la pantalla y mostramos el nombre del método
clear
clc
disp('Método de Newton Raphson')

% Damos de alta la variable simbólica X
syms x

% Introducimos la función, el punto de inicio, así como porcentaje de error
f = input('Introduzca la función f(x):', 's'); % Se añade 's' para que se trate como cadena
pi = input('Introduzca el punto de inicio:');
err = input('Porcentaje de error:');

% Convertimos la función a simbólica
f_sym = str2sym(f);

% Graficamos la función
figure;
ezplot(f_sym)
grid on
title('Gráfica de la función y la raíz aproximada')
hold on

% Calculamos la derivada de la función
d_sym = diff(f_sym);

% Convertimos las funciones a inline para cálculos numéricos
f = matlabFunction(f_sym);
d = matlabFunction(d_sym);

% Inicializamos variables
ea = 100;
j = 0;
tabla = []; % Inicializamos una tabla vacía para almacenar los resultados de las iteraciones

% Método de Newton-Raphson
while ea > err
    % Aproximamos la raiz con la fórmula correspondiente
    xi = pi - (f(pi) / d(pi));
    % Calculamos el porcentaje de error
    ea = abs(((xi - pi) / xi) * 100);
    % Guardamos los valores en la tabla
    tabla = [tabla; j, pi, xi, f(pi), ea]; %#ok<AGROW>
    % Actualizamos el valor de pi
    pi = xi;
    % Incrementamos el contador de iteraciones
    j = j + 1;
end

% Mostramos los resultados en pantalla (con 3 decimales)
fprintf('\nRaiz= %10.3f en %d Iteraciones\n', pi, j)

% Mostramos los resultados en forma de tabla
disp('Iteraciones | xi | xi+1 | f(xi) | Error')
disp(array2table(tabla, 'VariableNames', {'Iteraciones', 'xi', 'xi1', 'f_xi', 'Error'}))

% Marcamos la raíz en la gráfica
f_val_pi = double(subs(f_sym, x, pi));
plot(double(pi), f_val_pi, 'ro')

% Solución algebraica
fprintf('La derivada de la función es: ')
disp(d_sym)
fprintf('La ecuación iterativa es: ')
disp(x - (f_sym/d_sym))

% Resultados en forma gráfica
figure;
ezplot(f_sym)
hold on
grid on
plot(double(pi), f_val_pi, 'ro')
title('Gráfica de la función con la raíz aproximada')
xlabel('x')
ylabel('f(x)')
legend('f(x)', 'Raíz aproximada')
hold off
