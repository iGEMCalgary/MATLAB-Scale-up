% Creates Plot of costs per acre and revenue per acre
% author: Jean-David Rousseau
% version 1.0
% since July 4th 2019

close all

estimated_cost_acre = 423.58;


yield_acre = [30 110]; % bushels per acre
price_bushel = [1 12]; % sell price per bushel
breakeven_price = estimated_cost_acre./yield_acre;

grade_1_price = [9.06 10.66]; %y vals
grade_24_price = [4 6]; %y vals

usual_yield = [35 45]; %x vals

figure 
hold on

%Grade 1 price highlight
leftup = 55;
leftdown = 67;
rightup = 59;
rightdown = 71;
bottom = grade_1_price(1);
top = grade_1_price(2);
x = [leftdown leftup rightup rightdown];
y = [bottom top top bottom];
fill(x, y, [0.9290,0.9940, 0.5250],'HandleVisibility','off')
txt = '\leftarrow Grade 1 Price';
text(70,10,txt)

%grade 2-4 price highlight
leftup = 91;
leftdown = 107;
rightup = 95;
rightdown = 110;
bottom = grade_24_price(1);
top = grade_24_price(2);
x = [leftdown leftup rightup rightdown];
y = [bottom top top bottom];
fill(x, y, [0.6,0.8, 0.5],'HandleVisibility','off');
txt = 'Grade 2 - 4 Price \rightarrow';
text(70,5,txt)

%Average Yield
left = usual_yield(1);
right = usual_yield(2);
bottomright = 12;
topright =12.5;
bottomleft = 13.25;
topleft = 13.75;
x = [left left right right];
y = [bottomleft topleft topright bottomright];
fill(x, y, [0.8,0.8, 0.5],'HandleVisibility','off');
txt = '\downarrow Average Yield';
text(40,14,txt)


hold on
plot(yield_acre, breakeven_price, 'r');
xlabel('yield (bu/acre)');
ylabel('price (CAN/bu)');
legend('breakeven price');
title('break even price based on yield per acre');
% Basic Economic Model Based on 
% https://www.gov.mb.ca/agriculture/farm-management/production-economics/pubs/cop-crop-production.pdf
% Gross Revenue = Price per unit x Yield per acre (eg. wheat: $6.75/bu x 55bu/ac = $371.25/ac)
% Net Profit = Gross Revenue - Total Cost (eg. wheat: $371.25 gross revenue - $384.3 total cost = $-13.05 per acre)
% Operating Expense Ratio = (Operating Cost / Gross Revenue) x 100 (eg. wheat: $224.16 operating expense / $384.3 total cost = 60.4%)
% $ Revenue Per $ Cost = Gross Revenue / Total Cost (eg. wheat: $371.25 gross revenue / $384.3 total cost = $0.97)
% Return on Investment (ROI) = (Gross Revenue - Total Cost) / Total Cost (eg. wheat: ($371.25 gross revenue-$384.3 total cost) /$384.3 total cost = -3.4%)
% Estimated Return on Asset (ROA) = (Margin Over Operating - Labour - Machinery Depreciation) / (Land Investment Cost + Machinery Investment Cost)
%  (eg. wheat: ($147.09 margin - $26.40 labour - $66.65 dep.) / ($2950 land cost + $682.20 conv. machinery + $86.00 special crop. mach.) = 1.45%)
% Breakeven Price = Cost / Target Yield (eg. wheat cost $384.30 / 55 bu = $6.99 per bu)
% Breakeven Yield = Cost / Target Price per Unit (eg. wheat cost $384.30 / $6.75 bu = 56.9 bu)
% Breakeven Yield Risk Ratio = (Target Yield per Acre / Breakeven Yield) x 100 (eg. wheat yield 55 bu/ac / 56.9 bu BE = 97 %)
% AgriInsurance Risk Ratio = (AgriInsurance Coverage / Operating Cost) x 100 (eg. wheat coverage $274.00/ac / $224.16 operating expense = 122 %)

% 10.66	9.06 High price/ Low price of grade 1 canola per bushel https://www.saskcropinsurance.com/ci/prices/
% 2018 bushel per acre = 39.8