% Week 6: Numerical Differentiation and Integration
clear all; close all;
%% Forward and Backward
% First Order Accuracy
dt = .1;
t = -2:dt:4;
f = sin(t);
dfdt = cos(t); % Exact Derivative
plot(t,f,'k--','LineWidth',1.2), hold on, grid on;
plot(t,dfdt,'k','LineWidth',3), hold on;
l1 = legend('Function','Exact Derivative');
% Forward Difference Approximation: f'(x_i)=(y_(i+1)-y_i)/(x_(i+1)-x_i)
dfdtF = (sin(t+dt)-sin(t))/dt;
% Backward: f'(x_i)=(y_i-y_(i-1))/(x_i-x_(i-1))
dfdtB = (sin(t)-sin(t-dt))/dt;
% Second Order Accuracy
% Central: f'(x_i)=(y_(i+1)-y_(i-1))/2h
dfdtC = (sin(t+dt)-sin(t-dt))/(2*dt);
%plot(t,dfdtF,'r','Linewidth',1.2), hold on;
%plot(t,dfdtB,'g','Linewidth',1.2), hold on;
%plot(t,dfdtC,'b','Linewidth',1.2), grid on;
%l2 = legend('Function','Exact Deri','Forward','Backward','Central');
%set(l2,'FontSize',14);
%axis([-2 4 -1.5 1.5]);
x = 0.1:.1:3;
f = sin(x);
%plot(x,f,'k'), hold on;
%plot(x,f,'rx','LineWidth',2);
dx = x(2) - x(1);
n = length(f);
dfdx = zeros(n,1);
dfdx(1) = (f(2)-f(1))/(x(2)-x(1)); % forward diff at f(x_1)
for j = 2:(n-1)
    dfdx(j) = (f(j+1)-f(j-1))/(x(j+1)-x(j-1)); % central in the middle
end
dfdx(n) = (f(n)-f(n-1))/(x(n)-x(n-1)); % backward diff at f(x_n)
% at start point
% f'(x1)=(-3f(x1)+4f(x2)-f(x3))/2h + O(h^2)
% at end point
% f'(xn)=(3f(xn)-4f(x_n-1)+f(x_n-2))/2h + O(h^2)


%% Numerical Integration
% Riemann Left Sums
clear all; close all; 
a = 0; b = 10; dxf = 0.01;
xf = a:dxf:b; yf = sin(xf);
% plot(xf,yf,'k'), hold on;
dxc = .1; xc = a:dxc:b; yc = sin(xc);
% stairs(xc,yc,'r');
n = length(xc);

% left-rectangle rule
area1 = 0;
for j = 1:n-1
    area1 = area1 + yc(j)*dxc;
end
area1; % 1.9366 when dxc = .5; 1.8647 when = .1
% right-rectangle rule
area2 = 0;
for j = 1:n-1
    area2 = area2 + yc(j+1)*dxc;
end
area2; % 1.6646 when dxc = .5; 1.8103 when = .1

% trapezoid rule
area3 = 0;
for j = 1:n-1
    area3 = area3 + (dxc/2)*(yc(j)+yc(j+1));
end
area3_ = trapz(xc,yc); % same!
% Without for loops
area1 = sum(yc(1:end-1))*dxc;
area2 = sum(yc(2:end))*dxc;
area3 = trapz(xc,yc);
% same in xf, yf, fine grid
% Simpsons: quad, requires function handle
func = @(x) sin(x);
area4 = quad(@(x) sin(x),a,b);