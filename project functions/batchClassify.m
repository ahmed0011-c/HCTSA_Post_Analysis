function [outputArg1,outputArg2,outputArg3,outputArg4] = batchClassify(Job,params,allocate)

%BATCHCLASSIFY Summary of this function goes here

%first input is [Job]     1 to compute  0 to avoid
%Job.classify =1
% Job.predict=1

%second input is [params] 
%supplied with data so there is no need to change

%third input is allocate
%allocate.channel = n
%allocate.operation =n 
%allocate.datatype = 1 for training data and 2 for validation data

% will generate output
% outputArg1 = svm_c; %svm information e.g weights
% outputArg2 = dirction; % data dirction
% outputArg3= lol_threshold; %svm threshold
% outputArg4=predict_condition'; % predict condition state 1 for awake and 2 for anesthesia
% 
% plot predict map 

%% classify what file

 i= allocate.channel;
 ix= allocate.operation;
%ih= allocate.trial;

if allocate.datatype ==1
name1 =  sprintf('training_data.mat');
end

if allocate.datatype ==2
    
   
name1 =  sprintf('validation_data.mat');

end

%load data

data= importdata(name1);


%identify variables

operation = allocate.operation;


%% assigning Jobs



if Job.classify ==1
    
[svm_c,accuracy,lol_threshold,dirction,predict] = classify_libsvm(data,operation,params,allocate);
i= allocate.channel;
ix= allocate.operation;


savename= sprintf('classification_files_ch%d_op%d.mat',i,ix);

save(savename,'svm_c','accuracy','lol_threshold','dirction','predict');
    
end

if Job.predict ==1
    
   testdata =importdata('validation_data.mat');
   load(savename);
    
    [predict_condition] = predict_flies(testdata,lol_threshold,dirction,allocate,params);

end

%plot validation prediciton
imagesc(predict_condition) 
colorbar
title('valdiation data predict one for awake and zero for anesthesia')
ylabel('trial number')


%   Detailed explanation goes here
outputArg1 = svm_c;
outputArg2 = dirction;
outputArg3= lol_threshold;
outputArg4=predict_condition';

end

