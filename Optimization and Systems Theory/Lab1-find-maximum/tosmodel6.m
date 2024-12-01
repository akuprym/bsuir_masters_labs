function y = tosmodel6(x)
    sigma = 0.0001;
    n = length(x);
    if n == 1
        coef = [-5, -80, 3];
        input = [x^2; x; 1];
        y = coef * input;
    else
        tet1 = 1;
        tet2 = [1, 1];
        tet3 = [9, 2; 2, 7];
        y = tet1 + tet2 * x + x' * tet3 * x;
    end
    y = -y;
    y = y + normrnd(0, sigma);
end
