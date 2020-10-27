close all; clear all; clc;
% -------------------------------------------------------------------------
%              Seismic Hazard Assessment by Chung-Han Chan
%              Home work assignment 1 for 2020-10-29 class 
% Model the seismicity rate as a function of magnitude according to the catalogue
% 50 km within the NCU located. from CWB catalog
%   Code date: 2020 - 10 - 15
% Files directory:
% https://drive.google.com/drive/folders/1QRxZhNDNAg8bV7yukzkuLbW_1EYuBClh?usp=sharing
% -------------------------------------------------------------------------
% Set NCU location (google map)
lat0 = 24.967694;
long0 = 121.195037;
% Load the input data
%filename = "CWB catalog (1900-2016).xlsx";
% Select catalog function
%select_cat(lat0,long0,50,filename,1);
%
data = load('out_cat.mat','-ascii');
% statistic for
data(:,4)=round(data(:,4),1);
mag = unique(data(:,4));
year = unique(data(:,5));
nummag = histc(data(:,4),mag);
numyear = histc(data(:,5),year);
% Softout the data by year:
i = find(data(:,5) > 1973 & data(:,5) < 2017);
data1=data(i,:);
mag1 = unique(data1(:,4));
year1 = unique(data1(:,5));
nummag1 = histc(data1(:,4),mag1);
numyear1 = histc(data1(:,5),year1);
%
c1 = polyfit(mag1,log10(nummag1),1);
yfit1 = polyval(c1,mag1);
% Softout the data by mag:
l = find(mag1 > 2 & mag1 < 5);
mag2 = mag1(l); nummag2 = nummag1(l);
%
c2 = polyfit(mag2,log10(nummag2),1);
yfit2 = polyval(c2,mag2);
%%
% Catalog
h= figure('Name','02.Selected_catalog','Numbertitle','off',...
    'Units','normalized','Position',[0 0 0.6 1],'visible','off');
plot(lat0,long0,'r+',"LineWidth",3); grid on; hold on;
plot(data(:,1),data(:,2),'o','LineWidth',1,'MarkerSize',5,...
    'MarkerEdgeColor',[0.0,0.0,0.5],...
    'MarkerFaceColor',[0.0,0.0,0.5]);grid on; hold on;
axis square
xlabel('Magnitude','FontSize',12,'FontWeight','bold',...
    'Color','b','FontName','Times New Roman'); 
ylabel('Annual rate R^2','FontSize',12,'FontWeight',...
    'bold','Color','b','FontName','Times New Roman')
legend('NCU location','Selected Earthquake location','Location','best');
title(['Event selected from CWB catalog (',num2str(length(data(:,1))),') events'],'FontSize',14,'color','blue','FontName',...
    'Times New Roman','Fontweight','Bold')
print('-dtiff','-r100','02.Catalog.tiff')
close(h);
% Statistic the earthquake
h1 = figure('Name','02.Selected_catalog_statistic','Numbertitle','off',...
    'Units','normalized','Position',[0 0 1 1],'visible','on');
subplot(2,1,1);
bar(year,numyear);grid on; hold on;
%text(1:length(numyear),numyear,num2str(numyear),'vert','bottom','horiz','center');
xlabel('Time (year)','FontSize',12,'FontWeight','bold',...
    'Color','b','FontName','Times New Roman'); 
ylabel('Number of events','FontSize',12,'FontWeight',...
    'bold','Color','b','FontName','Times New Roman')
title('Distribution of events with time')
%
subplot(2,1,2);
bar(mag,nummag);grid on; hold on;
%text(1:length(nummag),nummag,num2str(nummag),'vert','bottom','horiz','center');
xlabel('Magnitude','FontSize',12,'FontWeight','bold',...
    'Color','b','FontName','Times New Roman'); 
ylabel('Number of events','FontSize',12,'FontWeight',...
    'bold','Color','b','FontName','Times New Roman')
