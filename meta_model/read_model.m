function moddata = read_model(expname)
  varn={'T_2M','TOT_PREC','CLCT'};
  varf={'t2m','rr','clct'};
  exppath=['/lhome/omarb/calibration_cosmo5/',expname,'/'];
  moddata=NaN(10,12,8,3);

  for ii=1:3
    for r=1:8
      moddat=ncread([exppath,varf{ii},'_mod_',num2str(r),'.nc'],varn{ii});
      if length(moddat) > 120
        display(['Too much data for ', expname, ' variable ', varf{ii}])
      elseif  length(moddat) < 120
        display(['Too little data for ', expname, ' variable ', varf{ii}])
      end
      moddata(:,:,r,ii)=reshape(moddat(1,1,1:120),12,10)';
    end
  end
  moddata(:,:,:,1)=moddata(:,:,:,1)-273.15;
  moddata(:,:,:,3)=moddata(:,:,:,3)*100;
end


