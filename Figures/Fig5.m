filename = 'Masika.xlsx';
T = readtable(filename, 'Sheet', 'Fig5');
blk = table2array(T(:,1)); blk = blk(~isnan(blk));
wht = table2array(T(:,2)); wht = wht(~isnan(wht));
blks =table2array(T(:,3)); blks =blks(~isnan(blks));
whts =table2array(T(:,4)); whts =whts(~isnan(whts));

% Shapiro-Wilk for normality
[~,pv1]=swtest(blk),;
[~,pv2]=swtest(wht),;
[~,pv1s]=swtest(blks),;
[~,pv2s]=swtest(whts),;

clear D; D.blk= 100*blk; D.wht= 100*wht;
clf; v=violinplot(D,{'blk','wht'}, 'Bandwidth',.75, 'QuartileStyle','none','DataStyle','scatter',...
		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.1, 'EdgeColor',[0 0 0], ...
		'MarkerSize',25, 'Width',.4, 'Orientation', 'horizontal','ViolinColor',[.2 .2 .2]);
grid on; set(gca,'FontSize',20); axis([4 14 0.25 2.75]);
set(gca,'YTick',1:2,'YTickLabel',{'Black hair','White hair'},'XTick',4:3:14,'XTickLabel',{'4%','7%','10%','13%'});
xlabel('Avg. methylation at polycomb CpG islands'); title('Human hair follicles');
set(gcf,'PaperSize',[20 14],'PaperPosition',[0 0 20 14]); print(gcf,'-dpdf','-r300','Fig5.pdf');

D.blks= 100*blks; D.whts= 100*whts;
clf; v=violinplot(D,{'blk','blsk','wht','whts'}, 'QuartileStyle','none','DataStyle','scatter',...
		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.1, 'EdgeColor',[0 0 0], ...
		'MarkerSize',25, 'Width',.4, 'Orientation', 'horizontal',...
        'ViolinColor',[.2 .2 .2;.6 .2 .2;.2 .2 .2;.6 .2 .2]);
grid on; set(gca,'FontSize',20); axis([4 14 0.25 4.75]);
set(gca,'YTick',1:4,'YTickLabel',{'Black hair','Black hair (simu)','White hair','White hair (simu)'},...
    'XTick',4:3:14,'XTickLabel',{'4%','7%','10%','13%'});
xlabel('Avg. methylation at polycomb CpG islands'); title('Human hair follicles');
set(gcf,'PaperSize',[20 26],'PaperPosition',[0 0 20 26]); print(gcf,'-dpdf','-r300','Fig5+simu.pdf');


