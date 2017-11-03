function [x_out,iter] = jacobi(A,b,x_ini,tol)
D = diag(diag(A));
T = A - D;

eigvec = eig(-D\T);
if norm(eigvec, inf) > 1
    error('The eigen value is greater than 1 and the method cannot converge.');
end

err = 1; % or err = tol +1 to guarantee it initially > tolerance
iter = 1;
x_out = x_init;
while err > tol
    x_out(:,iter+1)= -D\T*x_ini(:,iter) + D\b;
    err = norm(x_out(:,iter+1)-x_out(:,iter),inf);
    iter = iter + 1;
end
iter = iter - 1;

end