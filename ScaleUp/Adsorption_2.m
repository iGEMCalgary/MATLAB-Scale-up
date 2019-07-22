close all;

% Number of points
Nz = 4;
z = linspace(0,1,Nz+1);
dz = 1/Nz;

% Set final time
tfinal = 0.1;

% Set timestep
dt = 0.001;

%Constants
v=1;
Dazi=1;
epsb=2;
rhop=1;
Cifeed=0.001;
C1=0.001;
C2=0;
C3 = 0.001;
L=1;
kovi = 1;
qsi =0.002;
qi=0.03;
% Set initial condition
Ci=zeros(size(z));
% Boundary conditions
Ci(1) = Cifeed+C1;
Ci(end) = C2;

t=0;
while (t < tfinal)
    % Forward Euler step
    terma = -1*v*centraldiff(Ci(1:end),dz);
    termb = Dazi*secondordercentraldiff(Ci(1:end),dz);
    termc = -1*(1-epsb)/epsb*5*dz*rhop*kovi*(qsi-qi); %kovi*(qsi-qi) is a differential im just testing bruh
    Ci(1:end) = Ci(1:end) - dt*(terma+termb+termc);
    disp(Ci);
    % enforce boundaries
    Ci(1) = Cifeed+C1; 
    Ci(end)=C2;

    % Increment time
    t = t + dt;

    % Plot current solution
    clf
    hold on;
    plot(z,Ci,'r');
    xlabel('z','fontsize',16); 
    ylabel('Ci','fontsize',16);
    title('adsorption over time');
    drawnow;
end

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


