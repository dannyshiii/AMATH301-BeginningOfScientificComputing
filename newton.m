function out = newton(f,f_prime,x0,tol)
err = tol + 1;
x_list = x0;
x = x0;

while err > tol
    change = f(x)/f_prime(x);
    x = x - change;
    x_list = [x_list;x];
    err = abs(change/x);
end
out = x_list(end);

end
