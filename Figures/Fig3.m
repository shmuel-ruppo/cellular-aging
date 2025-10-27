filename = 'Masika.xlsx';
T = readtable(filename, 'Sheet', 'Fig3');

D1 = table2array(T(1:end,1)); D1=100*D1(~isnan(D1));
D2 = table2array(T(1:end,2)); D2=100*D2(~isnan(D2));
D3 = table2array(T(1:end,3)); D3=100*D3(~isnan(D3));
D4 = table2array(T(1:end,4)); D4=100*D4(~isnan(D4));
D5 = table2array(T(1:end,5)); D5=100*D5(~isnan(D5));

D1s = table2array(T(1:end,6)); D1s=100*D1s(~isnan(D1s));
D2s = table2array(T(1:end,7)); D2s=100*D2s(~isnan(D2s));
D3s = table2array(T(1:end,8)); D3s=100*D3s(~isnan(D3s));
D4s = table2array(T(1:end,9)); D4s=100*D4s(~isnan(D4s));
D5s = table2array(T(1:end,10));D5s=100*D5s(~isnan(D5s));

% Shapiro-Wilk for normality
[~,pv1]=swtest(D1),;
[~,pv2]=swtest(D2),;
[~,pv3]=swtest(D3),;
[~,pv4]=swtest(D4),;
[~,pv5]=swtest(D5),;
[~,pv1s]=swtest(D1s),;
[~,pv2s]=swtest(D2s),;
[~,pv3s]=swtest(D3s),;
[~,pv4s]=swtest(D4s),;
[~,pv5s]=swtest(D5s),;

[~,pv1]=lillietest(D1),;
[~,pv2]=lillietest(D2),;
[~,pv3]=lillietest(D3),;
[~,pv4]=lillietest(D4),;
[~,pv5]=lillietest(D5),;
[~,pv1s]=lillietest(D1s),;
[~,pv2s]=lillietest(D2s),;
[~,pv3s]=lillietest(D3s),;
[~,pv4s]=lillietest(D4s),;
[~,pv5s]=lillietest(D5s),;

clear D; D.D1=D1; D.D2=D2; D.D3=D3; D.D4=D4; D.D5=D5;
clf; v=violinplot(D,{'D1','D2','D3','D4','D5'}, 'QuartileStyle','none','DataStyle','scatter',...
		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.1, 'EdgeColor',[0 0 0], ...
		'MarkerSize',20, 'Width',.4, 'Orientation', 'horizontal','ViolinColor',[.2 .2 .2]);
grid on; set(gca,'FontSize',20); axis([0 15 0.25 5.75]);
set(gca,'YTick',1:5,'YTickLabel',{'CLP+CMP','Megakaryocytes','Cord blood #1','Cord blood #2','Fetal liver'}, ...
    'XTick',0:5:15,'XTickLabel',{'0%','5%','10%','15%'});
xlabel('Avg. methylation at polycomb CpG islands'); title('Human single cell methylation');
set(gcf,'PaperSize',[20 16],'PaperPosition',[0 0 20 16]); print(gcf,'-dpdf','-r300','Fig3.pdf');

D.D1s=D1s; D.D2s=D2s; D.D3s=D3s; D.D4s=D4s; D.D5s=D5s;
clf; v=violinplot(D,{'D1','D1s','D2','D2s','D3','D3s','D4','D4s','D5','D5s'}, ...
    'QuartileStyle','none','DataStyle','scatter',...
	'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.1, 'EdgeColor',[0 0 0], ...
	'MarkerSize',20, 'Width',.4, 'Orientation', 'horizontal',...
    'ViolinColor',repmat([.2 .2 .2; .6 .2 .2],5,1));
grid on; set(gca,'FontSize',20); axis([0 15 0.25 10.75]);
set(gca,'YTick',1:10,'YTickLabel',...
    {'CLP+CMP','CLP+CMP (simu)','Megakaryocytes','Megakaryocytes (simu)','Cord blood #1','Cord blood #1 (simu)',...
    'Cord blood #2','Cord blood #2 (simu)','Fetal liver','Fetal liver (simu)'}, ...
    'XTick',0:5:15,'XTickLabel',{'0%','5%','10%','15%'});
xlabel('Avg. methylation at polycomb CpG islands'); title('Human single cell methylation');
set(gcf,'PaperSize',[20 30],'PaperPosition',[0 0 20 30]); print(gcf,'-dpdf','-r300','Fig3+simu.pdf');
