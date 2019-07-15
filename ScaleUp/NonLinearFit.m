clc; 
xdata = [-15 0]; 
ydata = [5.17 0]; 

figure
hold off 
plot(xdata,ydata,'ro')

% x points - substrate concentration 
% y points - rate of substrate consumption 

xinv = xdata; 
yinv = ydata;

F1 = @(m,xinv) m*xinv; 
x0 = -2; 
m = lsqcurvefit(F1,x0,xinv,yinv);

xrun = [-100, 100];
yeq = m*xrun;

hold on 
plot(xrun,yeq,'r'); 
xlabel('Chlorophyll fraction in oil');
ylabel('Chlorophyll fraction in ethanol'); 
title('Equilibrium Line fit to data points'); 
legend('Exp. data', 'Eq. Line');
set(legend,'location','northwest');
hold off