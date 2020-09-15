function [svm_c,accuracy,lol_threshold,dirction,predict] = classify_libsvm(data,operation,params,allocate)

%CLASSIFY_WITH_LIBSVM Summary of this function goes here
%   Detailed explanation goes here

%Classifying using libsvm  (linear) using leave one out cross validation
% (2) giving 13 thresholds for each cross validation in addition to the
% total average threshold
% (3) setting dirction for the data

%requirements:
%(1) download Ahmed HCTSA fly project folder
%(2) libsvm installation  https://www.csie.ntu.edu.tw/~cjlin/libsvm/oldfiles/index-1.0.html

%organize
% data: HCTSA output for trainaing awake/ training anesthesia / valdiation data
% add svm_lol_manual function to the pathway (already found in folder)
% functions for Ahmed HCTSA project folder)
% choose the operation number and refer it to as operation


%output for target one operation/feature of the HCTSA mat
% 1)  total average svm thresholds for the 13 cross validation

% 2)dirction of the operation

% 3) prediction

%% identify variables
%     close all;clear;clc
    num_channel= params.num_channel;
      num_fly = params.training_flies;
      trial = params.training_trial;
      % 
%     operations_start = 1;
%     operations_end = 1000;
     condition = params.training_flies;
%     % %% Load Data


%load(HCTSA_training)

HCTSA_18s=data;

 



%% compute linear svm
condition2_start = size(HCTSA_18s,1)/2;%based on the result from the cross validation
condition1_under_inv_glo = HCTSA_18s(1:condition2_start,:);
condition2_under_inv_glo = HCTSA_18s(1+condition2_start:end,:);


%Getting data redy from Linear SVM single channel analysis across flies

%for operation= operations_start:operations_end
    for channel_idx = allocate.channel  %1:num_channel
        clear D
        i= channel_idx-1;

        condition1_under_inv = condition1_under_inv_glo((num_fly*i)+1:num_fly*(i+1),operation);
        condition2_under_inv = condition2_under_inv_glo((num_fly*i)+1:num_fly*(i+1),operation);

        % working Nans and infinity values

        Xtrain = [condition1_under_inv;condition2_under_inv];

        % convert to obs x feat x classes matrix

        D = zeros(size(condition1_under_inv,1),length(operation),2);


        D(:,:,1) = Xtrain(1:condition,:);
        D(:,:,2) = Xtrain(condition+1:condition*2,:);



        % add loop for cost

        classification=svm_lol_manual(D,2.^-20);
        trial=  classification;
   end
%end

%save(saveName,'classification');

%end
%outputs
svm_c = trial;
accuracy= trial.accuracy;
predict = trial.predictions;



%% calculate thresholds

%identify variables

num_CV= params.n_crossvalidations;

%%


    
   for channels= allocate.channel %1 : num_channel
        for opinv = 1
           for index= 1:num_CV
    tryal= trial; %(channels,1);
    %trial(channels = classification(channels,opinv);
     x= struct2cell(tryal.svms{index,1});
    h= full(x{11,1});
    w(index)= (h' * tryal.svms{index,1}.sv_coef);  %classification.svms{index,1}.sv_coef)
    b(1,index)= tryal.svms{index,1}.rho;
    threshold(1,index)= tryal.svms{index,1}.rho/ (h' * tryal.svms{index,1}.sv_coef);

        end
         mean_threshold= nanmean(threshold');
     end
   end 
   
 
lol_threshold= mean_threshold;

%%   set dirction



for operation_inv= 1%:size(HCTSA_18s,2)  % commented here
   for channel_idx = allocate.channel%1:num_channel
        clear D
        i= channel_idx-1;

        condition1_under_inv = condition1_under_inv_glo((num_fly*i)+1:num_fly*(i+1),operation);
        condition2_under_inv = condition2_under_inv_glo((num_fly*i)+1:num_fly*(i+1),operation);

        % working Nans and infinity values

        Xtrain(:,channel_idx,operation_inv) = [condition1_under_inv;condition2_under_inv];
        
   end
end

z= mean_threshold;


    for channels = 1%allocate.channel %1:num_channel
        i= channels-1;
        %for i= 1:trials
            
            con1= Xtrain(1:num_fly,channels,operation_inv);
          
            test= nanmean(con1);
            
                
             if isnan(z(channels,operation_inv)) == 1 
                bias(channels,operation_inv)= nan;
             
             
             elseif test >= z(channels,operation_inv)   % || test > Thresholds(channels,operation_inv)
                bias(channels,operation_inv) = 1;
                
            else
              
                bias(channels,operation_inv) = 0;
%                
           end
       % end
    end
    
dirction =bias(channels,operation_inv);




end

