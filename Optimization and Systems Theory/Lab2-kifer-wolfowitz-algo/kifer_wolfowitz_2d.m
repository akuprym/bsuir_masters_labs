pkg load statistics;

function [x_vals, y_vals] = kifer_wolfowitz_2d(max_iter)

  x1 = 1.0;
  x2 = 1.0;
  alpha = 0.1;
  epsilon = 0.001;

  x_vals = [x1];
  y_vals = [x2];
  
  for k = 1:max_iter
    f_val = tosmodel2([x1, x2]);
    grad_x1 = (tosmodel2([x1 + epsilon, x2]) - f_val) / epsilon;
    grad_x2 = (tosmodel2([x1, x2 + epsilon]) - f_val) / epsilon;
    
    grad = [grad_x1; grad_x2];
    
    x1 = x1 + alpha * grad(1);
    x2 = x2 + alpha * grad(2);
    
    x_vals = [x_vals, x1];
    y_vals = [y_vals, x2];
    
    if norm(grad) < epsilon
        break;
    end
  end
end

[x_vals, y_vals] = kifer_wolfowitz_2d(100);

figure;
plot(x_vals, y_vals, '-o');
title('Траектория поиска максимума функции');
xlabel('x1');
ylabel('x2');
grid on;
