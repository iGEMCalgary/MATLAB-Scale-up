
%McCabe-Thiele Diagram Maker
%Creates McCabe-Thiele Diagrams based on input values
%author: Jean-David Rousseau
%version 1.0
%since July 3rd 2019

close all
%set up x-axis
x_initial=0.012;
x_scale=[0 x_initial];

%initial y later replaced by mass balance equation to find it
y_initial=0.01649;

%Equilibrium idk where the values are, yolo
slope_eq=1.613;
intercept_eq=0;

equilibrium=slope_eq*x_scale+intercept_eq;

%Operating line values
slope_top_operating_line= 1.35;
intercept_top_operating_line=0.00029;
slope_bottom_operating_line= 2.273;
intercept_bottom_operating_line=-0.00227;

%Find Intercept between lines
line_intersect_x=(intercept_top_operating_line-intercept_bottom_operating_line)/(slope_bottom_operating_line-slope_top_operating_line);
line_intersect_y=slope_bottom_operating_line*line_intersect_x+intercept_bottom_operating_line;

%Use this intercept as a cutoff
x_top = [line_intersect_x x_initial];
x_bottom = [0 line_intersect_x];

%Finally construct our 2 feed lines
top_operating_line=slope_top_operating_line*x_top+intercept_top_operating_line;
bottom_operating_line=slope_bottom_operating_line*x_bottom+intercept_bottom_operating_line;


%McCabe Thiele diagram lines between lines
%start at y_initial, finish at 0
%eq_count tracks the number of steps?
%points holds all the points that touch the lines
eq_count = 0;
xx = x_initial;
yy = y_initial;
points=[xx,yy];
point=[];

while(yy>0)
    %save the previous values in case of partial step
    prev_x=xx;
    prev_y=yy;
    %go to equilibrium
    xx=(yy-intercept_eq)/slope_eq;
    
    %save point and wait(add to points matrix)
    point=[xx,yy];
    
    %go to Operating line
    if (xx>line_intersect_x)
        yy = slope_top_operating_line*xx+intercept_top_operating_line;
    else
        yy = slope_bottom_operating_line*xx+intercept_bottom_operating_line;
    end
    
    
    
    if(yy<0)
        %we need partial step if yy<0
        yy=prev_y;
        if(line_intersect_y > 0)
            %intersect above zero, use bottom
            zero_intersect_x=-intercept_bottom_operating_line/slope_bottom_operating_line;
        else
            %intersect above zero, use top
            zero_intersect_x=-intercept_top_operating_line/slope_top_operating_line;
        end
        %save the last two points
        point=[zero_intersect_x,yy];
        points=[points;point];
        point=[zero_intersect_x,0];
        points=[points;point];
        %increment value by proportion
        %xx is still moved to eq, prev x is on OPline
        eq_count=eq_count+((prev_x-zero_intersect_x)/(prev_x-xx));
        %exit loop
        break
    
    
    else
        %continue normally
        %save point and add to points matrix
        points=[points;point];
        point=[xx,yy];
        points=[points;point];
    
        %step successful
        eq_count=eq_count+1;
    end
end



%Plot 3 lines
figure
hold off
plot(x_scale,equilibrium,'g',x_top,top_operating_line,'b',x_bottom,bottom_operating_line,'c', x_scale, line_intersect_y*ones(size(x_scale)),'k')

%Pre-Plot McCabe Thiele diagram lines 
%Constructing each line requires 2 points
xx=1;
[m,n]=size(points);%m is number of points
two_points=[0 0;0 0];
end_points=[0 0];
is_horizontal=true;

while(xx<m)
    if(is_horizontal)
        %horizontal
        end_points=[points(xx,1) points(xx+1,1)];
        line_value = points(xx,2);
        hold on
        plot(end_points,line_value*ones(size(end_points)),'r')
        is_horizontal=false;
    else
        %vertical
        end_points=[points(xx,2) points(xx+1,2)];
        line_value = points(xx,1);
        hold on
        plot(line_value*ones(size(end_points)),end_points,'r')
        is_horizontal=true;
    end
    xx=xx+1;
end

%formatting
title('McCabe-Thiele Diagram');
xlabel('Component A fraction','fontsize',16); 
ylabel('Component B fraction','fontsize',16);
ylim([0 inf]);
legend({'equilibrium','top operating line', 'bottom operating line', 'change', 'steps'},'Location','southeast','NumColumns',2);
dim = [0.2 0.5 0.4 0.3];
num1 = sprintf('%0.3f',eq_count);
num2 = sprintf('%0.3f',line_intersect_y); 
str = {strcat('Steps = ',num1), strcat('change = ',num2)};
annotation('textbox',dim,'String',str,'FitBoxToText','on');