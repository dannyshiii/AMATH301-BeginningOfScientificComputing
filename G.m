function grad = G(x)

x1 = x(1);
x2 = x(2);
x3 = x(3);
x4 = x(4);
lambda1 = x(5);
lambda2 = x(6);

grad = zeros(6,1);
grad(1) = 3 + 6*lambda2*x1;
grad(2) = -4 - 2*lambda1*x2;
grad(3) = 1 + 2*lambda1*x3 + 2*lambda2*x3;
grad(4) = -2 + 2*lambda1*x4 + 4*lambda2*x4;
grad(5) = -x2^2 + x3^2 + x4^2-1;
grad(6) = 3*x1^2 + x3^2 + 2*x4^2-6;