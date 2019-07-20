close all
cos60 = 0.5;
sin60 = sqrt(3)/2;
tan60 = sqrt(3);

%Set up 3 lines of triangle
scale = 100;
x_h = linspace(0,scale);
h = zeros(size(x_h));
x_up = linspace(0,scale/2);
up= tan60*x_up;
top = tan60*x_up(end);
x_down=linspace(scale/2,scale);
down= 2*top-tan60*x_down;
triangle = [h, up, down];
x_triangle = [x_h, x_up, x_down];
figure 
hold on
plot(x_triangle,triangle,'k');

%draw horizontal lines (red)
div = 10;
div = scale/div;
i=div;
red_heights=[];

while(i<scale)
    start = i*cos60;
    finish = scale-start;
    new_x_h = linspace(start,finish,100);
    new_height = i*sin60;
    red_heights = [red_heights new_height];  %#ok<AGROW>
    new_h=new_height*ones(size(new_x_h));
    plot(new_x_h,new_h,'r');
    i=i+div;
end

%draw dilution lines
startpoints=zeros(2,19);
step=5;
i=step;
while(i<scale)
    index = i/5;
    startpoints(index,1)=scale - i*cos60;
    startpoints(index,2)=i*sin60;
    x_dilution = linspace(0,startpoints(index,1),10);
    plot(x_dilution,startpoints(index,2)/startpoints(index,1)*x_dilution,'b');
    i=i+step;
end

% calculate intersection points between the redheights and the
% dilutionlines
intersection_points = [];
for i = 1:size(startpoints)
    inv_slope = startpoints(i,1)/startpoints(i,2);
    sized = size(red_heights);
    entry = [i,0];
    intersection_points = [intersection_points; entry]; %#ok<AGROW>
    for j = 1:sized(2)
        x_val_on_line = red_heights(j)*inv_slope;
        if(x_val_on_line>startpoints(i,1))
            break %out of triangle
        else 
            entry = [x_val_on_line,red_heights(j)];
            intersection_points = [intersection_points; entry]; %#ok<AGROW>
            plot(x_val_on_line,red_heights(j),'ro');
        end
    end
end

%calculate positions of intersection based on triangle edge values, use
%inverted triangle to calculate the three values. declare empty array of
%size intersection points but 3 extra columns. from there algorithm to use
%first two values, and scale to calculate all other values
disp(' xcoor \\ ycoor \\ bottomside \\ leftside \\ rightside')
sized = size(intersection_points);
intersection_points = [intersection_points zeros(sized(1),3)];
intersection_points(:,3)=intersection_points(:,1); %copy col 1 to col 3
for i=1:sized(1)
    if(intersection_points(i,2)==0) %indicator for not a point
        continue
    else
        x = intersection_points(i,1);
        y = intersection_points(i,2);
        %left side
        xl = (x+y/tan60)*0.5;
        yl = xl*tan60;
        intersection_points(i,4) = scale - sqrt(xl^2+yl^2);
        %right side
        xr = (x+(2*top-y)/tan60)/2;
        xr = scale - xr;
        yr = xr*tan60;
        intersection_points(i,5) = sqrt(xr^2+yr^2);
    end
end
disp(intersection_points)
disp(' xcoor \\ ycoor \\ bottomside \\ leftside \\ rightside')

%Plot fanciness
xlim([0 scale]);
ylim([0 top]);
title('sebby');
xlabel('x','fontsize',16); 
ylabel('U','fontsize',16);