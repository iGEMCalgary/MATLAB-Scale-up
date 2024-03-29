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
div = 8;
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

green=[0,1,0];
blue=[0,0,1];
purple=[0.5,0,0.5];

%draw dilution lines and the intersections
altitude=div*sin60;
colour=blue;
intersection_points=zeros(1,2);
%for all red lines
while (altitude<80)
    right_end = (2*top-altitude)/tan60;
    left_start=altitude/tan60;
    moving_point=0;
    %for all points along the redline
    while (moving_point<right_end)
        if(moving_point>left_start)
            slope_dilution_line=altitude/(moving_point);
            x_endpoint_dilution_line=(2*top)/(slope_dilution_line+tan60);
            y_endpoint_dilution_line=x_endpoint_dilution_line*slope_dilution_line;
            %only the points within wanted range (half is 0 - 100sin60)
            if(y_endpoint_dilution_line<50*sin60)
                plot([0 x_endpoint_dilution_line],[0 y_endpoint_dilution_line],'Color', colour);
                y_flat_line=div*sin60;
                %for all intersections the line has
                while(y_flat_line<y_endpoint_dilution_line)
                    x_intersect_dilution_flat=y_flat_line/slope_dilution_line;
                    if(0.01>abs(mod(x_intersect_dilution_flat,10)))
                        plot(x_intersect_dilution_flat,y_flat_line,'rO');%draw intersections
                        intersection_points=[intersection_points; [x_intersect_dilution_flat y_flat_line]]; %#ok<AGROW>
                    end
                    y_flat_line=y_flat_line+div*sin60;
                end
            end
        end
        moving_point=moving_point+10;
    end
    intersection_points=[intersection_points; [0 0]]; %#ok<AGROW>
    altitude=altitude+div*sin60;
    if(isequal(colour,green))
        colour=blue;
    elseif(isequal(colour,blue))
        colour=purple;
    elseif(isequal(colour,purple))
        colour=green;
    end
end
%clean=unique(intersection_points.','rows').';
%disp(clean)

%calculate positions of intersection based on triangle edge values, use
%inverted triangle to calculate the three values. declare empty array of
%size intersection points but 3 extra columns. from there algorithm to use
%first two values, and scale to calculate all other values
num_intersection_points=size(intersection_points);
num_intersection_points=num_intersection_points(1);
intersection_points = [intersection_points zeros(num_intersection_points,3)];
disp(' xcoor \\ ycoor \\ bottomside \\ leftside \\ rightside')
intersection_points(:,5)=intersection_points(:,2);
intersection_points(:,3)=intersection_points(:,1)-intersection_points(:,2)./tan60;
intersection_points(:,4)=100-intersection_points(:,3)-intersection_points(:,5);
disp(intersection_points);
%Plot fanciness
xlim([0 scale]);
ylim([0 top]);
title('sebby');
xlabel('x','fontsize',16); 
ylabel('U','fontsize',16);