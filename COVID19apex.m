dataset = readtable('time_series_covid19_confirmed_global.csv'); % read table

[r,c] = size(dataset); % grab rows and columns of dataset

for i = 1:r % loop through table to index content
    for j = 1:c
        if ismember('/', dataset{i,j}{1}) % if '/' exists in element
            dataset{i,j}{1} = strrep(dataset{i,j}{1}, '/', '_'); % replace '/'
        end
    end
end

for j = 5:c
    dataset{1,j}{1} = ['D' dataset{1,j}{1}];
end

% Renaming Table Columns

dataset.Properties.VariableNames = dataset{1,:}; % rename table columns
dataset(1,:) = []; % delete first row

% Further Deletion and Renaming

dataset(:,1) = []; % delete Province_State column
dataset.Properties.VariableNames{'Country_Region'} = 'Country';
dataset(:,2:3) = [];

% Alphabetic Arrangement of Country Names

dataset{:,1} = sort(dataset{:,1});

% Normalization and Dimensionality Reduction

[r,c] = size(dataset); % grab new rows and new columns of dataset

for i = 1:r
    for j = 2:c
        dataset{i,j}{1} = str2double(dataset{i,j}{1}); % convert to double
    end
end

dataset_machine = table2cell(dataset);

for j = 2:c
    dataset_machine{1,j} = j - 1; % numerical translation of dates
end

dataset_machine_global = cell2mat(dataset_machine(:, 2:end));
dataset_machine_global = [dataset_machine_global(1,:);...
    sum(dataset_machine_global(2:end,:))]; % concatenate vectors

% Country Redundancy Removal 

dataset_machine_country = dataset;

% Assign sum of redundant features for given country to a single feature
dataset_machine_country{9,2:end} = num2cell(sum(cell2mat(dataset{9:16, 2:end})));
dataset_machine_country{40,2:end} = num2cell(sum(cell2mat(dataset{40:54, 2:end})));
dataset_machine_country{58,2:end} = num2cell(sum(cell2mat(dataset{58:90, 2:end})));
dataset_machine_country{92,2:end} = num2cell(sum(cell2mat(dataset{92:93, 2:end})));
dataset_machine_country{100,2:end} = num2cell(sum(cell2mat(dataset{100:102, 2:end})));
dataset_machine_country{117,2:end} = num2cell(sum(cell2mat(dataset{117:127, 2:end})));
dataset_machine_country{186,2:end} = num2cell(sum(cell2mat(dataset{186:190, 2:end})));
dataset_machine_country{245,2:end} = num2cell(sum(cell2mat(dataset{245:255, 2:end})));

% Delete redundant features 
dataset_machine_country(10:16,:) = []; 
dataset_machine_country(34:47,:) = [];
dataset_machine_country(38:69,:) = [];
dataset_machine_country(40,:) = [];
dataset_machine_country(47:48,:) = [];
dataset_machine_country(62:71,:) = [];
dataset_machine_country(121:124,:) = [];
dataset_machine_country(176:185,:) = [];

% Correlation Analysis
X_global = dataset_machine_global(1,:); % store numeric dates 
Y_global = dataset_machine_global(2,:); % store global confirmed cases

coff = corrcoef(X_global, Y_global); % calculate correlation coefficient

plot(X_global, Y_global, 'ro') % plot correlated features
xlabel('Date Numeric Translation') % add x label
ylabel('Confirmed Global Cases') % add y label
title('COVID-19 Confirmed Global Case Trend, as of April 28th 2020')

% Central Tendency Measure Analysis

new_global = dataset_machine_global; % assign new global dataset
new_global = diff(new_global(2,:)); % create difference vector

centraltend = [mean(new_global) std(new_global) median(new_global)];
max_global = max(new_global);
min_global = min(new_global);

plot(new_global, 'ko') % plot spread of new global
title('COVID-19 Spread of Global Confirmed Case Consecutive Day Differences')
xlabel('Date Numeric Translation')
ylabel('Consecutive Global Confirmed Case Day Difference')

% Cross Validation (Train: 90%, Test: 10%)

cv = cvpartition(size(dataset_machine_global,2), 'HoldOut', 0.1); 
idx = cv.test;

% Separate to training and test data
globalTrain = dataset_machine_global(:, ~idx);
globalTest = dataset_machine_global(:, idx);

% Create trainedModel using MATLAB ToolBox Regression Learner

% Make Predictions using Trained Model
X_predict = 98:365;
Y_predict = trainedModel.predictFcn(X_predict);
plot(X_predict, Y_predict, 'bo')
xlabel('Numeric Date Array')
ylabel('Global Confirmed Case Count')
title('Projected Extrapolation of Global COVID-19 Confirmed Case Count')
