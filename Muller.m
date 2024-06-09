% Limpiar datos
clear
clc

% Solicitar al usuario que ingrese la ecuación
eq_str = input('Ingrese la ecuación en términos de x (2*x^3 - 4*x^2 + 3*x - 6): ', 's');
f = str2func(['@(x)' eq_str]);

% Solicitar al usuario que ingrese los valores iniciales
x0 = input('Ingrese el valor inicial x0: ');
x1 = input('Ingrese el valor inicial x1: ');
x2 = input('Ingrese el valor inicial x2: ');

% Número máximo de iteraciones
max_iter = input('Ingrese el número máximo de iteraciones: ');

% Error porcentual
error_porcentual = input('Ingrese el error porcentual deseado: ');

% Rango para graficar la función
x_range = linspace(-10, 10, 1000); % Cambia el rango según sea necesario

% Implementación del método de Muller
for i = 1:max_iter
    % Cálculo de la nueva aproximación
    h1 = x1 - x0;
    h2 = x2 - x1;
    delta1 = (f(x1) - f(x0)) / h1;
    delta2 = (f(x2) - f(x1)) / h2;
    a = (delta2 - delta1) / (h2 + h1);
    b = a*h2 + delta2;
    c = f(x2);
    radicando = b^2 - 4*a*c;
    if radicando >= 0
        radicando = sqrt(radicando);
        if abs(b + radicando) > abs(b - radicando)
            den = b + radicando;
        else
            den = b - radicando;
        end
        dxr = -2 * c / den;
    else
        dxr = -2 * c / (b + sqrt(b^2 - 4*a*c));
    end
    
    % Nueva aproximación
    x3 = x2 + dxr;
    error = abs((x3 - x2) / x3) * 100;
    
    % Imprimir resultados
    fprintf('Iteración %d: x = %.8f, Error = %.8f%%\n', i, x3, error);
    
    % Verificar convergencia
    if error < error_porcentual
        fprintf('Raíz encontrada en la iteración %d: %.8f\n', i, x3);
        break;
    end
    
    % Actualizar valores para la siguiente iteración
    x0 = x1;
    x1 = x2;
    x2 = x3;
end

% Graficar la función
figure;
plot(x_range, arrayfun(f, x_range));
hold on;
plot(x3, f(x3), 'ro'); % Marcar la raíz encontrada en rojo
xlabel('x');
ylabel('f(x)');
title('Gráfico de la función');

