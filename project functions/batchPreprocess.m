function [datafdn] = batchPreprocess(Job,allocate,params)
%BATCHPREPROCESS Summary of this function goes here

%Rih_Tr56_bCh7.mat
%Dr_Fl3_Aw_bCh7_2

%gettin what files




i= allocate.fly;
ix= allocate.channel;
ih= allocate.trial;


if allocate.data== 1
name1 =  sprintf('Dr_Fl%d_Aw_bCh%d_2.mat',i,ix);

name2 =  sprintf('Dr_Fl%d_Aw_bCh%d_2_tp3_5.mat',i,ix);

name3 =  sprintf('Dr_Fl%d_Aw_bCh%d_2_tp3_5_dt.mat',i,ix);

name4 =  sprintf('Dr_Fl%d_Aw_bCh%d_2_tp3_5_dt_zc.mat',i,ix);

name5= sprintf('powersc_Dr_Fl%d_Aw_bCh%d',i,ix);

elseif  allocate.data== 2
   
name1 =  sprintf('Dr_Fl%d_An_bCh%d_2.mat',i,ix);

name2 =  sprintf('Dr_Fl%d_An_bCh%d_tp3_5.mat',i,ix);

name3 =  sprintf('Dr_Fl%d_An_bCh%d_2_tp3_5_dt.mat',i,ix);

name4 =  sprintf('Dr_Fl%d_An_bCh%d_2_tp3_5_dt_zc.mat',i,ix);

name5= sprintf('powersc_An_Fl%d_Aw_bCh%d',i,ix);

else
    
name1 =  sprintf('Rih_Tr%d_bCh%d.mat',ih,ix);

name2 =  sprintf('Rih_Tr%d_bCh%d_tp3_5.mat',ih,ix);

name3 =  sprintf('Rih_Tr%d_bCh%d_tp3_5_dt.mat',ih,ix);

name4 =  sprintf('Rih_Tr%d_bCh%d_tp3_5_dt_zc.mat',ih,ix);

name5 =  sprintf('powersc_Rih_Tr%d_bCh%d.mat',ih,ix);

end





%% assigning jobs    0  to avoid  /  1 to compute

%(1) pre-process data

if Job.remlinenoise ==1 
    
    data =importdata(name1);
 
    [dataf] = getfilter(data,params,name2)  ;
    
end

if Job.detrend == 1 
    
    data =importdata(name2);
    
  [datafd] =detrend_data(data,params,name3);
    
end

if Job.zscore == 1

    data =importdata(name3);
    
 [datafdn]=  normalize_data(data,params,name4);
    
end



% (2) preform power calculation

if Job.powersc== 1
    
    data =importdata(name4);
    
 [S,f]= getpower(data,params,name5);
    
end


% (3) plot output





end

