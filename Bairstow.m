clear

function bairstow_method()
    % Pedir al usuario los datos del polinomio y parámetros iniciales
    coef = input('Introduce los coeficientes del polinomio (ej. [1 -3 2 -1 1]): ');
    r = input('Introduce el valor inicial para r: ');
    s = input('Introduce el valor inicial para s: ');
    max_iter = input('Introduce el número máximo de iteraciones: ');
    tol = input('Introduce el error porcentual deseado: ');

    % Algoritmo de Bairstow
    n = length(coef) - 1;  % Grado del polinomio
    roots = [];
    iteration = 0;
    while n > 2 && iteration < max_iter
        fprintf('Iteración %d: r = %.6f, s = %.6f\n', iteration + 1, r, s);
        [r, s, err_r, err_s] = bairstow_iteration(coef, r, s);
        iteration = iteration + 1;
        
        if max(err_r, err_s) < tol
            fprintf('Error r: %.6f, Error s: %.6f\n', err_r, err_s);
            % Encontrar las raíces del polinomio cuadrático r^2 + sr + q
            delta = sqrt(s);
            root1 = (r + delta) / 2;
            root2 = (r - delta) / 2;
            roots = [roots, root1, root2];
            fprintf('Raíces encontradas: %.6f, %.6f\n', root1, root2);
            
            % Dividir el polinomio original por el polinomio cuadrático encontrado
            [coef, n] = deflate_poly(coef, r, s);
            
            % Reiniciar r y s
            r = 0;
            s = 0;
        end
    end
    
    % Encontrar raíces restantes si el polinomio reducido es de grado <= 2
    if n == 2
        delta = sqrt(coef(2)^2 - 4*coef(1)*coef(3));
        root1 = (-coef(2) + delta) / (2*coef(1));
        root2 = (-coef(2) - delta) / (2*coef(1));
        roots = [roots, root1, root2];
    elseif n == 1
        roots = [roots, -coef(2) / coef(1)];
    end

    % Mostrar resultados
    fprintf('Raíces encontradas:\n');
    disp(roots');

    % Solución en forma algebraica
    fprintf('Forma algebraica del polinomio: ');
    syms x;
    poly_expr = poly2sym(coef, x);
    disp(poly_expr);

    % Solución gráfica
    figure;
    fplot(@(x) polyval(coef, x), [-10, 10]);
    hold on;
    plot(real(roots), imag(roots), 'ro');
    hold off;
    title('Gráfica del polinomio y sus raíces');
    xlabel('x');
    ylabel('P(x)');
    grid on;

    % Solución en forma de tabla
    root_table = table((1:length(roots))', roots', 'VariableNames', {'Índice', 'Raíz'});
    disp(root_table);
end

function [r, s, err_r, err_s] = bairstow_iteration(coef, r, s)
    n = length(coef) - 1;
    b = zeros(1, n + 1);
    c = zeros(1, n + 1);
    b(n+1) = coef(n+1);
    b(n) = coef(n) + r*b(n+1);
    for i = n-1:-1:1
        b(i) = coef(i) + r*b(i+1) + s*b(i+2);
    end
    c(n+1) = b(n+1);
    c(n) = b(n) + r*c(n+1);
    for i = n-1:-1:1
        c(i) = b(i) + r*c(i+1) + s*c(i+2);
    end
    det = c(3)*c(3) - c(2)*c(4);
    dr = (-b(2)*c(4) + b(1)*c(3)) / det;
    ds = (-b(1)*c(2) + b(2)*c(3)) / det;
    r = r+ dr;
    s = s + ds;
    err_r = abs(dr / r) * 100;
    err_s = abs(ds / s) * 100;
end

function [coef, n] = deflate_poly(coef, r, s)
    n = length(coef) - 1;
    b = zeros(1, n + 1);
    b(n+1) = coef(n+1);
    b(n) = coef(n) + r*b(n+1);
    for i = n-1:-1:1
        b(i) = coef(i) + r*b(i+1) + s*b(i+2);
    end
    coef = b(3:end);
    n = n - 2;
end

% Ejecutar la función principal
bairstow_method();