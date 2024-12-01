% Variant 6
pkg load statistics;

a = 1;
b = 4;
n = 100;
sigma = 0.1;
epsilon = 0.001;

x = linspace(a, b, n);

y = zeros(1, n);
for i = 1:n
    y(i) = tosmodel6(x(i)) + normrnd(0, sqrt(sigma));
end

figure;
plot(x, y, '-o', 'LineWidth', 1.5);
title('Графическая иллюстрация');
xlabel('x (входная переменная)');
ylabel('y (выходная переменная)');
grid on;
saveas(gcf, 'maximum.png');

[~, max_index] = max(y);
x_max = x(max_index);
y_max = y(max_index);

hold on;
plot(x_max, y_max, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
legend('Наблюдения', 'Точка максимума', 'Location', 'Best');
text(x_max, y_max, sprintf(' Max (x = %.2f, y = %.2f)', x_max, y_max), 'VerticalAlignment', 'bottom');

% Asymmetric algorithm
max_iter = 100;
a_k = 1 ./ (1:max_iter);
b_k = 1 ./ (1:max_iter).^0.5;
x_k = 0;
results = zeros(1, max_iter);

for k = 1:max_iter
    grad = (tosmodel6(x_k + b_k(k)) - tosmodel6(x_k)) / b_k(k);
    x_k = x_k + a_k(k) * grad;
    results(k) = x_k;
    if norm(grad) < epsilon
        break;
    end; 
end

figure;
plot(1:max_iter, results, 'r', 'LineWidth', 1.5);
title('Несимметричный алгоритм Кифера–Вольфовица');
xlabel('Итерация');
ylabel('Точка x');
grid on;
saveas(gcf, 'asym_algo.png');

% Symmetric algorithm
x_k = 0;
results_sym = zeros(1, max_iter);

for k = 1:max_iter
    grad = (tosmodel6(x_k + b_k(k)) - tosmodel6(x_k - b_k(k))) / (2 * b_k(k));
    x_k = x_k + a_k(k) * grad;
    results_sym(k) = x_k;
    if norm(grad) < epsilon
        break;
    end;
end

figure;
plot(1:max_iter, results_sym, 'g', 'LineWidth', 1.5);
title('Симметричный алгоритм Кифера–Вольфовица');
xlabel('Итерация');
ylabel('Точка x');
grid on;
saveas(gcf, 'sym_algo.png');
