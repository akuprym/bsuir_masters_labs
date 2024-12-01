pkg load statistics;

N = 100;
a = 0.9;
sigma_w = 1;
sigma_v = 2;
x0 = 0;

w = normrnd(0, sigma_w, [1, N]);
x = zeros(1, N);
x(1) = x0;
for k = 2:N
    x(k) = a * x(k-1) + w(k);
end

H = 1;
v = normrnd(0, sigma_v, [1, N]);
z = H * x + v;

% Фильтрация Калмана
x_hat = zeros(1, N);
P = zeros(1, N); % дисперсия ошибки
K = zeros(1, N); % к-ты Калмана

x_hat(1) = 0;
P(1) = 1;
Q = sigma_w^2;
R = sigma_v^2;

for k = 2:N
    x_hat_pred = a * x_hat(k-1);
    P_pred = a^2 * P(k-1) + Q;

    % К-т Калмана
    K(k) = P_pred * H / (H * P_pred * H + R);

    % Коррекция
    x_hat(k) = x_hat_pred + K(k) * (z(k) - H * x_hat_pred);
    P(k) = (1 - K(k) * H) * P_pred;
end

figure;
hold on;
plot(1:N, x, 'b', 'DisplayName', 'Реализация процесса');
plot(1:N, z, 'g', 'DisplayName', 'Реализация наблюдений');
plot(1:N, x_hat, 'r', 'DisplayName', 'Оценка фильтрации');
legend;
xlabel('Шаг времени');
ylabel('Значение');
title('Реализация процесса, наблюдений и оценки фильтрации');
grid on;
hold off;

