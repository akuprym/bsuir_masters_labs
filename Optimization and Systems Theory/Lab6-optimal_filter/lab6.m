pkg load statistics;

N = 100;
mu = [0; 0];
sigma = [1 0.5; 0.5 1];

v = mvnrnd(mu, sigma, N);

% Динамическая модель: x_k = A * x_(k-1) + w_k
A = [0.9 0.3; -0.2 0.7];
Q = 0.01 * eye(2);
x = zeros(N, 2);
x(1, :) = [0.5, -0.5];

for k = 2:N
    x(k, :) = A * x(k-1, :)' + mvnrnd([0; 0], Q)';
end

% Наблюдения z_k = H * x_k + r_k
H = [1 0; 0 1];
R = 0.1 * eye(2);
z = zeros(N, 2);
for k = 1:N
    z(k, :) = H * x(k, :)' + mvnrnd([0; 0], R)';
end

% Фильтрация Калмана
x_est = zeros(N, 2);
P = eye(2);

for k = 2:N
    x_pred = A * x_est(k-1, :)';
    P_pred = A * P * A' + Q;
    
    % Обновление
    K = P_pred * H' / (H * P_pred * H' + R); % К-т Калмана
    x_est(k, :) = (x_pred + K * (z(k, :)' - H * x_pred))';
    P = (eye(2) - K * H) * P_pred;
end

figure;
subplot(2,1,1);
plot(1:N, x(:,1), 'g', 1:N, z(:,1), 'b', 1:N, x_est(:,1), 'r--');
title('Первая координата');
legend('Истинное состояние', 'Наблюдения', 'Оценка фильтра');

subplot(2,1,2);
plot(1:N, x(:,2), 'g', 1:N, z(:,2), 'b', 1:N, x_est(:,2), 'r--');
title('Вторая координата');
legend('Истинное состояние', 'Наблюдения', 'Оценка фильтра');

