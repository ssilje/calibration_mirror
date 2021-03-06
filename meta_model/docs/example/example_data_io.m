% Simulation selection vector
sel=[1:128];

snameb='cal_ea'; % Base name of simulations

for i=1:length(sel)
  sims{i}=[snameb num2str(sel(i))];
end

sel=[78,83,90,101,123];

snameb='cal_f'; % Base name of simulations

for i=1:length(sel)
  cons{i}=[snameb num2str(sel(i))];
end


% Validation selection vector
sel=[1:10];
snameb='cal_ealh'; % Base name of simulations

for i=1:length(sel)
  vals{i}=[snameb num2str(sel(i))];
end

startyr=1994;endyr=1998;vars={'t2m','pr','clct'};
indir='/data/omarb/calibration';
indiro='/lhome/omarb/observations';

datamatrix.moddata=read_cal_f(startyr,endyr,vars,sims,indir);
datamatrix.valdata=read_cal_f(startyr,endyr,vars,vals,indir);
indir='/lhome/omarb/calibration';
indiro='/lhome/omarb/observations';

datamatrix.constrain=read_cal_f(startyr,endyr,vars,cons,indir);
datamatrix.refdata=read_cal_f(startyr,endyr,vars,{'cal_ref2'}, ...
			      indir);
datamatrix.obsdata=read_obs_f(startyr,endyr,vars,indiro);
datamatrix.variables={4,'T2M','PR','CLCT'};
datamatrix.limits={[-inf inf],[0 inf],[0 100]}; %Physical limits of
                                                %variables
save('./data/datamatrix_cal_ea','datamatrix')
