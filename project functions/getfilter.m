function [dataf] = getfilter(data,params,name2)
%FILTERING_DATA Summary of this function goes here 
%Data paramaters should be Data-point/channels or trials
%Pre-processsing pramaters
%movingwin = [0.75 0.375];
% 
% Params is a struc file that should contain 
% default mode 
% tapers = [3 5]; 
% fs= 1000; % sampling frequency 
% f0 =50;
% params.Fs = fs;
% params.tapers = tapers;

%   loading

%data =importdata(name);

%% identify variables
% num_channel= 15;
% trials=56;
% conditions= 2;
% flies=13;
% trial=1;
% n_trflies= 13;
% n_vldflies= 56;

num_channel = params.num_channel;

trials = params.validation_trials;

conditions = params.training_conditions;

flies = params.training_flies;

trial = params.training_trial;

n_trflies= params.n_trflies;

n_vldflies= params.n_vldflies;

param.Fs = params.Fs;
param.tapers =  params.tapers;

 movingwin= params.movingwin;
 f0= params.f0;
 

%% pre-processing validation data
%step one Remove line noise and apply tapers
% movingwin = [0.75 0.375];
% tapers = [3 5];
% fs= 1000;
% f0 =50;
 


[datac,datafit,Amps,freqs]=rmlinesmovingwinc(data,movingwin,[],param,[],[],f0);



dataf= datac;


   
   % end
    
% Step 3 Normalizing the data by Z-scoring each channel


        
    save(name2,'dataf')
end



