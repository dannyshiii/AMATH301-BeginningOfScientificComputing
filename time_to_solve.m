function time = time_to_solve(N)
% This function first generates a N*N matrix from the function rand.
% And then returns the time of solving A\b with Gaussian Elimination for MATLAB
A = rand(N);
b = rand(N,1);
tic;
A\b;
time = toc;
end
