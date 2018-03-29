% ---------------------------------------------------------------
% Script to read the model data for the COSMO5-POMPA Experiments
% Author: Omar Bellprat (omar.bellprat@gmail.com)
% Date: 21.2.2018
% ---------------------------------------------------------------
% Read observational data
obsdata=read_obs('observations');

% Read alternative observations to determine
% observational uncertainty
obsdata2=read_obs('observations_alt2');
obsdata2(:,:,:,2)=obsdata2(:,:,:,2)/30;
obsdata3=read_obs('observations_alt3');
obsdata3(:,:,:,2)=obsdata2(:,:,:,2)/3;

% Calculate observational uncertainty
obsall=NaN([3,10,12,8,3]);
obsall(1,:,:,:,:)=obsdata;
obsall(2,:,:,:,:)=obsdata2;
obsall(3,:,:,:,:)=obsdata3;
% err=squeeze(nanstd(obsall,1));

% Read model data
expid={'rl','v','tk','u','ra','f','c','tu'};
N=length(expid);
refdata=read_model('reference');
optdata=read_model('optimised');

moddata=NaN(10,12,8,3,128);

for i=1:N
  moddata(:,:,:,:,(i-1)*2+1)=read_model([expid{i},'n']);
  moddata(:,:,:,:,(i-1)*2+2)=read_model([expid{i},'x']);
end

% Compute index vector for all possible pairs
pqn=allcomb(1:N,1:N);

cnt=1;
for i=1:length(pqn)
  if pqn(i,1)>=pqn(i,2)
   cind(cnt)=i;
   cnt=cnt+1;
  end
end
pqn(cind,:)=[];

for i=1:length(pqn)
  expn=[expid{pqn(i,1)},'n_',expid{pqn(i,2)},'n'];
  moddata(:,:,:,:,N*2+i)=read_model(expn);
end
  
for i=1:length(pqn)
  expn=[expid{pqn(i,1)},'n_',expid{pqn(i,2)},'x'];
  moddata(:,:,:,:,length(pqn)+2*N+i)=read_model(expn);
end
 
for i=1:length(pqn)
  expn=[expid{pqn(i,1)},'x_',expid{pqn(i,2)},'n']; 
  moddata(:,:,:,:,2*length(pqn)+2*N+i)=read_model(expn);
end

for i=1:length(pqn)
  expn=[expid{pqn(i,1)},'x_',expid{pqn(i,2)},'x'];
  moddata(:,:,:,:,3*length(pqn)+2*N+i)=read_model(expn);
end
