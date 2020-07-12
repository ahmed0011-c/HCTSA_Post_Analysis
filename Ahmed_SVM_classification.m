% Ahmed code SVM classification
%Terms
num_channel = 15;
num_fly = 13;
cost = [2^-20];% define cost paramater

% %% Load Data   % Matrix sorted by Time-series * Channels * Conditions
load('data.mat')
HCTSA_18s=data;

%operation wanted
operation_inv= size(HCTSA_18s,2); % specify number of operations that needs to be analyzed

condition2_start = size(HCTSA_18s,1)/2;  %based on the result from the cross validation segment the Matrix according to the number of conditions that needs to analyzed
condition1_under_inv_glo = HCTSA_18s(1:condition2_start,:);
condition2_under_inv_glo = HCTSA_18s(1+condition2_start:end,:);


%Getting data ready from Linear SVM single channel analysis across flies

for operation= 1:200%:operation_inv
    for channel_idx = 1:num_channel
        operation 
        % clear D
        i= channel_idx-1;
Xtrain = [];
Ytrain = [];

condition1_under_inv = condition1_under_inv_glo((num_fly*i)+1:num_fly*(i+1),operation);
condition2_under_inv = condition2_under_inv_glo((num_fly*i)+1:num_fly*(i+1),operation);

% working Nans and infinity values

% test= [condition1_under_inv;  condition2_under_inv];
% [row, col] = find(isnan(condition1_under_inv));
% [row2, col2] = find(isnan(condition2_under_inv));
% log= condition1_under_inv;
% ise= [row' row2'];
% log(ise)= [];
% condition= size(log,1);
% index_lose= [row' row'+13 row2' row2'+13];
% test(index_lose)= [];
% test1= test(1:condition,1);
% test2= test(condition+1:condition*2,1);
%Xtrain = [Xtrain;test1;test2];
%Ytrain = [Ytrain;ones(size(test1,1),1)*1;ones(size(test1,1),1)*2];

Xtrain = [Xtrain;condition1_under_inv;condition2_under_inv];
Ytrain = [Ytrain;ones(size(condition1_under_inv,1),1)*1;ones(size(condition1_under_inv,1),1)*2];

    % convert to obs x feat x classes matrix
    
 % D = zeros(13,length(operation_inv),2);
D = zeros(size(condition1_under_inv,1),length(operation),2);

condition =13;

D(:,:,1) = Xtrain(1:condition,:);
D(:,:,2) = Xtrain(condition+1:condition*2,:);


 
    % add loop for cost
     %for i= 1: size(cost,2)
%     classification(:,:,channel_idx,operation)= svm_lol_manual(D,cost);
%     trial=  classification(:,:,channel_idx,operation);
%     accuracies(channel_idx,operation)= trial.accuracy;

   classification(channel_idx,operation)=svm_lol_manual(D,cost);
   trial=  classification(:,operation);
    accuracies(channel_idx,operation)= trial.accuracy;
    
      end
end

%save('classification');

%%

