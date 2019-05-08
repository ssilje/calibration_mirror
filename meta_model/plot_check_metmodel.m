function plot_check_metamodel(parameters, datamatrix, metamodel,cl,variable,sim)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is used to check if the multivariate quadratic regression equation is 
% able to estimate the variables (i.e. from T2M, PR or CLCT) actually simulated. 
%
% The estimated numbers are shown as monthly means for each years (i.e. 60 numbers)
%
% Using the function check_metamodel, where the multivariate quadratic
% regression equation solved.
%
% Silje Soerland, May 2019.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
const_param;
tl=0;
clear model_estimate metamodel_predicted
for jj=1:nyear %% years
    for k=1:12 %% months
        
        tl=tl+1;
        [number_metamodel model_data]=check_metamodel(parameters, datamatrix, metamodel,jj,k,cl,variable,sim,nparam);
        metamodel_predicted(tl)=number_metamodel;
        model_estimate(tl)=model_data;
        
    end
end

lwb=(min([min(model_estimate) min(metamodel_predicted)]));
upb=(max([max(model_estimate) max(metamodel_predicted)]));


figure('Units','normalized','Position',[0 0 1 1],'visible','on');
hold on 
plot(linspace(lwb,upb,10),linspace(lwb,upb,10),'LineWidth',1,'Color',[0.5 0.5 0.5])
plot(metamodel_predicted,model_estimate,'o','LineWidth',2,'Color',[0 0 0])



xlabel(['Predicted ' datamatrix.variables{variable+1}],'Fontsize',14)
ylabel(['Simulated ' datamatrix.variables{variable+1}],'Fontsize',14)
set(gca,'Fontsize',14,'Ylim',[lwb upb],'Xlim',[lwb upb],'Box','on')
title([regnames{cl} ' || sim #' num2str(sim)])
axes('Visible','off')        
set(gcf,'Paperposition',[0 0 8*1.2 6*1.2])
end