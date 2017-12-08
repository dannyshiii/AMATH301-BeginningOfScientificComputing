function out = f_prime(x)
out = zeros(2,1);
out(1) = 4*(x(1)-1)^3;
out(2) = 4*(x(2)-1)^3;
end