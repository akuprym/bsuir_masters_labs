pkg load statistics;

n = 100;
dim = 2;

A = [0.7, 0.2; 0.1, 0.8];
Q = [0.1, 0.02; 0.02, 0.1];
mean_x0 = [0; 0];
cov_x0 = [1, 0; 0, 1];

x = zeros(n, dim);
x(1, :) = mvnrnd(mean_x0, cov_x0);

noise = mvnrnd([0, 0], Q, n);

for k = 2:n
    x(k, :) = (A * x(k-1, :)')' + noise(k, :);
end

figure;
plot(1:n, x(:, 1), 'DisplayName', 'Компонента x1'); hold on;
plot(1:n, x(:, 2), 'DisplayName', 'Компонента x2');
title('Гауссовская марковская случайная последовательность');
xlabel('Временной шаг');
ylabel('Значение');
legend('show');
grid on;
