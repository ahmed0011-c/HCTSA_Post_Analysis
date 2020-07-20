%% Get power spectrum for files
%defining variables

load('training_data')
load('validation_Data')
num_channel=15;
fs= 1000; %sampling rate
%% setting up tool kit

path_fieldtrip='/Users/ahmedmahmoud/Desktop/Insomnia Project/fieldtrip-20191213/'; %'/Users/tand0009/Work/local/fieldtrip/';
path_LSCPtools= '/Users/ahmedmahmoud/Desktop/Insomnia Project/LSCPtools/'; %'/Users/tand0009/WorkGit/LSCPtools/';
addpath(path_fieldtrip);
addpath(genpath(path_LSCPtools));
ft_defaults;


%%
cd('/Users/ahmedmahmoud/Downloads/hctsa-master_task2/Fly_data/libsvm-3.24/matlab/power_data')


% plotting raw training data

for i= 1:num_channel
plot(training_data(i,:))

filefig=  sprintf('Local field potential at channel %d training data',i);

xlabel('Time * Sampling frequency') 
ylable('milli volt')
title(filefig)
set(gca,'fontsize',18)

saveas(gcf,filefig);
end

%% plot validation data 

num_channel=15;

for i= 1:num_channel
plot(validation_Data(i,:))

filefig=  sprintf('Local field potential at channel %d validation data',i);

xlabel('Time * Sampling frequency') 
ylable('milli volt')
title(filefig)
set(gca,'fontsize',18)

saveas(gcf,filefig);
end

%% get power spectrum for training data

temp_pow=[];
 for i=1:num_channel
     
     
[faxis,pow]=get_PowerSpec(training_data(i,:),fs,0,0);
 temp_pow=[temp_pow ; pow];


 end
 
 %% get power spectrum for validation data

 temp_pow1 =[];
 for i=1:num_channel
     
     
[faxis1,pow1]=get_PowerSpec(validation_Data(i,:),fs,0,0);
 temp_pow1=[temp_pow1 ; pow1];


 end
 
 %% plot training data

for i= 1:num_channel
  
    channel_number=  sprintf('ch %d',i);

subplot(num_channel,1,i);
plot(training_data(i,:))
ylabel(channel_number)
end
xlabel('time in seconds * Sampling frequency)')

%% plot validation data


for i= 1:num_channel
  
    channel_number=  sprintf('ch %d',i);

subplot(num_channel,1,i);
plot(validation_Data(i,:))
ylabel(channel_number)
end
xlabel('time in seconds * Sampling frequency)')

 %% plot power spectrum for training data
figure;
format_fig;
plot(faxis,temp_pow(1,:),'Color','r','LineWidth',3);
hold on;
plot(faxis,temp_pow(2,:),'Color',[0 0 0.9],'LineWidth',3);
plot(faxis,temp_pow(3,:),'Color',[0 0 0.5],'LineWidth',3);
plot(faxis,temp_pow(4,:),'Color',[0 0.9 0.2],'LineWidth',3);
plot(faxis,temp_pow(5,:),'Color',[1 1 0],'LineWidth',3);
plot(faxis,temp_pow(6,:),'Color',[0 1 1],'LineWidth',3);
plot(faxis,temp_pow(7,:),'Color',[0 0 1],'LineWidth',3);
plot(faxis,temp_pow(8,:),'Color',[0.75 0.75 0],'LineWidth',3);
plot(faxis,temp_pow(9,:),'Color',[0.75 0 0.75],'LineWidth',3);
plot(faxis,temp_pow(10,:),'Color',[0 0.75 0.75],'LineWidth',3);
plot(faxis,temp_pow(11,:),'Color',[0.635 0.0780 0.1840],'LineWidth',3);
plot(faxis,temp_pow(12,:),'Color',[0.4660, 0.6740, 0.1880],'LineWidth',3);
plot(faxis,temp_pow(13,:),'Color',[0.4940, 0.1840, 0.5560],'LineWidth',3);
plot(faxis,temp_pow(14,:),'Color',[0.8500, 0.3250, 0.0980],'LineWidth',3);
plot(faxis,temp_pow(15,:),'Color',[0.3010, 0.7450, 0.9330] ,'LineWidth',3);

ylabel('Power')
xlabel('Freq (Hz)')
%legend(myStagesName([1 3 4 5]))
%legend(t([1 3 4 5]))
xlim([1 30])
format_fig;
%title(figname)

%%
figure;
format_fig;
plot(faxis1,temp_pow1(1,:),'Color','r','LineWidth',3);
hold on;
plot(faxis1,temp_pow1(2,:),'Color',[0 0 0.9],'LineWidth',3);
plot(faxis1,temp_pow1(3,:),'Color',[0 0 0.5],'LineWidth',3);
plot(faxis1,temp_pow1(4,:),'Color',[0 0.9 0.2],'LineWidth',3);
plot(faxis1,temp_pow1(5,:),'Color',[1 1 0],'LineWidth',3);
plot(faxis1,temp_pow1(6,:),'Color',[0 1 1],'LineWidth',3);
plot(faxis1,temp_pow1(7,:),'Color',[0 0 1],'LineWidth',3);
plot(faxis1,temp_pow1(8,:),'Color',[0.75 0.75 0],'LineWidth',3);
plot(faxis1,temp_pow1(9,:),'Color',[0.75 0 0.75],'LineWidth',3);
plot(faxis1,temp_pow1(10,:),'Color',[0 0.75 0.75],'LineWidth',3);
plot(faxis1,temp_pow1(11,:),'Color',[0.635 0.0780 0.1840],'LineWidth',3);
plot(faxis1,temp_pow1(12,:),'Color',[0.4660, 0.6740, 0.1880],'LineWidth',3);
plot(faxis1,temp_pow1(13,:),'Color',[0.4940, 0.1840, 0.5560],'LineWidth',3);
plot(faxis1,temp_pow1(14,:),'Color',[0.8500, 0.3250, 0.0980],'LineWidth',3);
plot(faxis1,temp_pow1(15,:),'Color',[0.3010, 0.7450, 0.9330] ,'LineWidth',3);

ylabel('Power')
xlabel('Freq (Hz)')
%legend(myStagesName([1 3 4 5]))
%legend(t([1 3 4 5]))
xlim([1 30])
format_fig;
%title(figname)
