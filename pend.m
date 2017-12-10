function dy = pend(t,y,g,L,d)
% a single pendulum model
dy(1,1) = y(2); % xdot = v
dy(2,1) = (g/L)*sin(y(1)) - d*y(2);

end