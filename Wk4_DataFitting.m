clear all;
close all;

% First, blah blah blah again
% maximum error: most easily affected by outliers
% average error
% but we use root-mean square LSQ

% x pts, x-1 degree polynomial :)

% E.g., f(x) = A*x + B
% err = sum(abs(f(x_k)-y_k).^2)
% to get min error,dErr/dA = 0, dErr/dB = 0
% You do know some calculus right? :)
x = 0:0.1:1;
y = [1.19, 2.04, 3.40, 3.02, 2.03, 1.77, 1.76, 0.84, 1.44, 1.85, 4.11];
A = zeros(2,2);
A(1,1) = sum(x.^2);
A(1,2) = sum(x);
A(2,1) = sum(x); 
A(2,2) = 11;
b = zeros(2,1);
b(1) = sum(x.*y);
b(2) = sum(y);
coeffs = A\b
y_linear = x*coeffs(1) + coeffs(2);
plot(x,y,'.'), hold on;
plot(x,y_linear,'r');
linear_error = sum((y_linear - y).^2);

% E.g., same method in quadratic form
A_quad = zeros(3,3);
A_quad(1,1) = sum(x.^4);
A_quad(1,2) = sum(x.^3);
A_quad(2,1) = sum(x.^3);
A_quad(2,2) = sum(x.^2);
A_quad(3,1) = sum(x.^2);
A_quad(1,3) = sum(x.^2);
A_quad(2,3) = sum(x);
A_quad(3,2) = sum(x);
A_quad(3,3) = 11; 
b_quad = zeros(3,1);
b_quad(1) = sum(x.^2.*y);
b_quad(2) = sum(x.*y);
b_quad(3) = sum(y);
coeffs_quad = A_quad\b_quad
y_quad = x.^2*coeffs_quad(1) + x*coeffs_quad(2) + coeffs_quad(3);
plot(x,y_quad,'g') ;
quad_error = sum((y_quad - y).^2);

% Ahhhh I'm tired!!!!!
% And I'm lazy!!!!!!!!
% What am I gonna do??
% polyfit(x,y,degree/power)
coeffs_1 = polyfit(x,y,1);
coeffs_2 = polyfit(x,y,2);
% polyval(your coeff, x)
y_1 = polyval(coeffs_1,x);
y_2 = polyval(coeffs_2,x);

% This is not covered in the lecture but covered in the video
% Data linearization
x = 0:0.5:10;
n = length(x);
y = 2*exp(x)+rand(1,n);
Y = log(y);
X = x; % now Y and X have linear relationship
coeff_exp = polyfit(X,Y,1);
X_22 = 10+0.5;
Y_22 = polyval(coeff_exp,x_22);


% Polynomial Fits
% interpolation: get a data pt where u don't have a data pt
% extrapolation: get a prediction outside my data
% spz we wanna REQUIRE our curve go through the data pts, 
% but that it connect them in some sort of coherent way

%we input data points x and y along with the points at which we want to
%evaluate!

x_grid = 0:0.01:1;

y_linear = interp1(x,y,x_grid,'linear')
hold on
plot(x_grid,y_linear,'b')
%what does this remind you of? The default plotting!
%default plotting uses linear interpolation to go between data points

%there are other interpolation options:
y_nearest = interp1(x,y,x_grid,'nearest')
close
plot(x,y,'.')
hold on
plot(x_grid,y_nearest,'r')
%this interpolation method, for a given evaluation point, finds the data
%point nearest this point and uses the y value of that point!

%splines! useful for smoother connections between points that aren't as big
%a mess as fitting a single polynomial
%remember Monday:
coeffs_10 = polyfit(x,y,10);
y_10 = polyval(coeffs_10,x);
degree_10_error = sum((y_10-y).^2)

close
plot(x,y,'.')
hold on
x_fine = 0:0.01:1;
y_fine = polyval(coeffs_10,x_fine)
plot(x_fine,y_fine)
%that wigglyness is awful!

