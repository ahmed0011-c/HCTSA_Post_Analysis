%Spearman's rank correlation coefficient
num_channels=15;

%load the thresholds for multiple methods

for i= 1:num_channels
correlation_mat(:,1,i)= mean_Thresholds(:,i);
correlation_mat(:,2,i) = median_Thresholds(:,i);
correlation_mat(:,3,i) = svm_thresholds(:,i);
end

%%

for i= 1:num_channels

    [rho(:,:,i),pval(:,:,i)]= corr(correlation_mat(:,:,1),'Type','Spearman','Rows','pairwise') ;

end

%%
for i=1:operations
    
    X= data(:,i);
    
if any(isnan(X(:)))
    xmu=nanmean(X);
    xsigma=nanstd(X);
    x=(X-repmat(xmu(:,i),length(X),1))./repmat(xsigma(),length(X),1);
else
    [x(:,i),xmu(:,i),xsigma(:,i)]=zscore(X);
    
    end
    
    
end
