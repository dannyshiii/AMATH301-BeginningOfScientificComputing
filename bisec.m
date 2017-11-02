function root = bisec(func, left, right, tol)
% This is connected to Wk1_ComputerLogicLoops.m
% This is a general function of bisec :)
while abs(right - left) < tol
    midpt = (left + right) / 2;
    if func(left) * func(midpt) > 0
        left = midpt;
    else
        right = midpt;
    end
end
root = (left + right) / 2;
end