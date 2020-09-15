function [outputArg1,outputArg2,outputArg3,outputArg4] = batchClassify(Job,params,allocate)
%BATCHCLASSIFY Summary of this function goes here


%% classify what file

 i= allocate.channel;
 ix= allocate.operation;
%ih= allocate.trial;

if allocate.datatype ==1
name1 =  sprintf('training_data.mat',i,ix);
end

if allocate.datatype ==2
    
   
name1 =  sprintf('validation_data.mat',i,ix);

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



%   Detailed explanation goes here
outputArg1 = svm_c;
outputArg2 = accuracy;
outputArg3= lol_threshold;
outputArg4=predict_condition';
end