title('Distribution of events with magnitude')
suptitle('Catalog on period 1900 ~ 2016')
print('-dtiff','-r100','02.Catalog_statistic_origin.tiff')
close(h1);
% Statistic the earthquake
h2 = figure('Name','02.Catalog_statistic_soft_year','Numbertitle','off',...
    'Units','normalized','Position',[0 0 1 1],'visible','on');
subplot(2,1,1);
bar(year1,numyear1);grid on; hold on;
%text(1:length(numyear),numyear,num2str(numyear),'vert','bottom','horiz','center');
xlabel('Time (year)','FontSize',12,'FontWeight','bold',...
    'Color','b','FontName','Times New Roman'); 
ylabel('Number of events','FontSize',12,'FontWeight',...
    'bold','Color','b','FontName','Times New Roman')
title('Distribution of events with time')
%
subplot(2,1,2);
bar(mag1,nummag1);grid on; hold on;
%text(1:length(nummag),nummag,num2str(nummag),'vert','bottom','horiz','center');
xlabel('Magnitude','FontSize',12,'FontWeight','bold',...
    'Color','b','FontName','Times New Roman'); 
ylabel('Number of events','FontSize',12,'FontWeight',...
    'bold','Color','b','FontName','Times New Roman')
title('Distribution of events with magnitude')
suptitle('Catalog on period 1973 ~ 2016')
print('-dtiff','-r100','02.Catalog_statistic_soft_year.tiff')
close(h2);
%
% % Model fitting
 h4 = figure('Name','02.Catalog_statistic','Numbertitle','off',...
     'Units','normalized','Position',[0 0 1 1],'visible','on');
 subplot(1,2,1);
 plot(mag1,log10(nummag1),'o','LineWidth',1,'MarkerSize',7,...
     'MarkerEdgeColor',[0.0,0.0,0.5],...
     'MarkerFaceColor',[0.0,0.0,0.5]);grid on; hold on;
semilogy(mag1,yfit1,'r.-','MarkerSize',15,'LineWidth',1);
 txt = {"a = " c1(1) "b = " c1(2)};
 t1 = text(1.0,1.0,['\rightarrow' txt],'FontSize',14);
 xlabel('Magnitude','FontSize',12,'FontWeight','bold',...
     'Color','b','FontName','Times New Roman'); 
 ylabel('Annual rate R^2','FontSize',12,'FontWeight',...
     'bold','Color','b','FontName','Times New Roman')
 legend('observation data','linear fitting model')
 title('Catalog softout year','FontSize',14,'color','blue','FontName',...
     'Times New Roman','Fontweight','Bold')
% %axis([min(mag)*0.9 max(mag)*1.1 min(nummag)*0.9 max(nummag)*1.1]);
% %
 subplot(1,2,2);
 plot(mag2,log10(nummag2),'o','LineWidth',1,'MarkerSize',7,...
     'MarkerEdgeColor',[0.0,0.0,0.5],...
     'MarkerFaceColor',[0.0,0.0,0.5]);grid on; hold on;
semilogy(mag2,yfit2,'r.-','MarkerSize',15,'LineWidth',1);
 xlabel('Magnitude','FontSize',12,'FontWeight','bold',...
     'Color','b','FontName','Times New Roman'); 
 ylabel('Annual rate R^2','FontSize',12,'FontWeight',...
     'bold','Color','b','FontName','Times New Roman')
 legend('observation data','linear fitting model')
 txt = {"a = " c2(1) "b = " c2(2)};
 t = text(2.5,1.5,['\rightarrow' txt],'FontSize',14);
 
 title('Final catalog','FontSize',14,'color','blue','FontName',...
     'Times New Roman','Fontweight','Bold')
 suptitle('Fitting the seismic rate model with the catalogs')
 print('-dtiff','-r100','02.Seismic_rates.tiff')
close(h4);
% %axis([min(mag)*0.9 max(mag)*1.1 min(nummag)*0.9 max(nummag)*1.1]);