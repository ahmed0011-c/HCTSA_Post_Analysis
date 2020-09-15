function [outputArg1,outputArg2,outputArg3,outputArg4] = getplots(inputArg,inputpw,inputf,param)
%GETPLOTS Summary of this function goes here
%   Detailed explanation goes here
% requires three data types  Awake/Anesthesia/Validtion data to be written
% in this specific order awake{1},anesthesia{2},validation{3} for each
% variable of the following:
%(1) inputArg should contain time-series
%(2) inputpw should include power values
%(3) input should include frequency values
% params should consist of fly or trial number and channel number
%for example
% param(1,:)=  1  ; %trial 1 fly 1
%param(2,:) = 1 ; channel1


%% plot time-Series   (First)


% for ix= 1:trials
%     for i= 1:num_channel
%     
   Awake_processed= inputArg{1};
   Anesthesia_processed= inputArg{2};
   validation_processed= inputArg{3};
    
    plot(Awake_processed(:,:),'Color',[1 0 0],'LineWidth',3,'DisplayName','Dror Awake');  % 1 for awake
    hold on
    plot(Anesthesia_processed(:,:),'Color',[0 0 0],'LineWidth',3,'DisplayName','Dror Anesthesia'); % 2 for anesthesia
    hold on
    plot(validation_processed(:,:),'Color',[0 0 1],'LineWidth',3,'DisplayName','Rihanon');
    hold off

legend({'Dror Awake','Dror Anesthesia','Rihanon'},'Location','northeast','Orientation','horizontal')

filefig= sprintf('Comparison_of_timeseries_one_fly_at_channel_%d for trial %d.png',param(2,:),param(1,:);
% filefig=  sprintf('Comparison_of_Power_sectrum_from_one_fly_at_channel_%d.png ',i);
 fig=  sprintf('Comparison of Time-Series between validation and training data for one fly at channel %d for trial %d',param(2,:),param(1,:)); %d.png',i);

ylabel('Z-score')
xlabel('Time points')
%format_fig;
title(fig)
set(gca,'fontsize',9);
saveas(gcf,filefig);

%     end
% end

%% plotting results of the power spectrum  (second)



% for ix= 1:trials
%     for i= 1:num_channel
    
    S_awake= inputpw{1};
    f= inputf{1};
    
    S_anesthesia= inputpw{2};
    f1= inputf{2};
    
    S_validation= inputpw{3};
    f2= inputf(3};
    
    
    plot(f,log(S_awake),'Color',[1 0 0],'LineWidth',3,'DisplayName','Dror Awake');
    hold on
    plot(f1,log(S_anesthesia),'Color',[0 0 0],'LineWidth',3,'DisplayName','Dror Anesthesia');
    hold on
    plot(f2,log(S_validation),'Color',[0 0 1],'LineWidth',3,'DisplayName','Rihanon');
    hold off

legend({'Dror Awake','Dror Anesthesia','Rihanon'},'Location','northeast','Orientation','horizontal')

filefig= sprintf('Comparison_of_Power_sectrum_from_one_fly_at_channel_%d for trial %d.png',param(2,:),param(1,:));
% filefig=  sprintf('Comparison_of_Power_sectrum_from_one_fly_at_channel_%d.png ',i);
 fig=  sprintf('Comparison of Power spectrum between validation and training data for one fly at channel %d for trial %d',param(2,:),param(1,:)); %d.png',i);

ylabel('Log(Power)')
xlabel('Freq (Hz)')
xlim([1 120])
%format_fig;
title(fig)
set(gca,'fontsize',9);
saveas(gcf,filefig);
%     end
% end
%[0 0 1], blue
% [1,0,0] red
%[0,0,0] black



%% plotting results of the power spectrum  (Third)


% S_validation is    16385          15          56

% S_train is  16385          15           1          13

target{1}= [1:165]; %in 1-5 hz validation  / awake
spectrum(1,:)= [1,5];
target{2}= [165:329]; % 5-10Hz
spectrum(2,:)= [5,10];
target{3}= [657:1312]; % 20-40Hz
spectrum(3,:)= [20,40];
target{4}= [1968:2951]; %60-90Hz
spectrum(4,:)= [60,90];

% trials=56;
% flies=13;
% channel=6;

 for ix= 1:4
%         for i= 1:flies
      
pw1 = S_awake(target{ix});
pw2 = S_anesthesia(target{ix});



awake_values = mean(log(pw1));
anesthesia_values= mean(log(pw2));



      % end
   
      % for i2= 1:trials
 
           
  pw = S_validation(target{ix});
  validation_values = mean(log(pw));
  
 % end
%end
% plotting power spectrum between different frequencies (1-5hz), (5-10Hz), (20-40Hz) and (60-90Hz)
%
fig_position = [200 200 600 400];
%  for i=2
  
     
     filefigs=  sprintf('data comparison at channel %d trial %d for spectrum range %d to %d Hz.png',param(2,:),param(1,:),spectrum(ix,1),spectrum(ix,2));
     files=  sprintf('data comparison  at channel %d trial %d for spectrum range %d  to %d Hz',param(2,:),param(1,:),spectrum(ix,1),spectrum(ix,2));

     d{1}= validation_values(:);
     d{2}= awake_values(:);
     d{3}= anesthesia_values(:);

f7 = figure('Position', fig_position);
%subplot(1, 2, 1)
h1 = raincloud_plot(d{1}, 'box_on', 1, 'color',[1 0 0], 'alpha', 0.5,...
     'box_dodge', 1, 'box_dodge_amount', .15, 'dot_dodge_amount', .15,...
     'box_col_match', 0);
h2 = raincloud_plot(d{2}, 'box_on', 1, 'color',[0 0 0], 'alpha', 0.5,...
     'box_dodge', 1, 'box_dodge_amount', .35, 'dot_dodge_amount', .35, 'box_col_match', 0);
 
h3 = raincloud_plot(d{3}, 'box_on', 1, 'color', [0 0 1], 'alpha', 0.5,...
     'box_dodge', 1, 'box_dodge_amount', .35, 'dot_dodge_amount', .35, 'box_col_match', 0); 
 
%legend([h1{1} h2{1}], {'Group 1', 'Group 2'});
%title(['Figure M7' newline 'A) Dodge Options Example 1']);
%set(gca,'XLim', [0 40], 'YLim', [-.075 .15]);
%box off
xlabel('Mean(Log(power)')
ylabel('K density')
title(files)
set(gca,'fontsize',9)
legend('validation data','validation data','','','Awake','Awake','','','Anesthesia','Anesthesia','Location','northwest')
 saveas(gcf,filefigs)
  end




outputArg1 = inputArg;
outputArg2 = inputpw;
outputArg3 = inputf;
outputArg4=param;

end