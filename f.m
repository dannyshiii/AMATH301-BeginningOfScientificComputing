function out = f(x)

out = zeros(3,1);
out(1) = 3*x(1) - cos(x(1)*x(2)) - 3/2;
out(2) = 4*x(1)^2 - 625*x(2)^2 + 2*x(3) - 1;
out(3) = 20*x(3) + exp(-x(1)*x(2)) + 9;