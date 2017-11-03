clear all;
close all;
% This is my review for AMATH 301, Week 2's materials
% Linear Systems of Equations

% Most basic one
% based on Gaussian Elimination
A = [2 1 3
    2 6 8
     6 8 18];
b = [1;3;5];
tic;
x = A\b; 
time = toc; % shows how long it takes to solve it
% Ya can't do this when A is singular.
% Singular? det(A) = 0

% When the size of A is large and A is sparse,
% it can be annoyingly slow to solve
cond(A); 
% condition numbers give us an idea of how hard a matrix will be to solve -
% the smaller the better
% total calculation: O(N^3)

norm(A); % 2-norm of A
v = A(1,:);
norm(v, Inf); % returns the largest element of ABS(v)

% Some Linear Algebra Review
% A: n*m
% n>m: overdetermined; no sol
% n<m: underdetermined; inf sol

% Solve A*x=b when A is upper triangular? Back substitution
% Lower triangular? Forward substitution
% Symmetric? Holesky factorization
% Hessenberg(what I call 'almost triangular')? Upper triangular form


% LU factorization
% Logistics
% A = [a11 a12 a13;a21 a22 a23;a31 a32 a33];
% A = L*U with
% L = [1 0 0;m21 1 0; m31 m32 0];
% U = [u11 u12 u13;0 u22 u23;0 0 u33];
% A*x=b => L*U*x=b
% Let U*x=y, L*y=b
% When I know L, U, total calculation is O(N^2)
A = [5 -1 2;10 3 7;15 17 19];
[L,U] = lu(A); % not the same LU as what we do in hand calculation
L*U;
[L_new,U_new,P] = lu(A); % P: pivot
P*L_new; % same as L
b = [1;1;1];
[L,U,P] = lu(A);
A\b;
c = L\(P*b);
x = U\c;
x = U\(L\(P*b));
% That's it!
