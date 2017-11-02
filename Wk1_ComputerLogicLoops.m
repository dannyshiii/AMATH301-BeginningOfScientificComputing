clear all;
close all;
% This is my review for AMATH 301, Week 1's (Computer Logic & Loops) materials


% for loop
% This for loop shows how a cumulative sum is added up.
cumulative_sum = 0;
cumulative_sum_list = zeros(10,1);
max_sum = 10;
for i = 1:max_sum
    cumulative_sum = cumulative_sum + i;
    cumulative_sum_list(i) = cumulative_sum;
end


% nested for loops
% This for loop shows a n*n matrix, in which integers from 1 to n^2 are
% sorted from smallest to largest by rows.
matrix_size = 10;
matrix_to_fill = zeros(matrix_size);
for i = 1:matrix_size
    for j = 1:matrix_size
        matrix_to_fill(i,j) = matrix_size*(i-1) + j;
    end
end


% rand: returns a n*m matrix of random numbers from Uni[0,1]
random_list = rand(10,1);
% if loops
for i = 1:length(random_list)
    random_list(i)
    if random_list(i)>0.5
        disp('The number above this sentence is larger than 0.5');
        % disp: display
    elseif random_list(i) > 0.25
        disp('At least it is bigger than 0.25?');
    else
        disp('Wow, this number is even smaller than 0.25 :/');
    end
end


% An example of nested for loops + if loops
n = 10;
random_matrix = rand(n,n);
is_it_smaller_than_half = true(n,n);
    % true(SIZE(A)) returns a matrix of logical ones in the same size as A
for i = 1:n
    for j = 1:n
        if random_matrix(i,j) > 0.5
            is_it_smaller_than_half(i,j) = false;
            % logical indexing
        end
    end
end
random_matrix(is_it_smaller_than_half) = 0;
% nums < 0.5 are 0 nowh
% a simplier version :)
random_matrix_2 = rand(n,n);
random_matrix_2(random_matrix_2 < 0.5) = 0;


% bisect: a kind of iteration
% logistics: given a left / right end point, find the answer to our func
% by testing on the mid points
% Recall Squeeze Theorem
% Here is a bisect example of finding cos(x) = 0
% when the left end pt is 0 and the right end pt is 3pi/4
% We squeeze the left/right end pt to the ans we want
left = 0; % cos(left) = 1
right = 3*pi/4; % cos(right) = -sqrt(2)/2
for i = 1:100
    midpoint = (left + right)/2;
    % you should define your midpt inside the for loop
    if cos(left)*cos(midpoint) > 0
        left = midpoint;
    else
        right = midpoint;  
    end
end
left;
right; % pi/2
% midpt: closer and closer to 0 as left/right end pt squeezes to pi/2

% Here is a bisect example of f(x)=exp(x)-1, want to find where f(x)=0
fun = @(x) exp(x)-1; % f(x) = exp(x) - 1
left = -1;
right = 1.5;
for i = 1:100
    midpoint = (left + right)/2;
    if fun(left)*fun(midpoint) > 0
        left = midpoint;
    else
        right = midpoint;  
    end
    % closer and closer to 0
    % fun(midpoint)
    % pause(0.5) % display every other 0.5 sec
end


% while loops
tol = 0.00001; % my tolerance of the error
    % aka I wanna stop as soon as my error < my tolerance
left = -1;
right = 1.5;
while abs(right - left) > tol
    % always check if your condition would lead to an INFINITE loop
    midpoint = (left + right)/2;
    if fun(left)*fun(midpoint) > 0
        left = midpoint;
    else
        right = midpoint;  
    end
end

% Here is a general bisec function
% I've saved it into "bisec.m"
bisect(@(x) tan(x),-1,2,1e-5);


% Basics for plotting
x = linspace(0,1,100); % recall linspace
y = exp(x)-1;
figure; % opens an empty figure window
close all; % close all windows
plot(x,y,'-.r'); % red line with dash dot as the pattern
plot(x,y,'b','Linewidth',5); % blue line with linewidth = 5
y_2 = cos(x);
y_3 = x.^2;

plot(x,y,'Linewidth',3), hold on;
% hold on: add figure onto previous figure
% use hold off to turn it off
plot(x,y_2,'.r','Linewidth',3); % red line; pattern is dot
plot(x,y_3,'*g','Linewidth',0.1) % green line, pattern is *
title('A few functions','Fontsize',16); % title with fontsize = 16
xlabel('the x-axis','Fontsize',16); % name for x axis
ylabel('the y-axis','Fontsize',16) % name for y axis
legend('e^x-1','cos(x)','x^2','location','northwest'); 
% legend for all lines with their patterns

% Here is a general bisec function with plotting
% I'll submit another "bisec_with_plotting.m"
% Note that true is a logical number
root = bisect_with_plotting(@(x) exp(x)-1,-1,0.5,1e-5,true);