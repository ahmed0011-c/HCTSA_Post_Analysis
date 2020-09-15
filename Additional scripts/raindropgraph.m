%raindrop code
%% for single channel


for ch= 1:15
trialw= squeeze(z_wa(1,ch,:));
trials= squeeze(z_sa(1,ch,:));

climw = prctile(trialw, [5 95]);

%removing upper outliers
 [xw,i]= find(trialw>climw(1,2));
 trialw(xw)=[];
 %removing lower outliers
 [xw,i]= find(trialw<climw(1,1));
  trialw(xw)=[];
  
clims = prctile(trials, [5 95]);
 [xs,i]= find(trials>clims(1,2));
 trials(xs)=[];
 %removing lower outliers
 [xs,i]= find(trials<clims(1,1));
  trials(xs)=[];

z_awake= trialw;
z_sleep= trials;

z_value_awake(ch,1)= mean(z_awake);
z_value_awake(ch,2)= std(z_awake);

z_value_sleep(ch,1)= mean(z_sleep);
z_value_sleep(ch,2)= std(z_sleep);
mydata{ch,1}= squeeze(test(:,ch,:));
end
     
%% dealing with outliers
for ih= 1 %:15
     
trial = mydata{ih,1};
clim = prctile(trial, [5 95]);
%removing upper outliers
 [x,i]= find(trial>clim(1,2));
 trial(x)=[];
 %removing lower outliers
 [x,i]= find(trial<clim(1,1));
  trial(x)=[];
  mydata{ih,1}= trial;
end
 
%%
h   = rm_raincloud(mydata_1, cls);

 for ih= 1:16
errorbar(z_value_sleep(ih,1),z_value_sleep(ih,3),z_value_sleep(ih,2),'horizontal','-s','MarkerSize',10,...
    'MarkerEdgeColor','blue','MarkerFaceColor','blue')

errorbar(z_value_awake(ih,1),z_value_awake(ih,3),z_value_awake(ih,2),'horizontal','-s','MarkerSize',10,...
    'MarkerEdgeColor','red','MarkerFaceColor','red')

 end
