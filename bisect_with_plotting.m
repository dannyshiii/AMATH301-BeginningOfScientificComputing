function root = bisect_with_plotting(fun,left,right,tolerance,include_plots)
if include_plots
    x = linspace(left,right,1000);
    plot(x,fun(x),'linewidth',2), hold on;
    plot(x,zeros(size(x)),'r'); % a red horizontal line at 0
end

while abs(right - left) > tolerance
    midpoint = (left + right)/2;
    if fun(left)*fun(midpoint) > 0
        left = midpoint;
    else
        right = midpoint;  
    end
    if include_plots
        plot(midpoint,fun(midpoint),'.','markersize',20); % big dots, Yay!
    end
end
root = (left + right)/2;
end