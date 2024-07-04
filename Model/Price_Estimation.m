clc;
clear;

% Australia
% Argentina
Canada
% South_Africa
% Turkmenistan
% Tunisia
% United_States
% Yemen

%% Parameter of electrolyzer

Operating_Hours = 90000; % hours

Lifetime_Operating_Year = Operating_Hours/Full_Load_Hour; % year
% Maximal operation time according to operating time

Life_Time_Electrolyzer_Component = 20; % years
% Maximal operation time according to component liferime

Life_Time_Electrolyzer = min(Lifetime_Operating_Year,Life_Time_Electrolyzer_Component);
% Take the smaller value to set as the operation time of the electrolyzer

%% Parameters for Methanol

CAPEX_Methanol_Per_MW = 235400; % €/MW

% Power_Methanol = 191; % MW

Life_Time_Methanol = 20; % Year

% Full_Load_Hour_Methanol = 6998; % Hours

Sythesis_Efficiency_Methanol = 0.75;

OPEX_Methanol = 24.7912; % €/MWh methanol

%% Parameters for Methane

CAPEX_Methane_Per_MW = 295000; % €/MW

% Power_Methane = 191; % MW

Life_Time_Methane = 20; % Year

% Full_Load_Hour_Methane = 6998; % Hours

Sythesis_Efficiency_Methane = 0.773;

OPEX_Methane = 23.016; % €/MWh methanol

%% Calculation for Hydrogen
Electricity_Consumption_Per_kg_Hydrogen = 33.33/Efficiency/1000; % in MW
% Lower heating value of hydrogen is 33.33 kWh/kg

Annual_Electricity_Consumption = Power_of_Electrolyzer * Full_Load_Hour; % MWh
% The total anount of electricity consumption

% Hydrogen_Transportation_Cost = 0.000049296 * Distance + 1.3796; % €/kg
% From "Hydrogen Transportation Cost", Liquid hydrogen

Hydrogen_Transportation_Cost = 0.00024 * Distance;
% From "Hydrogen Transportation Cost", Low cost pipeline

Annual_Hydrogen_Production = Annual_Electricity_Consumption / Electricity_Consumption_Per_kg_Hydrogen; % in kg
% Total amount of hydrogen production

Total_Expence_for_Electricity = Electricity_Cost * Annual_Electricity_Consumption; % in €
% Expenditure on purchasing electricity

CAPEX_Electrolyzer = CAPEX_Electrolyzer_Per_MW * Power_of_Electrolyzer;
% Calculate total CAPEX of electrolyzer

CAPEX_Electrolyzer_Annity = CAPEX_Electrolyzer * (Interest_Rate/(1-(1+Interest_Rate)^(-Life_Time_Electrolyzer))); % in €
% Calculate CAPEX in annuity

Total_Hydrogen_Production_Cost = (CAPEX_Electrolyzer_Annity + Total_Expence_for_Electricity)/Annual_Hydrogen_Production + OPEX_Hydrogen_Production; % in €/kg
% Production cost of hydrogen comprised of CAPEX, OPEX and cost for electricity

Total_Expence_for_Electricity_in_MWh = Total_Expence_for_Electricity/Annual_Hydrogen_Production/0.03333; % in €/MWh
CAPEX_Electrolyzer_Annity_in_MWh = CAPEX_Electrolyzer_Annity/Annual_Hydrogen_Production/0.03333; % in €/MWh
% Check details, only for paper writting

Estimate_Import_Price = Total_Hydrogen_Production_Cost + Hydrogen_Transportation_Cost; % in €/kg

%% Calculation for methanol
% Hydrogen_Consumption = Power_of_Methanol * Full_Load_Hour_Methanol ; % in MWh

Hydrogen_Cost_for_Methanol =  Total_Hydrogen_Production_Cost / 0.0333 / Sythesis_Efficiency_Methanol ; % in €/Mwh 
% lower heating value for hydrogen is 0.0333 MWh/kg

Annual_Methanol_Production = Power_Methanol * Full_Load_Hour_Methanol; % MWh
% 0.75 is the efficiency for sythesis 
% lower heating value 5.5 kWh/kg, 0.0055 MWh/kg

CAPEX_Methanol = CAPEX_Methanol_Per_MW * Power_Methanol; % €

CAPEX_Methanol_Annuity = CAPEX_Methanol * (Interest_Rate/(1-(1+Interest_Rate)^(-Life_Time_Methanol))); % €

Total_Methanol_Production_Cost = CAPEX_Methanol_Annuity/Annual_Methanol_Production + OPEX_Methanol + Hydrogen_Cost_for_Methanol; % €/MWh

%% Calculation for methane

Hydrogen_Cost_for_Methane =  Total_Hydrogen_Production_Cost / 0.0333 / Sythesis_Efficiency_Methane ; % in €/Mwh 
% lower heating value for hydrogen is 0.0333 MWh/kg

Annual_Methane_Production = Power_Methane * Full_Load_Hour_Methane; % MWh

CAPEX_Methane = CAPEX_Methane_Per_MW * Power_Methane; % €

CAPEX_Methane_Annuity = CAPEX_Methane * (Interest_Rate/(1-(1+Interest_Rate)^(-Life_Time_Methane))); % €

Total_Methane_Production_Cost = CAPEX_Methane_Annuity/Annual_Methane_Production + OPEX_Methane + Hydrogen_Cost_for_Methane; % €/MWh

CAPEX_Methane_in_MWh = CAPEX_Methane_Annuity/Annual_Methane_Production;