%what do we want splines to do? Connect neighboring points...but also
%ensure the connections are smooth

%connect each pair of points with a cubic, but choose the cubic so that the
%derivatives at each data point of neighboring cubics match!
y_spline = interp1(x,y,x_grid,'spline')
close
plot(x,y,'.')
hold on
plot(x_grid,y_spline,'k')
%splines give a more natural connection between points
%it is the basis for a lot of computer graphics nowadays
%there are many varieties of splines beyond the simplest cubic splines, but
%we won't cover those in this class

%all options:
plot(x_grid,y_nearest,'r')
plot(x_grid,y_linear,'b')
plot(x_fine,y_fine,'g')

%which one do you think does the best?



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Other Least Squares Problems%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%the data look a little bit like a sine wave too...

%we don't need our functions to be polynomials, we just need them to be
%written in a way that gives us a linear system!

%let's say we want to model this with a sum of a sine and cosine (adjusted
%so their period lines up with the domain)

%y = alpha*sin(2*pi*x) + beta*cos(2*pi*x) + gamma

A = zeros(3,3);

A(1,1) = sum(sin(2*pi*x).^2);
A(1,2) = sum(sin(2*pi*x).*cos(2*pi*x));
A(2,1) = sum(sin(2*pi*x).*cos(2*pi*x));
A(1,3) = sum(sin(2*pi*x));
A(3,1) = sum(sin(2*pi*x));
A(2,2) = sum(cos(2*pi*x).^2);
A(2,3) = sum(cos(2*pi*x));
A(3,2) = sum(cos(2*pi*x));
A(3,3) = 11;

b = zeros(3,1);

b(1) = sum(y.*sin(2*pi*x));
b(2) = sum(y.*cos(2*pi*x));
b(3) = sum(y);

coeffs = A\b

close all
plot(x,y,'.')
hold on
x_grid = 0:0.01:1;
y_periodic = coeffs(1)*sin(2*pi*x_grid) + coeffs(2)*cos(2*pi*x_grid) + coeffs(3);
plot(x_grid,y_periodic)


%%%%%%%%%%%%%
%Square Wave%
%%%%%%%%%%%%%

%sines and cosines are well suited for modeling periodic problems

%consider a square wave:
x = linspace(0,2*pi,20);
y = ones(1,20);
y(11:20) = -1;

close all
plot(x,y,'.')

%consider modeling this with a few cosine functions:
%y = a*sin(x) + b*sin(2x) + c*sin(3x) + d*sin(4x)

A = zeros(4,4);
A(1,1) = sum(sin(x).^2);
A(1,2) = sum(sin(x).*sin(2*x));
A(1,3) = sum(sin(x).*sin(3*x));
A(1,4) = sum(sin(x).*sin(4*x));
A(2,2) = sum(sin(2*x).^2);
A(2,3) = sum(sin(2*x).*sin(3*x));
A(2,4) = sum(sin(2*x).*sin(4*x));
A(3,3) = sum(sin(3*x).^2);
A(3,4) = sum(sin(3*x).*sin(4*x));
A(4,4) = sum(sin(4*x).^2);


A(2,1) = A(1,2);
A(3,1) = A(1,3);
A(4,1) = A(1,4);
A(3,2) = A(2,3);
A(4,2) = A(2,4);
A(4,3) = A(3,4);

b = zeros(4,1);
b(1) = sum(y.*sin(x));
b(2) = sum(y.*sin(2*x));
b(3) = sum(y.*sin(3*x));
b(4) = sum(y.*sin(4*x));

coeffs = A\b;

x_grid = linspace(0,2*pi,100);
y_fine = coeffs(1)*sin(x_grid) + coeffs(2)*sin(2*x_grid) + coeffs(3)*sin(3*x_grid) + coeffs(4)*sin(4*x_grid);

hold on
plot(x_grid,y_fine)

%the more you add the better it does
%there is a much more efficient way of calculating these coefficients
%(which we may get to in this course...)