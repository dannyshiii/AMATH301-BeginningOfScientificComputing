function E = datafit(x0,x,y)
A=x0(1);B=x0(2);C=x0(3);

E =     sum((A*cos(B*x)+C-y).^2);


end