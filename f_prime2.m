function out = f_prime2(x)
out = zeros(2,2);
out(1,1) = 12*(x(1)-1)^2;
out(2,2) = 12*(x(2)-1)^2;
end