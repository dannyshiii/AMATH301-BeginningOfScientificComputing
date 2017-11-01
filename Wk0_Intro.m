clear all;
close all;
% This is my review for AMATH 301, Week 0's (intro) materials

a = [6 4 2];
b = [3 2 1];
a .\ b; % [0.5 0.5 0.5]
a ./ b; % [2 2 2]

A = [1 2 3;
    4 5 6;
    7 8 9];
B = [9 8 7;
    6 5 4;
    3 2 1];
A .* B;
A * B;

A.';
% Note that for real numbers, ".'" and "'" are the same
% But it works differently in complex numbers
% So always use .' for transpose

diag(A); % returns a col vec of the diagonal
K = diag(diag(A));
% returns a zeroes matrix with diag(A) on the diagonal

save('a.dat','a','-ascii')
% save('FileName.format','VariableName','format')
% default: a binary MAT-file format
% -ascii: 8-digit ASCII format

C = eye(5); % a 5*5 identity matrix

a_nice_grid = linspace(0,2*pi,100);
% generates 100 pts between 0 and 2*pi
% plot(a_nice_grid,cos(a_nice_grid),'mo-');
% magenta, circle dot, connect with line
% I'm gonna comment the plot out here.

P = [1 7 9 2; 2 3 3 4; 5 0 2 6; 6 1 5 5];
x = P(1:end-1,2:end);
x = [P(1,2:4);P(1:3,3).'];

