function time = time_to_solve(N)

A = rand(N);
b = rand(N,1);

tic;
A\b;
time = toc;

end