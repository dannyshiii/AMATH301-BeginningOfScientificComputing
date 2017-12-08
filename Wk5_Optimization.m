% Danni Shi. Week 5: Optimization.
% This is the wrapped-up version of Week 5's materials of
% UW's Amath 301, Beginning of Scientific Computing.
% This does NOT include any detail of my homework.
clear all; close all;

%% Newton's Method
% A simple example
% Key idea: x_(n+1) = x_n - f(x_n)/f'(x_n)
x = linspace(0,1,100); % recall linspace. from 0 to 1, 100 pt
y = @(x) x.*(x-0.25).*(x-0.75);
y_prime = @(x) 3*x.^2 - 2*x + 0.1875;
tol = 1.e-4;
x0 = 0.6;
x_list = x0;
x_ = x0;
err = tol + 1;
while err > tol
    delta = y(x_)/y_prime(x_);
    x_ = x_ - delta;
    x_list = [x_list x_];
    err = abs(delta/x_);
end 
x_list(end); % f(0.75) = 0
% A fun that finds such x (w\ err) is stored in newton.m
% We can use it to optimize a nonlinear problem too
% We want to find the local max/min (0 of the deri)
% Recal local max & min
% local max: 1st deri = 0; 2nd deri < 0
% local min: 1st deri = 0; 2nd deri > 0
x_min = ((-1)*(-2)+sqrt(4-4*3*0.1875))/(2*3);
x_max = ((-1)*(-2)-sqrt(4-4*3*0.1875))/(2*3);
y_prime2 = @(x) 6*x-2;
local_max = newton(y_prime,y_prime2,0.1,1.e-4);
local_min = newton(y_prime,y_prime2,0.5,1.e-4);
% Multidimensional Newton's Method
f = @(x) 1 + (x(1)-1).^4 + (x(2)-1).^4; % f=1+(x-1)^4 +(y-1)^2
% Basic idea
%{ 
f = f_prime;
grad_f = f_prime2;
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
%}
newton_multi = newton_2(@(x) f_prime(x),@(x) f_prime2(x),zeros(2,1),1e-4);
error_multi = sqrt(sum((newton_multi - 1).^2)).';


%% fminsearch
% built-in; can only find the minima; no constraints
clear all; close all; 
x = linspace(0,1,100);
y = @(x) x.*(x-0.25).*(x-0.75);
% X = fminsearch(FUN,X0) starts at X0 and attempts to find a local minimizer 
% X of the function FUN.
fminsearch(y,0.5); % 0.5538, x_min
x_min = ((-1)*(-2)+sqrt(4-4*3*0.1875))/(2*3);
x_max = ((-1)*(-2)-sqrt(4-4*3*0.1875))/(2*3);
fminsearch(@(x) -y(x), 0.1); % 0.1129, x_max, min of opposite!
f = @(x) 1 + (x(1)-1).^4 + (x(2)-1).^4;
fminsearch(f,[0.5;0.5]); % 0.9999; 1.0000
a = 1:24;
b = [75 77 76 73 69 68 63 59 57 55 54 52 50 50 49 49 49 50 54 56 59 63 67 72];
% plot(x,y,'ko'), hold on;
C = 62; A = 13; B = 2*pi/24; % init guess w\ 24*B=2*pi
f=A*cos(B*x)+C; % plot(x,f,'m'),hold on;
coeff=fminsearch('datafit',[A B C],[],x,y); %  'datafit' finds error
A1 = coeff(1); B1 = coeff(2); C1 = coeff(3);
f2 = A1*cos(B1*x)+C1; % plot(x,f2,'g');


%% Line Programming (great for linear func)
% x = linprog(f,A,b) solves min f'*x such that A*x ? b
% linprog(-f,A,b) solves max ... I'll use the example from lect here
%Problem: It is December, 1943. You have been briefed about the proposed
%D-Day landings in June 1944, and have been asked to place orders to an
%Higgins Industries for landing crafts.
%The general has remarked to you that a single tank landed on the beaches
%is worth 72 infantrymen.
%A single infantry landing craft carries 36 men. An armoured landing craft
%can carry a single tank.
%An infantry landing craft requires 7 days of construction, 5 days for
%armouring, and 3 days for delivery. An armoured landing craft requires 8
%days of construction, 10 days for armouring, and 4 days for delivery.
%Higgins Industries can afford, across their many factories, 2000 days of
%construction, 1000 days of armouring, and 700 days of delivery.
%How many infantry and armoured landing crafts should be constructed to
%maximize the delivered fighting force?
%We could also introduce cost and try to optimize the cost alongside the
%fighting strength.
%I = number of infantry carriers; A = number of armoured carriers
%Maximize: 36*I + 72*A => f = -[36;72]
%Construction: 7*I + 8*A  <= 2000
%Armouring:    5*I  + 10*A <= 1000
%Delivery:     3*I  + 4*A  <= 700
%Positivity:   I  >= 0, A >= 0
A = [7 8; 5 10; 3 4; -1 0; 0 -1];
b = [2000; 1000; 700; 0; 0];   
f = [36; 72]; f = (-1)*f;
linprog(f,A,b); % I: 147.6606, A: 26.1697


%% Lagrange's Method
% Basic idea: H(x,y,lambda)=F(x,y)+lambda*g(x,y)
y = @(x) 3*x(1) - 4*x(2) + x(3) - 2*x(4);
%constraint 1: -x(2)^2 + x(3)^2 + x(4)^2 = 1
%constraint 2: 3*x(1)^2 + x(3)^2 + 2*x(4)^2 = 6
%gradient function: G; gradient of gradient: DG
result = newton_2(@(x) G(x),@(x) DG(x),ones(6,1),1e-4)
y(result(:,end));
G(result(:,end)); % x(1) - x(6) & lambda1 lambda2
%Newton's method with lagrange's method works great for nonlinear
%constraints and objective functions! Still requires the usual close guess
%to get convergence to right zero (if any)