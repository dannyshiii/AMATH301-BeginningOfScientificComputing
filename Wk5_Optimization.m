clear all; close all; clc;
% Week 5: Optimization

% Newton's Method
% Recall single variable Taylor Series
x = linspace(0,1,100); % recall linspace. from 0 to 1, 100 pt
y = @(x) x.*(x-0.25).*(x-0.75);
% plot(x,y(x));
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
x_list(end); % 0.75

% I will later submit a function of newton.m
solv = x_list;
%plot(x,y(x)), hold on;
%plot(0.75, y(0.75), 'ro');
%for j = 1:length(solv)
%    hold on;
%    plot(solv(j),y(solv(j)),'m.');
%    pause(0.3);
%end  

% We can use it to optimize a nonlinear problem too
% We want to find the local max/min (0 of the deri)
x_max = ((-1)*(-2)+sqrt(4-4*3*0.1875))/(2*3);
x_min = ((-1)*(-2)-sqrt(4-4*3*0.1875))/(2*3);
y_prime2 = @(x) 6*x-2;
local1 = newton(y_prime,y_prime2,0.1,1.e-4);
local_min = local1(end);
local2 = newton(y_prime,y_prime2,0.5,1.e-4);
local_max = local2(end);

% Multidimensional Newton's Method
f = @(x) 1 + (x(1)-1).^4 + (x(2)-1).^4;
temp = zeros(2,1);
temp(1) = -4 * (x(1)-1)^3;
temp(2) = -4 * (x(2)-1)^3;
f_prime =@(x) temp;
temp2 = zeros(2);
temp2(1,1) = -12 * (x(1)-1)^2;
temp2(2,2) = -12 * (x(2)-1)^2;
f_prime2 = @(x) temp2;
x0 = zeros(2,1);
err = tol + 1;
x_list = x0;
x_ = x0;
while err > tol
    y = f_prime(x_);
    grad_y = f_prime2(x_);
    delta = grad_y\y;
    x_ = x_ - delta;
    x_list = [x_list x_];
    err = norm(delta, 2) / norm(x_, 2);
end    
% Ok there's something wrong here, I'll come back later
error = sqrt(sum((x_list - 1).^2)).';


% fminsearch
% it can only find the minimal
clear all; close all; clc;
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




% NOT FINISHED!
% NOT FINISHED!
% I SHOULD REMIND MYSELF TO HAVE THIS ONE UPDATED!
