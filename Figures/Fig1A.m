filename = 'Masika.xlsx';
T = readtable(filename, 'Sheet', 'Fig1A');
wk22 = table2array(T(1:end,1)); wk22=wk22(~isnan(wk22));
wk28 = table2array(T(1:end,2)); wk28=wk28(~isnan(wk28));
wk22s = table2array(T(1:end,3)); wk22s=wk22s(~isnan(wk22s));
wk28s = table2array(T(1:end,4)); wk28s=wk28s(~isnan(wk28s));

% Shapiro-Wilk for normality
[~,pv1]=swtest(wk22),;
[~,pv2]=swtest(wk28),;
[~,pv1s]=swtest(wk22s),;
[~,pv2s]=swtest(wk28s),;

% Lilliefors
[~,pv1]=lillietest(wk22,'MCTol',1e-3),;
[~,pv2]=lillietest(wk28,'MCTol',1e-3),;
[~,pv1s]=lillietest(wk22s,'MCTol',1e-3),;
[~,pv2s]=lillietest(wk28s,'MCTol',1e-3),;

% Jarque-Bera 
[~,pv1]=jbtest(wk22,0.05,1e-4)
[~,pv2]=jbtest(wk28,0.05,1e-4)
[~,pv1s]=jbtest(wk22s,0.05,1e-3)
[~,pv2s]=jbtest(wk28s,0.05,1e-3)

clear D; D.wk22 = 100*wk22; D.wk28 = 100*wk28;
% main figure version
clf; v=violinplot(D,{'wk22','wk28'}, 'QuartileStyle','none','DataStyle','scatter',...
		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.1, 'EdgeColor',[0 0 0], ...
		'MarkerSize',25, 'Width',.4, 'Orientation', 'horizontal','ViolinColor',[.2 .2 .2]);
grid on; set(gca,'FontSize',20); axis([2 25 0.25 2.75]);
set(gca,'YTick',1:2,'YTickLabel',{'22wk','28wk'},'XTick',5:5:25,'XTickLabel',{'5%','10%','15%','20%','25%'});
xlabel('Avg. methylation at polycomb CpG islands'); title('Intestinal crypts');
set(gcf,'PaperSize',[20 12],'PaperPosition',[0 0 20 12]); print(gcf,'-dpdf','-r300','Fig1A.pdf');

D.wk22s =100*wk22s;D.wk28s= 100*wk28s;
% supplementary figure version
clf; v=violinplot(D,{'wk22','wk22s','wk28','wk28s'}, 'QuartileStyle','none','DataStyle','scatter',...
		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.1, 'EdgeColor',[0 0 0], ...
		'MarkerSize',25, 'Width',.4, 'Orientation', 'horizontal',...
        'ViolinColor',[.2 .2 .2;.6 .2 .2;.2 .2 .2;.6 .2 .2]);
grid on; set(gca,'FontSize',20); axis([2 25 0.25 4.75]);
set(gca,'YTick',1:4,'YTickLabel',{'22wk','22wk (simu)','28wk','28wk (simu)'},'XTick',5:5:25,'XTickLabel',{'5%','10%','15%','20%','25%'});
xlabel('Avg. methylation at polycomb CpG islands'); title('Intestinal crypts');
set(gcf,'PaperSize',[20 22],'PaperPosition',[0 0 20 22]); print(gcf,'-dpdf','-r300','Fig1A+sim.pdf');