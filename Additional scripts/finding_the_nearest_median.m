%%Finding the nearest median

% defining variables
load('data.mat')
HCTSA_18s=data;

num_channel=15; % number of channels
num_fly=13;     % number of flies
condition2_start = size(HCTSA_18s,1)/2;  
condition_one= HCTSA_18s(1:condition2_start,:);


%% Method


%channel_idx = 1;
%for ch= 1:num_channel
    for op_idx = 1:size(HCTSA_18s,2)
    op_under_inv = HCTSA_18s(:,op_idx);
    condition1_under_inv_glo = op_under_inv(1:condition2_start);
    condition2_under_inv_glo = op_under_inv(1+condition2_start:end);
    idx = 1;
       for channel_idx = 1:num_channel
        result_idx = 1;
            for fly_idx = 1:num_fly
                i= channel_idx-1;
            condition1_under_inv = condition1_under_inv_glo((num_fly*i)+1:num_fly*(i+1),:);
            ele_condition1_under_inv = condition1_under_inv(fly_idx);
            condition1_under_inv(fly_idx) = [];
          con1_flies_lo_ch(:,fly_idx,channel_idx,op_idx) = condition1_under_inv;
          
            mean_condition1_under_inv = nanmedian(condition1_under_inv);    % method
           % for fly_idx_comb = 1:num_fly
                condition2_under_inv = condition2_under_inv_glo((num_fly*i)+1:num_fly*(i+1),:);        
                ele_condition2_under_inv = condition2_under_inv(fly_idx);
                condition2_under_inv(fly_idx) = [];
            con2_flies_lo_ch(:,fly_idx,channel_idx,op_idx) = condition2_under_inv;

                mean_condition2_under_inv = nanmedian(condition2_under_inv);   %method
                [~,pred_ele_condition1_under_inv(result_idx,op_idx)] = min([abs(ele_condition1_under_inv - mean_condition1_under_inv),...
                abs(ele_condition1_under_inv - mean_condition2_under_inv)]);
                [~,pred_ele_condition2_under_inv(result_idx,op_idx)] = min([abs(ele_condition2_under_inv - mean_condition1_under_inv),...
                abs(ele_condition2_under_inv - mean_condition2_under_inv)]);
            
                if pred_ele_condition1_under_inv(result_idx,op_idx) == 1 && pred_ele_condition2_under_inv(result_idx,op_idx) == 2
                    accuracy(result_idx,op_idx,channel_idx) = 1;
                elseif pred_ele_condition1_under_inv(result_idx,op_idx) == 1 || pred_ele_condition2_under_inv(result_idx,op_idx) == 2
                    accuracy(result_idx,op_idx,channel_idx) = 0.5;
                else
                    accuracy(result_idx,op_idx,channel_idx) = 0;
                end
                result_idx = result_idx+1;
          %  end
        end
        accuracy_per_op(idx,op_idx) = mean(accuracy(:,op_idx,channel_idx));
        std_accuracy_per_op(idx,op_idx) = std(accuracy(:,op_idx,channel_idx));
        idx = idx + 1;
       end
       
       fprintf('Operation %d out of %d is done \n',op_idx,size(HCTSA_18s,2));

    end
       %% getting threshold
       
       for ch= 1:num_channel
    
    for iter= 1:size(HCTSA_18s,2)
       
       for flies= 1:num_fly
    
    condition_1= con1_flies_lo_ch(:,flies,ch,iter); 
    
      means_condition1_under_inv(:,flies,ch,iter) = nanmedian(condition_1);  % change method

    condition_2= con2_flies_lo_ch(:,flies,ch,iter);
    
  means_condition2_under_inv(:,flies,ch,iter) = nanmedian(condition_2);     %change method
  
  tryal= [means_condition1_under_inv(:,flies,ch,iter);means_condition2_under_inv(:,flies,ch,iter)];
  
      Threshold_value(ch,flies,iter)= mean(tryal); % sorted in channels/ cross-validation/ operation

  
        end
     end
  end
  
 for  ch= 1:num_channel
   for i= 1:size(HCTSA_18s,2)
 
       trial= Threshold_value(ch,:,i);
       Thresholds(ch,i)= mean(trial);
       
   end    
 end
     
       
       
       %%
       z= Thresholds;
num_channels= 15;
num_fly= 13;
trials= 10;

for operation_inv= 1:size(condition_one,2)
    for channels = 1:num_channels
        i= channels-1;
        %for i= 1:trials
            
            con1= condition_one((num_fly*i)+1:num_fly*(i+1),operation_inv);   
          
            test= mean(con1);
            
                
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
end

   
   
    
    
