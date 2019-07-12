% Economic Costs of Current Acid Activated Clay Method
% author: Jean-David Rousseau
% version 1.0
% since July 10th 2019

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
ave_price_seed = 531.86; % CAD/tonne %needs to be changed to show by grade if that can be found

price_oil_in = Inf;
price_oil_out = Inf;
volume_oil_in = 0;
volume_oil_out = 0;