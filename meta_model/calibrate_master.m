% Master file for CCLM calibration suite eample for documentation
% on methodology
% NAME 
%   calmo.m
% PURPOSE 
%   Definitions for calibration, I/O of data, calling routines
% HISTORY 
%   First version: 11.10.2013
% AUTHOR  
%   Omar Bellprat (omar.bellprat@gmail.com)

% Three data structures are defined:
%
% - Parameters: Contains all default parameter information 
%               and settings of experiments
%
% - Datamatrix: Contains all data of experiments and validation
%               runs. Defines if a score is computed out of the
%               data or if directly a score is read
%
% - Metamodel:  Contains the metamodel parameters which are fitted

%--------------------------------------------------------------------
% DEFINE Calibration structures (Parameters,Datamatrix,Metamodel)
%--------------------------------------------------------------------

clear all; close all;
% Add polyfitn library

addpath('PolyfitnTools')

% Define Parameters

paramn={'rlam_heat','v0snow','tkhmin','uc1','radfac','roodtp','gamma','tur_len'}; % No TEX interpreter
paramnt={'rlam\_heat','v0snow','tkhmin','uc1','radfac','roodtp','gamma','tur\_len'}; % No TEX interpreter

range={[0.1 2]; % Parameter ranges (min,default,max)
	[10 30];
	[0.1 1];
	[0 0.6];
	[0.3 0.9];
        [0.5 1.5];
        [-1 0.6];
        [60 1000]};

regnames={'BI','IP','FR','ME','SC','AL','MD','EA'};

default={[1 20 0.4 0.3 0.6 1 -0.2 500]};
valdata={[0.45 20.0 0.4 0.25 0.55 0.9 -0.125 750]};

parameters=struct('name',paramn,'range',range','default',default,'name_tex',paramnt);

expval=create_neelin_exp_old(parameters); % Experiment values to fit metamodel

parameters=struct('name',paramn,'range',range','default',default,'experiments', ...
		  expval,'name_tex',paramnt,'validation',valdata);

load('stddata_2000-2009.mat');
iv=iv_n; stdobs=stdobs_n; err=err_n;
stddata=sqrt(err.^2+iv.^2+stdobs.^2);

% Define Datamatrix

moddata=[]; 
valdata=[];
obsdata=[];	
refdata=[];
variables={4,'T2M','PR','CLCT'}; % Index of variables in moddata,
                                  % and name of each model variable
				  % if no score data used
scoren='ps'; % If scoren [], no computation of score assumed
                  % and data values corresponding to score values

datamatrix=struct('moddata',moddata,'refdata',refdata,'valdata',valdata,'obsdata', obsdata,'stddata',stddata,'score',scoren);

%-----------------------------------------------------------------
% READ DATA
%-----------------------------------------------------------------

read_data;
datamatrix.moddata=moddata; datamatrix.refdata=refdata; datamatrix.obsdata=obsdata; 
datamatrix.optdata=optdata; datamatrix.valdata=optdata;

datamatrix.variables={4,'T2M [K]','PR [mm/day]','CLCT [%]'};

%-----------------------------------------------------------------
% FIT METAMODEL
%-----------------------------------------------------------------

metamodel=neelin_e(parameters,datamatrix,iv);

%-----------------------------------------------------------------
% VALIDATION METRICS
%-----------------------------------------------------------------

% The fitted metamodel is analysed in terms of accuracy and non-linearity
% Different functions can be used for this purpose as described in 
% Bellprat et al. (2012) JGR.

% (1) Estimate the error of independent simulations and plot scattorplots

[errstd]=errmeta(metamodel,parameters,datamatrix);
 
% (2) Visualize mean metamodel parameters for linear, quadratic and
%     interaction terms
 
metaparam(metamodel,parameters,datamatrix);
 
% (3) Visualize performance landscape for each parameter pair
%     between all experiments
 
% planes(metamodel,parameters,datamatrix)
 
%-----------------------------------------------------------------
% OPTIMIZATION OF PARAMETERS
%-----------------------------------------------------------------

% The validated metamodel can now be used to find optimal parameter
% values and to perform a perfect model experiment.

% (1) Find optimal model parameters using a latin hypercube
% optimisation

lhacc=3000000; % Number of experiments to sample parameter space, for
            % means of speed a low number of parameter combinations
            % is used

% lhscore: Modelscore for all experiments; 
% lhexp: Latin hypercube parameter experiments
% popt: Parameter setting with highest score

%[lhscore lhexp popt]=lhopt(metamodel,parameters,datamatrix,lhacc);

% (2) Plot performance range covered  by the metamodel and compare to
% reference simulation

%histplot(lhscore,datamatrix)
 
% (3) Plot optimised parameter distributions
errm=0.015 % Uncertainty of the metamodel, is currently set from
          % experience, needs to be computed from error of
          % independent simulations
 
%optparam(parameters,lhscore,lhexp,popt,errm)

% Select 5 parameter sets with maximum Euclidean distance 
% within estimated uncertainty of the metamodel (errm)

%xstarh = lhexp(find(lhscore>max(lhscore)-errm),:);
%
%deuc=@(x1,x2,s) sqrt(sum((x1-x2).^2./repmat(s,[size(x1,1) 1]),2))
%
%s=var(xstarh);%variance of sample data
%
%for j=1:1
%s5=randi([1 length(xstarh)],5,1000000);%select randomly 5
%                                         %simulations many times
%cd=[1 2; 1 3; 1 4; 1 5; 2 3; 2 4; 2 5; 3 4; 3 5; 4 5] %combination matrix of all pairs for 5 samples
%
%for i=1:length(cd)
%  ds5(i,:)=deuc(xstarh(s5(cd(i,1),:),:),xstarh(s5(cd(i,2),:),:),s);
%end
%
%totds5=sum(ds5,1);
%exs(j,1)=max(totds5);
%exs(j,2:6)=s5(:,find(totds5==max(totds5)));
%xstarh(exs(2:6),:)
%end    
%
%save('data/calibration_XXXXX') 
