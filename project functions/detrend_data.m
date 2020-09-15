function [datafd] = detrend_data(data,params,name3)
%DETREND_DATA Summary of this function goes here
%   Detailed explanation goes here




% step 2
% linear detrend the data
   % for index= 1:num_channel
    
datafd= detrend(data(:,:));



 save(name3,'datafd')

  

end

