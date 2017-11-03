function [x_out, iter] = gauss_seidel(A,b,x_init,tol)
L = tril(A);
O = A - L;
eigval = eig(-L\O);
if norm(eigval,inf)>1
    error('Iteration cannot converge.');
end
iter = 1;
err = tol + 1;
x_out = x_init;
while err > tol
    x_out(:,iter+1)=-L\(O*x_out(:,iter))+L\b;
    err = norm(x_out(:,iter+1)-x_out(:,iter),inf);
    iter = iter + 1;
end
iter = iter - 1;
end