clear all; close all;
% Add polyfitn library

addpath('PolyfitnTools')

% Define Parameters

paramn={'rlam_heat','v0snow','tkhmin','uc1','radfac','roodtp','l_g','tur_len'}; % No TEX interpreter
paramnt={'rlam\_heat','v0snow','tkhmin','uc1','radfac','roodtp','l\_g','tur\_len'}; % No TEX interpreter


% rlam_heat [0.1; 1; 2]
% V0snow  [10; 20; 30]
% tkhmin (and tkmmin) [0.1; 1; 2]
% uc1  [0; 0.8; 1.6 ]
% radfac  [0.3; 0.6; 0.9]
% fac_rootdp2  [0.5; 1; 1.5]
% l_g [0.25 1.59 10]
% tur_len  [60; 500; 1000]

range={[0.1 2]; % Parameter ranges (min,default,max)
	[10 30];
	[0.1 2];
	[0 1.6];
	[0.3 0.9];
    [0.5 1.5];
    [0.25 10];
    [60 1000]};

regnames={'BI','IP','FR','ME','SC','AL','MD','EA'};

%default={[1 20 1 0.8 0.6 1 -0.2 500]};
default={[1 20 1 0.8 0.6 1 1.59 500]};

%valdata={[0.45 20.0 0.4 0.25 0.55 0.9 -0.125 750]};

 %valdata = create_validation_exp(parameters,5)

parameters=struct('name',paramn,'range',range','default',default,'name_tex',paramnt);

expval=create_neelin_exp(parameters); % Experiment values to fit metamodel

parameters=struct('name',paramn,'range',range','default',default,'experiments', ...
		  expval,'name_tex',paramnt,'validation',valdata);
      paramn={'rlam_heat','v0snow','tkhmin','uc1','radfac','roodtp','l_g','tur_len'}; % No TEX interpreter
  valdata =

    1.8100   24.0000    1.4300    0.4800    0.6000    1.4000    5.1250  154.0000
    1.4300   20.0000    1.0500    1.1200    0.4800    0.6000    3.1750  906.0000
    0.2900   16.0000    1.8100    0.8000    0.3600    1.2000    1.2250  342.0000
    0.6700   28.0000    0.6700    0.1600    0.8400    1.0000    9.0250  718.0000
    1.0500   12.0000    0.2900    1.4400    0.7200    0.8000    7.0750  530.0000    
      