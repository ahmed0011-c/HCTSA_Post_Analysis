function [svms,accuracy,threshold,predictm] = batch_analysis(Job,params)


%identify variables
num_channel= params.num_channel;
tr_flies = params.training_flies;
v_trial= params.n_vldflies;

operations= params.operations;

%loading variables
load('validation_data.mat')
load('training_data.mat')

%% assigning jobs




%identify variables
for i= 1:operations
    for i2 = 1:num_channel
       
        allocate.operation= i;
        allocate.channel= i2;
        allocate.datatype=1;
        
 [svms(i2,i),accuracy(i2,i),threshold(i2,i),predictm{i2,i}] = batchClassify(Job,params,allocate);

save('tot_classification.mat','svms','accuracy','threshold','predictm')

    end
end







end

