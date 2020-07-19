%Analysis_(SVM)

%%
% get classifcation accuracy
operations_seg= 728;
j=1;
num_channels= 15;
operations= 7280;
num_CV=13;
%load('Xtrain'); %HCTSA Data
num_flies= 13;
%% obtaining classification accuracy



for i=1:10
    
    idx= i-1;
    name= sprintf('%d_%d.mat',j,i);
    load(name)
    
    for channels= 1:num_channels
        for opinv = 1+(operations_seg*idx):operations_seg*i
            
            trial= classification(channels,opinv);
            accuracies(channels,opinv) = trial.accuracy;
            
        end
    end
            
            
 end

  %  svm_classification(:,1+(operations*idx):operations*i) = classification(:,1+(operations*idx):operations*i);

  %% Obtaining top Operation in terms of classification accuracy
    
  
    for i2= 1:num_channels
        
        
 [axis(i2,:),position(i2,:)] = sort(accuracies(i2,:), 'descend');
 top_position(i2,:)= position(i2,1:100); % location of top_operations
 sorted_CA(i2,:) = sort(accuracies(i2,:), 'descend'); % sorted classification accuracy Mat file in descending order
 
 top_operations(i2,:)=  sorted_CA(i2,1:100);
    end
    
  %% getting svm thresholds 
  % Threshold =-b/w
   
  % Calculate the Z-score


  for i=1:10
    
    idx= i-1;
    name= sprintf('%d_%d.mat',j,i);
    load(name)
    
   for channels= 1 : num_channels
        for opinv = 1+(operations_seg*idx):operations_seg*i
           for index= 1:num_CV
    
    trial = classification(channels,opinv);
     x= struct2cell(trial.svms{index,1});
    h= full(x{11,1});
    w(index)= (h' * trial.svms{index,1}.sv_coef);  %classification.svms{index,1}.sv_coef)
    b(1,index)= trial.svms{index,1}.rho;
    threshold(1,index)= trial.svms{index,1}.rho/ (h' * trial.svms{index,1}.sv_coef);

        end
         mean_threshold(channels,opinv)= mean(threshold');
     end
   end 
   
  end
 
  %%  obtaining Z-score
  % Z-score= X(observation)- Threshold / Standard deviation
  
%   
  for i=1:10
%     
     idx= i-1;
   name= sprintf('%d_%d.mat',j,i);
    load(name)
  
     for i2 = 1:num_channels
          for opinv = 1+(operations_seg*idx):operations_seg*i %operation under investigation
              for i3= 1: num_flies
         
      
   Threshold= mean_threshold(i2,opinv);
   sd= nanstd(Xtrain(:,i2,opinv));
   %observation
   
 xawake = Xtrain(i3,i2,opinv); % awake
x2= Xtrain(i3+ num_flies,i2,opinv); % anesthesia 
      



z_score_awake(i3,i2,opinv) = (xawake- Threshold)/ sd;
z_score_anaesthesia(i3,i2,opinv) = (x2 - Threshold)/ sd;

              end 
          z_score_W(i2,opinv)= nanmean(z_score_awake(:,i2,opinv));
          z_score_S(i2,opinv)= nanmean(z_score_anaesthesia(:,i2,opinv));
         end
     end
       
  end
%  


 
 %% getting bias
 
 %defining variables
 z= mean_threshold;


%
for operation_inv= 1:operations
    for channels = 1:num_channels
        i= channels-1;
        %for i= 1:trials
            
            con1= Xtrain(1:num_flies,channels,operation_inv);
          
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
end

   
 
 
 
%%    Obtaining top Operation in terms of classification accuracy


 
       for i2= 1:num_channels
        
        
 [axis(i2,:),position(i2,:)] = sort(accuracy_per_op(i2,:), 'descend');
 top_position(i2,:)= position(i2,1:100); % location of top_operations
 sorted_CA(i2,:) = sort(accuracy_per_op(i2,:), 'descend'); % sorted classification accuracy Mat file in descending order
 
 top_operations(i2,:)=  sorted_CA(i2,1:100);
    end
      
      
      
      %% plotting the Z-score Map for top operation
 
  
  for i= 1:num_channels
      
bias_mod(i,:)= bias(i,top_position(i,:));


z_score_W_mod(i,:)= z_score_W(i,top_position(i,:));

z_score_S_mod(i,:)= z_score_S(i,top_position(i,:));
  end
  
%%
  for i =1:size(top_operations,2)
    for ix= 1:num_channels
        
     b= bias_mod(ix,i);
       if b ==0
    z_score_W_mod(ix,i) = z_score_W_mod(ix,i)*-1;
    
    z_score_S_mod(ix,i) = z_score_S_mod(ix,i)*-1;
        end
    end 
  end
      
     
  %%
  for ix= 1:num_channels
      for i= 1:size(top_operations,2)
          
          
  if z_score_W_mod(ix,i) < 0 
      
      zvalue_W(ix,i)=  -1;
      
  else 
       zvalue_W(ix,i) = 1;
  end
  
        if z_score_S_mod(ix,i) < 0 
      
      zvalue_sleep(ix,i)=  -1;
      
  else 
       zvalue_sleep(ix,i) = 1;
       
        end
      end
  end
  
  %%
  for i= 1: size(top_operations,2)
      for i2 = 1: num_channels
          
 test_x_av= test(:,i2,top_position(i2,i));
 test_x= mean(test_x_av);
 test_sd_x = std(test_x_av);
 
 z_value(i2,i)= (test_x - mean_threshold(i2,top_position(i2,i)) )/ standard_dev(i2,top_position(i2,i));
 standard_error(i2,i)=  test_sd_x;
      end
  end
  
  %%
  plot(z_score_W_mod(1,:),'-s','MarkerSize',10,...
    'MarkerEdgeColor','black','MarkerFaceColor','black')
hold on
plot(z_score_S_mod(1,:),'-s','MarkerSize',10,...
    'MarkerEdgeColor','blue','MarkerFaceColor','blue')
plot(z_value(1,:),'-s','MarkerSize',10,...
    'MarkerEdgeColor','red','MarkerFaceColor','red')
hold off
    
title('Zscore map for SVM method at Channel 1')
xlabel('Top operations 100')
ylabel('Z value');
set(gca,'fontsize',18)

%%

for index= 1:num_CV
    
    %trial = classification(channels,opinv);
    x= struct2cell(trial.svms{index,1});
    h= full(x{11,1});
    w(index)= (h' * trial.svms{index,1}.sv_coef);  %classification.svms{index,1}.sv_coef)
    b(1,index)= trial.svms{index,1}.rho;
    threshold(1,index)= trial.svms{index,1}.rho/ (h' * trial.svms{index,1}.sv_coef);

  end
