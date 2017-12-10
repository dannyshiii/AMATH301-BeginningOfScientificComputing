clear all;
close all;
clc;

w = 2*pi; % natural frequency
d = 0.25; % damping scale, Zeta

% spring-mass-damper system
A = [0 1;
    -w^2 -2*d*w];
% \dot(x) = Ax

dt = 0.01; % time step
T = 10; % amount of time to integrate
x0 = [2; 0]; % initial condition with x=2, v=0

% iterate forward Euler scheme
xF(:,1) = x0; % 1st col is the initial condition; state
tF(1) = 0; % time
for k = 1:(T/dt)
    tF(k+1) = k*dt; % what's this line of code for??????
    xF(:,k+1) = (eye(2) + dt*A) * xF(:,k);
end
%plot(tF, xF(1,:));
%xlabel('Time');
%ylabel('Position');
%figure
%plot(xF(1,:),xF(2,:)); % phase diagram
% aka how does the position and the velocity plot together
%xlabel('Position(x)');
%ylabel('Velocity(v)');
%figure
%plot3(tF, xF(1,:), xF(2,:)); % position against velocity
%xlabel('Position(x)');
%ylabel('Velocity(v)');

% Now, a bigger dt
dt = 0.1; % time step
T = 10; % amount of time to integrate
x0 = [2; 0]; % initial condition with x=2, v=0

% iterate forward Euler scheme
% clear xF & tF of course
xF(:,1) = x0; % 1st col is the initial condition; state
tF(1) = 0; % time
for k = 1:(T/dt)
    tF(k+1) = k*dt;
    xF(:,k+1) = (eye(2) + dt*A) * xF(:,k);
end
plot(tF, xF(1,:));
xlabel('Time');
ylabel('Position');
figure
plot(xF(1,:),xF(2,:)); % phase diagram
% aka how does the position and the velocity plot together
xlabel('Position(x)');
ylabel('Velocity(v)');
figure
plot3(tF, xF(1,:), xF(2,:)); % position against velocity
xlabel('Position(x)');
ylabel('Velocity(v)');
% hold a sec, we increased our dt too much, it diverges now! oh no!

close all;
% iterate backward Euler scheme
dt = 0.01;
xB(:,1) = x0;
tB(1) = 0;
for k = 1:T/dt
    tB(k+1) = k*dt;
    xB(:,k+1) = inv(eye(2)-A*dt)*xB(:,k);
end
plot(tB, xB(1,:));
xlabel('Time');
ylabel('Position');
figure
plot(xB(1,:),xB(2,:)); % phase diagram
% aka how does the position and the velocity plot together
xlabel('Position(x)');
ylabel('Velocity(v)');
figure
plot3(tB, xB(1,:), xB(2,:)); % position against velocity
xlabel('Position(x)');
ylabel('Velocity(v)');

% now, bigger dt
dt = 0.1; %......
% still stable, doesn't diverge

% compute better simulation using built-in Matlab integrator
% 4-th order Runge Kutta integrator
[t,xGood] = ode45(@(t,x) A*x, 0:dt:T,x0); % using function handles
plot(t,xGood(:,1),'r'); % between forward and backward
% smaller dt? 3 curves converges
% bigger dt? ode most stable, then backward; forward diverges oh no!

clear all; close all; clc;
t = 0:.1:50;
y0 = [pi/4; 0]; %theta=45, v0=0 then let go!
g = -10;
L = 10;
d = 0.1;
% dy = pend(t,y,g,L,d)
[t,y] = ode45(@(t,y)pend(t,y,g,L,d),t,y0);
figure
plot(t,y(:,1));
figure
plot(y(:,1),y(:,2));
figure
plot3(t,y(:,1),y(:,2));