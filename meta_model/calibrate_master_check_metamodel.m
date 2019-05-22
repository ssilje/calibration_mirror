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
%
%
%  This script you run to get the OPT set of parameters. When you hav got
%  the OPT set of parameters, you run the calibrate_master_OPT.m script
%
%
%--------------------------------------------------------------------
% DEFINE Calibration structures (Parameters,Datamatrix,Metamodel)
%--------------------------------------------------------------------

clear all; close all;
% Add polyfitn library
addpath('PolyfitnTools')



%optrun=true; % only set this to true if you are running after having the OPT run
optrun=false; % only set this to true if you are running after having the OPT run
%OPT_matfile='/hymet/ssilje/cosmopompa_calibration/meta_model/data/opt_5.mat';
OPT_matfile='calibration_OPT_neelin_e_8param';
% If you want to run the calibration several times to get differnet
% sets of OPT parameters
ntimes_opt=1; % number of times to run the calibration

% file with constants for the simlations. Needs to be set depending on
% the experiemntal design
const_param;

parameters=struct('name',paramn,'range',range','default',default,'name_tex',paramnt);

expval=create_neelin_exp(parameters); % Experiment values to fit metamodel

parameters=struct('name',paramn,'range',range','default',default,'experiments', ...
    expval,'name_tex',paramnt,'validation',valdata');

load('stddata_2000-2004_CA.mat');
iv=iv_n; stdobs=stdobs_n; err=err_n; % dim [year month regions variables]
% Only using clusters {'clu3','clu4','clu5','clu6','clu8', 'clu9', 'clu11'};
if nregions<11
    iv=iv(nyearstart:nyearend,:,index_param,:); stdobs=stdobs(nyearstart:nyearend,:,index_param,:); err=err(nyearstart:nyearend,:,index_param,:);

else
    iv=iv(nyearstart:nyearend,:,:,:); stdobs=stdobs(nyearstart:nyearend,:,:,:); err=err(nyearstart:nyearend,:,:,:);
end
    

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
datamatrix.valdata=valdata;

datamatrix.variables={4,'T2M [K]','PR [mm/day]','CLCT [%]'};


%-----------------------------------------------------------------
% FIT METAMODEL
%-----------------------------------------------------------------
%
% in the code-package there are two methods to fit the metamodel
% (neelin_e_analytic and neelin_e). They give slightly different
% results, and it is not quite clear why. For the calibration performed by
% Omar, he used the neelin_e_analytic, but in the CALMO-max they
% use the neelin_e method
%
%

% (1) Method Neelin to estimate MetaModel

%metamodel=neelin_e_analytic(parameters,datamatrix,iv);

% (2) Method CALMO to estimate MetaModel
%

 metamodel=neelin_e(parameters,datamatrix,iv);

%-----------------------------------------------------------------
% VALIDATION METRICS
%-----------------------------------------------------------------

% The fitted metamodel is analysed in terms of accuracy and non-linearity
% Different functions can be used for this purpose as described in
% Bellprat et al. (2012) JGR.

%% (1) Estimate the error of independent simulations and plot scattorplots
%%

% [errstd]=errmeta(metamodel,parameters,datamatrix);

%% (2) Visualize mean metamodel parameters for linear, quadratic and
%%     interaction terms

%metaparam(metamodel,parameters,datamatrix);

%% (3) Visualize performance landscape for each parameter pair
%%     between all experiments

% planes(metamodel,parameters,datamatrix);


%% (4) Plot routine to visualize experiments for a Neelin fit
%%
%  exppattern(parameters,datamatrix)
%


%% (5) Check if the metamodel is predicting the value that is simulated

% plot_check_metmodel(parameters, datamatrix, metamodel,number_cluster,number_variable,number_simulation)
% plot_check_metmodel(parameters, datamatrix, metamodel,1,1,1) 
% --> checking cluster #1, for T2M, for the first simulation

close all
for i=1:nregions
    plot_check_metmodel(parameters, datamatrix, metamodel,i,2,1) 
end


