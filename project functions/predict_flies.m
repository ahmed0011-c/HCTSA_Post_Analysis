function [predict_condition] = predict_flies(testdata,lol_threshold,dirction,allocate,params)
%PREDICT_FLY Summary of this function goes here
%   Detailed explanation goes here

%test_data= HCTSA_validation;
%% Predict Rihanon's data

num_channels= params.num_channel ;
% y is the threshold map

y= lol_threshold;
% bias mean  is the bias map{0/1}
bias_mean= dirction;

trials=params.validation_trials;%= 56;

 operation = allocate.operation;
 
 
 %% re-organize
 
 for i= 1:size(testdata,2)   %operations n
     for i1 =1:num_channels
         ch= i1-1;
         
         for i2 = 1:trials  
             
          test_data(i2,i1,i)= testdata(i2+(56*ch),i);
             
             
         end
         
     end
     
 end
 
 
 %%
 
 for channels = allocate.channel %1:num_channels
       
    for operation_inv= operation %:size(test_data,2)   %top
      
        % ch= channels-1;
       for i= 1:trials
            
            test = test_data(i,channels,operation_inv);
            
           % test= test_data(1+(channels*ch):trials*channels,operation_inv);
            
            %ARGUMENT 1 BIAS = 1 
            
        
           if   isnan(y) == 1  %isnan(y(channels,operation_inv)) == 1   %bias_mean(channels,operation_inv) == 1 &&
               
                predictv(i,channels,operation_inv) = nan;
                disp('not a real number')
           
           
           elseif  isnan(y) == 1  %isnan(y(channels,operation_inv)) == 1  %bias_mean(channels,operation_inv) == 0 && 
               
               predictv(i,channels,operation_inv) = nan;
                disp('not a real number')
                
           elseif bias_mean == 1 &&   test >= y %bias_mean(channels,operation_inv) == 1 &&   test >= y(channels,operation_inv) 
              
               disp('condition is awake')
               predictv(i,channels,operation_inv) = 1;
               
           elseif  bias_mean == 1  &&   test < y 
                predictv(i,channels,operation_inv) = 0;
                disp('condition is anaesthesia')
                
             %ARGUMEN  2 BIAS = 0
                               
           elseif  bias_mean == 0 &&   test <= y
               
               disp('condition is awake')
               predictv(i,channels,operation_inv) = 1;
               
              
               
           else  %bias_mean == 0 &&   test > y
                predictv(i,channels,operation_inv) = 0;
                disp('condition is anaesthesia')
           end
          
               
         
           
        end
    end
end


predict_condition= predictv(:,channels,operation_inv);



end

