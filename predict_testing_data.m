
%% Predict Rihanon's data

num_channels= 15;
% y is the threshold map
y= Thresholds;
% bias mean  is the bias map{0/1}
bias_mean= bias;

trials= 56;

  
 for channels = 1:num_channels
       
     for operation_inv= 1:size(top_position,2) %:size(test_data,2)   %top
      
         ch= channels-1;
             for i= 1:trials
            
            test = test_data(i,channels,operation_inv);
            
            %ARGUMENT 1 BIAS = 1 
            
        
           if    isnan(y(channels,operation_inv)) == 1   %bias_mean(channels,operation_inv) == 1 &&
               
                predict(i,channels,operation_inv) = nan;
                disp('not a real number')
           
           
           elseif   isnan(y(channels,operation_inv)) == 1  %bias_mean(channels,operation_inv) == 0 && 
               
               predict(i,channels,operation_inv) = nan;
                disp('not a real number')
                
           elseif bias_mean(channels,operation_inv) == 1 &&   test >= y(channels,operation_inv) 
              
               disp('condition is awake')
               predict(i,channels,operation_inv) = 1;
               
           elseif  bias_mean(channels,operation_inv) == 1  &&   test < y(channels,operation_inv) 
                predict(i,channels,operation_inv) = 0;
                disp('condition is anaesthesia')
                
             %ARGUMEN  2 BIAS = 0
                               
           elseif  bias_mean(channels,operation_inv) == 0 &&   test <= y(channels,operation_inv) 
               
               disp('condition is awake')
               predict(i,channels,operation_inv) = 1;
               
              
               
           elseif  bias_mean(channels,operation_inv) == 0 &&   test > y(channels,operation_inv) 
                predict(i,channels,operation_inv) = 0;
                disp('condition is anaesthesia')
           end
          
               
         
           
        end
    end
end