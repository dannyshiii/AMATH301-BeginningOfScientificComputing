function grad_grad = DG(x)

x1 = x(1);
x2 = x(2);
x3 = x(3);
x4 = x(4);
lambda1 = x(5);
lambda2 = x(6);


grad_grad = zeros(6,6);

grad_grad(1,1) = 6*lambda2;
grad_grad(1,6) = 6*x1;
grad_grad(2,2) = -2*lambda1;
grad_grad(2,5) = -2*x2;
grad_grad(3,3) = 2*lambda1 + 2*lambda2;
grad_grad(3,5) = 2*x3;
grad_grad(3,6) = 2*x3;
grad_grad(4,4) = 2*lambda1 + 4*lambda2;
grad_grad(4,5) = 2*x4;
grad_grad(4,6) = 4*x4;
grad_grad(5,2) = -2*x2;
grad_grad(5,3) = 2*x3;
grad_grad(5,4) = 2*x4;
grad_grad(6,1) = 6*x1;
grad_grad(6,3) = 2*x3;
grad_grad(6,4) = 4*x4;