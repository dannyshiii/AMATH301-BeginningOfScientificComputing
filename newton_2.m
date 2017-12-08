function x_list = newton_2(f,grad_f,x0,tol)

err = tol + 1;
x_list = x0;
x = x0;

while err > tol
    
    y = f(x);
    grad_y = grad_f(x);
    change = grad_y\y;
    x = x - change;
    x_list = [x_list x];
    err = norm(change,2)/norm(x,2);
end