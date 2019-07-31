function [x] = Xforlvl95(Y,s)

lvl = Y(end); 
lvl95 = lvl/100*95; 
l = length(Y); 

for i = 1:1:l
    if Y(i) >= lvl95
        x = i./s; 
        break
    end
end
end