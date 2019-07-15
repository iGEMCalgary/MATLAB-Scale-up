% Economic Costs of Current Acid Activated Clay Method
% author: Jean-David Rousseau
% version 1.0
% since July 10th 2019
% Last updated July 12th 2019

cost_of_clay_tonne = 300 * 0.907185; % USD per ton * tonne/ton
cost_of_clay_shipping = 2000; % USD per Container (20 tonnes)
cost_of_clay = cost_of_clay_shipping + 20 * cost_of_clay_tonne; % Price for 20 tonnes

% Bleaching. Adsorptive bleaching is performed with 1–3% of acid-activated clays 
% to remove colored components, metals, and phospholipids. 
% Oil is mixed with clay at 100 °C under vacuum for up to 30 min at 10–15% moisture, 
% and then clay is removed by filtration. Chlorophyls will be reduced to below 0.05 mg kg?1. 
% Other adsorbents are rarely used for canola oil.

% with assumption of 2%v acid activated clays, we can then say 20 tonnes
% can process 1000 tonnes of oil
% which, coincidentally, is approx what a plant can process per day

% price of canola oil is cross-elastic with palm and soybean oil, and is
% elastic with itself.
ave_price_seed = 531.86; % CAD/tonne % needs to be changed to show by grade if that can be found

% approx 33% of seed becomes oil, 66% into meal
ave_price_meal = 354.23; %CAD/tonne

volume_seed = 3000; %tonne
volume_meal = volume_seed*0.67; %tonne
volume_oil_crude = volume_seed*0.33; % tonne no source
volume_oil_RBD = volume_oil_crude*850; % tonne no source


% based on futures market on  
% https://www.cmegroup.com/trading/agricultural/grain-and-oilseed/soybean-oil.html
% which is then added with 10-12Cad for a BASIS
ave_price_oil_CME = 27; % CAD/100lbs
ave_price_oil_basis = 10; % CAD/100lbs
price_oil_crude = (ave_price_oil_CME + ave_price_oil_basis) * 19.684; % CAD/tonne


price_oil_RBD = 1273.30; % India price converted to CAD/tonne


meal_d1 = ave_price_meal*volume_meal-ave_price_seed*volume_seed;
oil_meal_d1 = meal_d1+volume_oil_crude*volume_oil_crude;
oil_d2 = price_oil_RBD*volume_oil_RBD - price_oil_crude*volume_oil_crude;
oil_clay_d2 = oil_d2-cost_of_clay;
