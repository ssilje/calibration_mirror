%% File with constnt settings for CCLM calibration suite
%
%% directories:
%  -- simdir
%  -- obsdir
%%  calibration time period
%  --nmonths
%  --nyear
%  --nyearstart
%  --nyearend
%% Parameters, simulations and domains
%  --nparam
%  --nsim
%  --expid
%  --paramn
%  --paramnt
%  --regnames
%  --default param
%  --range of param
%% Independent simulations
%  --nind
%  --valdata


simdir='/hymet/ssilje/CALIBRATION_CA_emmanuele/data/long_calibration/';
obsdir='/hymet/ssilje/CALIBRATION_CA_emmanuele/data/bellprat_obs/';


nyear=5;
nmonths=nyear*12;
nyearstart=1;
nyearend=5;

%index_param=[3 5 7]; % 3param
%index_param=[2 3 5 6 7 9]; % 4param
index_param=[2 3 5 6 7 9]; % 4param
nparam=length(index_param); %number of parameters
%index_param=[2 3 5 6 7]; % 5param
% 1:d_mom --> ref outside range
% 2:log(rlam_heat)
% 3:tkhmin
% 4:v0snow  --> ref outside range
% 5:radfac
% 6:log(soilh)
% 7:uc1
% 8:qi0
% 9:log(e_surf)


nsim=2*nparam*nparam; %number of simulations
nind=3; % number of independent simulations

nregions=11;
regnames={'clu1','clu2','clu3','clu4','clu5','clu6','clu7','clu8', 'clu9', 'clu10', 'clu11'};

% Default parameters
rlam_heat=1.0;
v0snow=25;
tkhmin=0.4;
uc1=0.8;
radfac=0.5;
d_mom=16.6;
soilh=1.62;
e_surf=1;
qi0=0;

%% Ranges
rlam_heatn=0.1;
rlam_heatx=10;
v0snown=10;
v0snowx=15;
tkhminn=0;
tkhminx=2;
uc1n=0.2;
uc1x=1.6;
radfacn=0.3;
radfacx=0.9;
d_momn=12;
d_momx=15;
soilhn=0.1;
soilhx=10;
e_surfn=0.1;
e_surfx=10;
qi0n=0.00001;
qi0x=0.0001;
%%

%%% All 9 parameters
expid_all={'d', 'rl' , 'tk', 'v','ra' , 's', 'u', 'q' , 'e' };
paramn_all={'d_mom','rlam_heat', 'tkhmin', 'v0snow',  'radfac' , 'soilh' ,'uc1', 'qi0' , 'e_surf'}; % No TEX interpreter
paramnt_all={'d\_mom','rlam\_heat', 'tkhmin', 'v0snow', 'radfac', 'soilh' , 'uc1', 'qi0' , 'e\_surf'}; % No TEX interpreter

default_all={[d_mom log(rlam_heat) tkhmin v0snow radfac log(soilh) uc1 qi0 log(e_surf)]};
range_all={[d_momn d_momx];
    [log(rlam_heatn) log(rlam_heatx)];
    [tkhminn tkhminx];
    [v0snown v0snowx];
    [radfacn radfacx];
    [log(soilhn) log(soilhx)];
    [uc1n uc1x];
    [qi0x qi0n];
    [log(e_surfn) log(e_surfx)];};

% valdata_all=[3.2188 log(4.2212) 1.6346 13.7661 0.4749 log(0.3169) 1.2902 0.0000 log(3.0281); % IND1
%     13.9604 log(2.3665) 1.7370 10.4912 0.3222 log(2.5761) 1.3508 0.0000 log(0.5657); %IND2
%     12.5804 log(0.5954) 0.1231 14.9506 0.8710 log(0.2903) 0.8493 0.0001 log(6.6516); %IND3
%     12.0617 log(1.2264) 0.3454 10.8446 0.3355 log(2.32798) 0.5545 0.0000 log(0.94356); %IND4
%     12.1954 log(0.79509) 0.5967 10.0843 0.3557 log(0.86866) 0.8377 0.0000 log(0.88577);  %IND5
%     12.0491 log(0.79509) 0.6289 11.4301 0.3146 log(0.360811) 0.8273 0.000 log(0.514325)];  %IND6

valdata_all=[12.0617 log(1.2264) 0.3454 10.8446 0.3355 log(2.32798) 0.5545 0.0000 log(0.94356); %IND4
    12.1954 log(0.79509) 0.5967 10.0843 0.3557 log(0.86866) 0.8377 0.0000 log(0.88577);  %IND5
    12.0491 log(0.79509) 0.6289 11.4301 0.3146 log(0.360811) 0.8273 0.000 log(0.514325)];  %IND6

expid=expid_all(index_param);
paramn=paramn_all(index_param);
paramnt=paramnt_all(index_param);
default=default_all{:}(index_param);
range=range_all(index_param,:);
valdata=valdata_all(:,index_param);


