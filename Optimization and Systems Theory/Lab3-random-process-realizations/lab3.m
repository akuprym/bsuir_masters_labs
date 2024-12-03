pkg load statistics;

sigma = 1;
alpha = 0.5;
T = 100;
dt = 0.1;
t_max = 10;
epsilon = 1e-2;

time = 0:dt:(t_max/dt)*dt;

R1 = @(t) sigma^2 * exp(-alpha * abs(t));
R2 = @(t) sigma^2 * (1 + alpha * abs(t)) .* exp(-alpha * abs(t));
R3_prime = @(t) sigma^2 * (1 + alpha * abs(t)) .* exp(-alpha * abs(t));

R_funcs = {R1, R2, R3_prime};  % Массив ковариационных функций
titles = {"r1(t): σ²e^{-α|t|}", ...
          "r2(t): σ²(1 + α|t|)e^{-α|t|}", ...
          "r3'(t): σ²(1 + α|t|)e^{-α|t|}"};

realizations = zeros(3, length(time));

for i = 1:3
    R = R_funcs{i};
    
    Gamma = zeros(length(time), length(time));
    for t1 = 1:length(time)
        for t2 = 1:length(time)
            Gamma(t1, t2) = R(abs((t1-t2)*dt));
        end
    end
    
    Gamma = Gamma + epsilon * eye(length(time));
    
    [L, p] = chol(Gamma, 'lower');
    if p > 0
        fprintf('Матрица Gamma не положительно определённая для функции r%d\n', i);
        disp('Собственные значения матрицы Gamma:');
        disp(eig(Gamma));
        continue;
    end
    
    z = randn(length(time), 1);
    realizations(i, :) = (L * z)';
    
    figure;
    plot(time, realizations(i, :));
    title(['Реализация процесса для ', titles{i}]);
    xlabel('Время t');
    ylabel('X(t)');
    grid on;

    saveas(gcf, ['realization_r' num2str(i) '.png']);

end
