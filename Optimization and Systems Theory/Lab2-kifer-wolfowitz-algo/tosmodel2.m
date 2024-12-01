function y = tosmodel2(x)
% The function model for two variables (x1, x2)
% Let's assume that the function model looks like
  % f(x1, x2) = x1^2 + x2^2
  sigma = 0.0001;
  y = x(1)^2 + x(2)^2;
  y = y + normrnd(0, sigma);
end
