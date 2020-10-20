close all; clear all; clc;
% -------------------------------------------------------------------------
%              Seismic Hazard Assessment by Chung-Han Chan
%              Home work assignment 1 for 2020-10-29 class 
% Model the seismicity rate as a function of magnitude according to the catalogue
%                       Syntheticcatalogue.xlsx
%   Code date: 2020 - 10 - 15
% -------------------------------------------------------------------------
filename = 'Synthetic catalogue.xlsx';
data = xlsread(filename);
lat = data(:,1); long = data(:,2); dep = data(:,3);
mag = data(:,4); mag = mag(~isnan(mag));
% Statis tic the value in array
edges = unique(mag);
% Count the 
counts = histc(mag(:), edges);
c = polyfit(edges,log10(counts),1);
xfit=(min(edges):0.1:max(edges));xfit=xfit';
ycal = polyval(c,xfit);
% Softout the values
i = find(edges > 3.9 & edges < 6.3);
%
xsoft = edges(i); ysoft = counts(i);
c1 = polyfit(xsoft,log10(ysoft),1);
yfit2 = polyval(c1,xsoft);
%%
%
h=figure('Name','PHSA model','Numbertitle','off',...
    'Units','normalized','Position',[0 0 1 1]);
subplot(1,2,1);
semilogy(edges,counts,'o','LineWidth',1,'MarkerSize',7,...
    'MarkerEdgeColor',[0.0,0.0,0.5],...
    'MarkerFaceColor',[0.0,0.0,0.5]);grid on; hold on;
semilogy(xfit,10.^ycal,'r.-','MarkerSize',15,'LineWidth',1);
xlabel('Magnitude','FontSize',12,'FontWeight','bold',...
    'Color','b','FontName','Times New Roman'); 
ylabel('Annual rate R^2','FontSize',12,'FontWeight',...
    'bold','Color','b','FontName','Times New Roman')
legend('observation data','linear fitting model')
title('Origin catalog','FontSize',14,'color','blue','FontName',...
    'Times New Roman','Fontweight','Bold')
axis([min(edges)*0.9 max(edges)*1.1 min(counts)*0.9 max(counts)*1.1]);
%
subplot(1,2,2);
semilogy(xsoft,ysoft,'o','LineWidth',1,'MarkerSize',7,...
    'MarkerEdgeColor',[0.0,0.0,0.5],...
    'MarkerFaceColor',[0.0,0.0,0.5]);grid on; hold on;
semilogy(xsoft,10.^yfit2,'r.-','MarkerSize',15,'LineWidth',1);
xlabel('Magnitude','FontSize',12,'FontWeight','bold',...
    'Color','b','FontName','Times New Roman'); 
ylabel('Annual rate R^2','FontSize',12,'FontWeight',...
    'bold','Color','b','FontName','Times New Roman')
legend('observation data','linear fitting model')
title('Revised catalog','FontSize',14,'color','blue','FontName',...
    'Times New Roman','Fontweight','Bold')
axis([min(xsoft)*0.9 max(xsoft)*1.1 min(ysoft)*0.9 max(ysoft)*1.1]);
suptitle('Best fit model with input catalog')
print('-dtiff','-r100','01.PSHA_model.tiff')
close(h);
%
h1=figure('Name','Annual','Numbertitle','off',...
    'Units','normalized','Position',[0 0 1 1]);
bar(edges,counts,'FaceColor','flat');grid on;
xlabel('Magnitude','FontSize',12,'FontWeight','bold',...
    'Color','b','FontName','Times New Roman'); 
ylabel('Number of event','FontSize',12,'FontWeight',...
    'bold','Color','b','FontName','Times New Roman')
title('Data distribution with magnitude','FontSize',18,'color','blue','FontName',...
    'Times New Roman','Fontweight','Bold')
print('-dtiff','-r100','01.Catalog_statistic.tiff')
close(h1);