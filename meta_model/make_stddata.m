clear all
close all



ndomains=11;

dir_cal_error='/hymet/ssilje/CALIBRATION_CA_emmanuele/data/bellprat_cal_error';
%iv=iv_n; stdobs=stdobs_n; err=err_n;
for i=1:ndomains
    %% reading iv_error  --> stdobs
    %iv_error the observations interannual variability (12 values)
    dataname=[dir_cal_error '/iv_error/std_fld_clu' num2str(i) '_merge_mm.nc'];
    
    iv_data_T2M=squeeze(squeeze(ncread([dataname],'tmp')));
    iv_T2M(:,i)=iv_data_T2M;
    clear iv_data_T2M
    
    iv_data_TOT_PREC=squeeze(squeeze(ncread([dataname],'p')));
    iv_TOT_PREC(:,i)=iv_data_TOT_PREC;
    clear iv_data_TOT_PREC
    
    iv_data_CLCT=squeeze(squeeze(ncread([dataname],'cld')));
    iv_CLCT(:,i)=iv_data_CLCT;
    clear iv_data_CLCT
    
    
    %% reading model_error --> iv
    %model_error standard deviation at each month calculated over a small ensemble of 15-year long simulations changing initial conditions (120
    dataname=[dir_cal_error '/model_error/std_clu' num2str(i) '_merge_mm_dm.nc'];
    
    err_data_model_T2M=squeeze(squeeze(ncread([dataname],'T_2M')));
    err_model_T2M(:,i)=err_data_model_T2M;
    clear err_data_model_T2M
    
    err_data_model_TOT_PREC=squeeze(squeeze(ncread([dataname],'TOT_PREC')));
    err_model_TOT_PREC(:,i)=err_data_model_TOT_PREC;
    clear err_data_model_TOT_PREC
    
    err_data_model_CLCT=squeeze(squeeze(ncread([dataname],'CLCT')));
    err_model_CLCT(:,i)=err_data_model_CLCT;
    clear err_data_model_CLCT
    
    
    %% reading obs_error --> err
    %obs_error observational standard deviation, derived from three datasets, at each month (120 values)
    dataname=[dir_cal_error '/obs_error/std_fld_clu' num2str(i) '_merge_mm.nc'];
    
    err_data_obs_T2M=squeeze(squeeze(ncread([dataname],'tmp')));
    err_obs_T2M(:,i)=err_data_obs_T2M;
    
    clear err_data_obs_T2M
    
    err_data_obs_TOT_PREC=squeeze(squeeze(ncread([dataname],'p')));
    err_obs_TOT_PREC(:,i)=err_data_obs_TOT_PREC;
    
    clear err_data_obs_TOT_PREC
    
    err_data_obs_CLCT=squeeze(squeeze(ncread([dataname],'cld')));
    err_obs_CLCT(:,i)=err_data_obs_CLCT;
    
    clear err_data_obs_CLCT
    
    
end
%%obs_error --> err
err_T2M=reshape(err_obs_T2M,10,12,11);
err_TOT_PREC=reshape(err_obs_TOT_PREC,10,12,11);
err_CLCT=reshape(err_obs_CLCT,10,12,11);


%iv_error --> stdobs
stdobs_T2M=iv_T2M;
stdobs_TOT_PREC=iv_TOT_PREC;
stdobs_CLCT=iv_CLCT;

%model_error --> iv
iv_T2M=reshape(err_model_T2M,10,12,11);
iv_TOT_PREC=reshape(err_model_TOT_PREC,10,12,11);
iv_CLCT=reshape(err_model_CLCT,10,12,11);

for i=1:5
    for j=1:12
        iv_n(i,j,:,1)=squeeze(nanmean(iv_T2M(:,j,:),1));
        iv_n(i,j,:,2)=squeeze(nanmean(iv_TOT_PREC(:,j,:),1));
        iv_n(i,j,:,3)=squeeze(nanmean(iv_CLCT(:,j,:),1));
        
        err_n(i,j,:,1)=squeeze(nanmean(err_T2M(:,j,:),1));
        err_n(i,j,:,2)=squeeze(nanmean(err_TOT_PREC(:,j,:),1));
        err_n(i,j,:,3)=squeeze(nanmean(err_CLCT(:,j,:),1));
        
        stdobs_n(i,j,:,1)=squeeze(stdobs_T2M(j,:));
        stdobs_n(i,j,:,2)=squeeze(stdobs_TOT_PREC(j,:));
        stdobs_n(i,j,:,3)=squeeze(stdobs_CLCT(j,:));
    end
end



save stddata_2000-2004_CA.mat iv_n err_n stdobs_n


