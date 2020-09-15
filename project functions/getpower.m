function [S,f] = getpower(data,params,name5)
%GETPOWER Summary of this function goes here
%inputx should contain only one fly or trial and one channel
%S is power
% f is frequency
%Detailed explanation goes here


% obtian power spectrum 

%
%for n =1:n_vldflies

 fly= data;

param.Fs= params.Fs;
param.tapers = params.tapers;

[S,f]= mtspectrumc(fly,param);

save(name5,'S','f')

 %end

 %

 
 
end