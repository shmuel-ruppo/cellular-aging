filename = 'Masika.xlsx';
T = readtable(filename, 'Sheet', 'Fig1B');
mo1 = table2array(T(1:end,1));  mo1 =mo1(~isnan(mo1));
mo26 = table2array(T(1:end,2)); mo26=mo26(~isnan(mo26));
mo1s = table2array(T(1:end,3));  mo1s =mo1s(~isnan(mo1s));
mo26s = table2array(T(1:end,4)); mo26s=mo26s(~isnan(mo26s));

% Shapiro-Wilk for normality
[~,pv1]=swtest(mo1),;
[~,pv2]=swtest(mo26),;
[~,pv1s]=swtest(mo1s),;
[~,pv2s]=swtest(mo26s),;

% Jarque-Bera test
[~,pv1]=jbtest(mo1,0.05,1e-3),;
[~,pv2]=jbtest(mo26,0.05,1e-3),;
[~,pv1s]=jbtest(mo1s,0.05,1e-3),;
[~,pv2s]=jbtest(mo26s,0.05,1e-3),;

clear D; D.mo1= 100*mo1; D.mo26= 100*mo26;
clf; v=violinplot(D,{'mo1','mo26'}, 'QuartileStyle','none','DataStyle','scatter',...
		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.1, 'EdgeColor',[0 0 0], ...
		'MarkerSize',25, 'Width',.4, 'Orientation', 'horizontal','ViolinColor',[.2 .2 .2]);
grid on; set(gca,'FontSize',20); axis([2.5 9.5 0.25 2.75]);
set(gca,'YTick',1:2,'YTickLabel',{'1.5mo','26mo'},'XTick',3:3:9,'XTickLabel',{'3%','6%','9%'});
xlabel('Avg. methylation at polycomb CpG islands'); title('Muscle stem cells');
set(gcf,'PaperSize',[20 12],'PaperPosition',[0 0 20 12]); print(gcf,'-dpdf','-r300','Fig1B.pdf');

D.mo1s= 100*mo1s; D.mo26s= 100*mo26s;
% supplementary figure version
clf; v=violinplot(D,{'mo1','mo1s','mo26','mo26s'},'QuartileStyle','none','DataStyle','scatter',...
		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.1, 'EdgeColor',[0 0 0], ...
		'MarkerSize',25, 'Width',.4, 'Orientation', 'horizontal',...
        'ViolinColor',[.2 .2 .2;.6 .2 .2;.2 .2 .2;.6 .2 .2]);
grid on; set(gca,'FontSize',20); axis([2.5 9.5 0.25 4.75]);
set(gca,'YTick',1:4,'YTickLabel',{'1.5mo','1.5mo(simu)','26mo','26mo (simu)'},'XTick',3:3:9,'XTickLabel',{'3%','6%','9%'});
xlabel('Avg. methylation at polycomb CpG islands'); title('Muscle stem cells');
set(gcf,'PaperSize',[20 22],'PaperPosition',[0 0 20 22]); print(gcf,'-dpdf','-r300','Fig1B+sim.pdf');