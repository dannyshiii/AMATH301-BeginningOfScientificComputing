clear all;
close all;
% This is my review for AMATH 301, Week 3's materials, Iterative Methods

% Jacobi Iteration
% First, Danni's Blah-Blah-Blah explainations of logistics
% It only works under the Strict Diagonal Dominance SDD:
% The numbers on the diagonal must have the largest ABS in the row
% E.g., 4x-y+z=7; 4x-8y+z=-21; -2x+y+5z=15
% x=(y-z+7)/4; y=(4x+z+21)/8; z=(2x-y+15)/5
% x_(k+1)=(y_k - z_k + 7)/4
% y_(k+1)=(4x_k + z_k + 21)/8
% z_(k+1)=(2x_k -y_k +15)/5
% x_(k+1)=Mx_k +b_2
% M1=[ 0 1/4 -1/4; 1/2 0 1/8; 2/5 -1/5 0]; 
% b=[7/4 21/8 15/5 15/5];
% x0 can be an initial guess

% Ok so how do we do it in MATLAB?
% A*x=b
% A = D + T; D: diagonal; T: everything else
% D*x + T*x = b; D*x = -T*x +b
% => x_(k+1) = -inv(D)*T*x_k + inv(D)*b
% aka x_(k+1) = -D\T*x_k + D\b
% And the error e_(k+1) = -D\T*e_k

% Here is a basic version
A = [3 1 -1;0 5 2; -3 -1 12];
b = [3;1;-5];
D = diag(diag(A));
T = A - D;
tol = 1.e-6;
err = 1;
while err > tol
    it = it + 1;
    x = D\b - D\(T*x);
    err = norm(A*x - b);
end


% It can't always work!
% We also have to make sure the abs(eigenvalue)<1
% Recall eigenvalue: A*x = lambda*x
% det(A-I*lambda)=0
[evec,lambda] = eig(A);
% x_(k+1) = A*x_k = lambda * x_k;
% Previously we have x_(k+1)=-D\T*x_k + D\b
% So now we have to make sure:
% 1) A follows the rule of SDD
% 2) norm(eig(-D\T),inf) < 1

x_ini = ones(3,1);
[x_out,iter]=jacobi(A,b,x_ini,tol);
% I'll submit a function of jacobi


% Another iterative method is Gauss-Seidel
% It's similar to Jacobi's method but it's even faster
% (I'll use L O here, diff from the lecture, because I like it this way
% A = L + O with L: lower triangular portion of A; O: elsewhere
% x_(k+1) = -inv(L)*O*x_k + inv(L)*b
% Or x_(k+1) = -L\O*x_k + L\b
% e_(k+1) = -inv(L)*T*e_k
% Its eigenvalue: eig(-L\O), it's smaller than eig(-D\T)
L = tril(A); % tril: lower triangular portion
O = A - L;
err = tol + 1;
x_init = ones(3,1);
x = x_init;
iterations = 0;
while err > tol
    iterations = iterations + 1;
    x = L\b - L\(T*x);
    err = norm(A*x - b);
end
% Again I'll submit a seperate gauss_seidel function
[x_out,iter] = gauss_seidel(A,b,x_init,tol);