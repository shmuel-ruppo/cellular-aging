filename = 'Masika.xlsx';
T = readtable(filename, 'Sheet', 'Fig1C');
ESLAM = table2array(T(1:end,1)); ESLAM=ESLAM(~isnan(ESLAM));
LSK = table2array(T(1:end,2)); LSK=LSK(~isnan(LSK));
ESLAMs = table2array(T(1:end,3)); ESLAMs=ESLAMs(~isnan(ESLAMs));
LSKs = table2array(T(1:end,4)); LSKs=LSKs(~isnan(LSKs));

% Shapiro-Wilk for normality
[~,pv1]=swtest(ESLAM),;
[~,pv2]=swtest(LSK),;
[~,pv1s]=swtest(ESLAMs),;
[~,pv2s]=swtest(LSKs),;

[~,pv1]=lillietest(ESLAM),;
[~,pv2]=lillietest(LSK),;
[~,pv1s]=lillietest(ESLAMs),;
[~,pv2s]=lillietest(LSKs),;

clear D; D.ESLAM = 100*ESLAM; D.LSK = 100*LSK;
clf; v=violinplot(D,{'ESLAM','LSK'}, 'QuartileStyle','none','DataStyle','scatter',...
		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.1, 'EdgeColor',[0 0 0], ...
		'MarkerSize',25, 'Width',.4, 'Orientation', 'horizontal','ViolinColor',[.2 .2 .2]);
grid on; set(gca,'FontSize',20); axis([2 20 0.25 2.75]);
set(gca,'YTick',1:2,'YTickLabel',{'ESLAM','LSK'},'XTick',5:5:20,'XTickLabel',{'5%','10%','15%','20%'});
xlabel('Avg. methylation at polycomb CpG islands'); title('Hematopoietic stem cells');
set(gcf,'PaperSize',[20 12],'PaperPosition',[0 0 20 12]); print(gcf,'-dpdf','-r300','Fig1C.pdf');

D.ESLAMs = 100*ESLAMs; D.LSKs = 100*LSKs;
% supplementary figure version
clf; v=violinplot(D,{'ESLAM','ESLAMs','LSK','LSKs'}, 'QuartileStyle','none','DataStyle','scatter',...
		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.1, 'EdgeColor',[0 0 0], ...
		'MarkerSize',25, 'Width',.4, 'Orientation', 'horizontal',...
        'ViolinColor',[.2 .2 .2;.6 .2 .2;.2 .2 .2;.6 .2 .2]);
grid on; set(gca,'FontSize',20); axis([2 20 0.25 4.75]);
set(gca,'YTick',1:4,'YTickLabel',{'ESLAM','ESLAM (simu)','LSK','LSK (simu)'},'XTick',5:5:20,'XTickLabel',{'5%','10%','15%','20%'});
xlabel('Avg. methylation at polycomb CpG islands'); title('Hematopoietic stem cells');
set(gcf,'PaperSize',[20 22],'PaperPosition',[0 0 20 22]); print(gcf,'-dpdf','-r300','Fig1C+sim.pdf');