% This Matlab script solves the one-dimensional convection
% equation using a finite difference algorithm. The
% discretization uses central differences in space and forward
% Euler in time.

close all;

% Number of points
Nx = 50;
x = linspace(0,1,Nx+1);
dx = 1/Nx;

% velocity
u = 1;

% Set final time
tfinal = 1;

% Set timestep
dt = 0.005;

% Set initial condition
sbubby = ((x-0.5)/0.1);
Uo = 0.75*exp(-sbubby.*sbubby)';
t = 0;

U = Uo;

% Loop until t > tfinal
while (t < tfinal)
    % Forward Euler step
    U(2:end) = U(2:end) - dt*u*backdiff(U(2:end),dx);
    U(1) = U(end); % enforce periodicity

    % Increment time
    t = t + dt;

    % Plot current solution
    clf
    plot(x,Uo,'b*');
    hold on;
    plot(x,U,'*','color',[0 0.5 0]);
    xlabel('x','fontsize',16); ylabel('U','fontsize',16);
    title(sprintf('t = %f\n',t));
    axis([0, 1, -0.5, 1.5]);
    grid on;
    drawnow;
end

% central diff algorithm, essentially takes in data and uses basic
% differentiation method to calculate differentials, uses values to left
% and right to estimate middle
function dU = centraldiff(U,deltax)
    arsize = size(U);
    if(arsize(1)<1) % case not differentiable
        dU = 0;
    elseif(arsize(1)<2) % case size 1
        dU = U;
    else
        % set up first and last entry with forward/back diff
        first = (U(2)-U(1))/deltax;
        last = (U(end-1)-U(end))/deltax;        
        if(arsize(1)>2)% 3 or larger create all middle values
            forward = U(3:end);
            backward = U(1:end-2);
            middle = (forward-backward)/2/deltax;
            dU=[first;middle;last];
        else
            dU= [first;last];
        end
    end
end

% forward diff algorithm, essentially takes in data and uses basic
% differentiation method to calculate differentials, uses values to left
% and middle to evaluate slope at middle
function dU = forwarddiff(U,deltax)
    arsize = size(U);
    if(arsize(1)<1) % case not differentiable
        dU = 0;
    elseif(arsize(1)<2) % case size 1
        dU = U;
    else
        % first entry with back diff
        first = (U(2)-U(1))/deltax;        
        
        forward = U(2:end);
        middle = U(1:end-1);
        middle = (forward-middle)/deltax;
        dU=[first;middle];
    end
end

% backdiff algorithm, essentially takes in data and uses basic
% differentiation method to calculate differentials, uses values to right
% and middle to evaluate slope at middle
function dU = backdiff(U,deltax)
    arsize = size(U);
    if(arsize(1)<1) % case not differentiable
        dU = 0;
    elseif(arsize(1)<2) % case size 1
        dU = U;
    else
        % last entry with front diff
        last = (U(end-1)-U(end))/deltax;         
        
        middle = U(2:end);
        backward = U(1:end-1);
        middle = (middle-backward)/deltax;
        dU=[middle;last];
    end
end

% central diff algorithm for second order, essentially takes in data and uses basic
% differentiation method to calculate differentials, uses values to
% left, middle and right to estimate middle slope
function dU = secondordercentraldiff(U,deltax)
    arsize = size(U);
    deltaxsq = deltax*deltax;
    if(arsize(1)<1) % case not differentiable
        dU = 0;
    elseif(arsize(1)<2) % case size 1
        dU = U;
    else
        % set up first and last entry with forward/back diff
        first = (U(2)-U(1))/(deltaxsq);
        last = (U(end-1)-U(end))/(deltaxsq);        
        if(arsize(1)>2)% 3 or larger create all middle values
            forward = U(3:end);
            backward = U(1:end-2);
            middle = U(2:end-1);
            scale = (forward-2.*middle+backward)/(deltaxsq);
            dU=[first;scale;last];
        else
            dU= [first;last];
        end
    end
end