clear;
% for k=1:10, [LLnp1(k,:), LLpr1(k,:), scnp1(k), scpr1(k)]=scDNAmMC(1); [LLnp2(k,:), LLpr2(k,:), scnp2(k), scpr2(k)]=scDNAmMC(2); k,; end
% 
% [m,s]=normfit(scnp1); p=normcdf(mean(scnp2),m,s); fprintf('overall KS score pval (two-model): %.3g\n', p);
% [m,s]=normfit(scpr1); p=normcdf(mean(scpr2),m,s); fprintf('overall KS score pval (two-model): %.3g\n', p);
% [m,s]=normfit(LLpr1(:,3)); p=normcdf(mean(LLpr2(:,3)),m,s,'upper'),; fprintf('77wk LL score pval (two-model): %.3g\n', p);
% [m,s]=normfit(LLpr1(:,4)); p=normcdf(mean(LLpr2(:,4)),m,s,'upper'),; fprintf('100wk LL score pval (two-model): %.3g\n', p);

% clear; [LLnp, LLpr, scnp, scpr, D, Dpr, Dnp, A, TT, lbl] = scDNAmMC(1);
% set(gcf,'PaperSize',[40 60],'PaperPosition',[0 0 40 60]); print(gcf,'-dpdf','-r300','scDNAmMC1.pdf');

% clear; [LLnp, LLpr, scnp, scpr, D, Dpr, Dnp, A, TT, lbl] = scDNAmMC(2);
% set(gcf,'PaperSize',[40 60],'PaperPosition',[0 0 40 60]); print(gcf,'-dpdf','-r300','scDNAmMC2.pdf');

% function [LLnp, LLpr, scnp, scpr, D, Dpr, Dnp, A, TT, lbl, xxx, post1, post2] = scDNAmMC(md)

% subplot = @(m,n,p) subtightplot(m,n,p,[0.075,0.05],[0.1 0.1],[0.1 0.1]);
fname = 'poly_CpG_islands_meth_cell.txt';
[D,Dpr,Dnp,A,TT,lbl,N,Npr,Nnp,T] = load_data(fname);
bw = 1;

% plot
% % figure(1); clf;
% % v=violinplot(D,TT, 'Bandwidth',bw,'HalfViolin','right', 'QuartileStyle','none','DataStyle','scatter',...
% % 		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.1, 'EdgeColor',[0 0 0], ...
% % 		'MarkerSize',12, 'Width',.9, 'Orientation', 'horizontal');
% % grid on; set(gca,'FontSize',16); axis([3 18 0.75 5.25]); set(gca,'YTick',1:4,'YTickLabel',[10,36,77,100]);
% % xlabel('Avg. methylation at polycomb CpG islands'); ylabel('week');
% % title('All cells (actual)');
% % set(gcf,'PaperSize',[20 15],'PaperPosition',[0 0 20 15]); print(gcf,'-dpdf','-r300','T.actual.plain.pdf');

% if 0,
% 	% use different colors for different cell types
% 	for i=1:4,
% 		xx=get(v(i).ScatterPlot,'XData'); yy=get(v(i).ScatterPlot,'YData'); set(v(i).ScatterPlot,'MarkerFaceColor',[1 1 1]);
% 		% find non-proliferating cells
% 		I=ismember(xx,Dnp.(lbl{i}));
% 		hold on; scatter(xx(I),yy(I),12,'Filled','MarkerFaceColor',[0 0.447 0.741]); hold off;
% 		% find proliferating cells
% 		I=ismember(xx,Dpr.(lbl{i}));
% 		hold on; scatter(xx(I),yy(I),12,'Filled','MarkerFaceColor',[0.85 0.325 0.098]); hold off;
% 		v(i).ViolinPlot.FaceColor=[1 0.7 0.125];
% 	end
% end
% set(gcf,'PaperSize',[20 15],'PaperPosition',[0 0 20 15]); print(gcf,'-dpdf','-r300','T.actual.colored.pdf');


% unique cell types
% if 0,
% 	types = unique(T.(lbl{4}));
% 	types = {'BCell','NveCD4T','NveCd8T','Mono','EffCD4T','MemCD8T','RegT','NK'};
% 	Ntypes = length(types);
% 	[~,J]=ismember(T.(lbl{4}),types);
% 	[~,J9]=ismember(T.(lbl{4})(D.(lbl{4})>=9),types);
% 	cntA = 1e-3+histc(J,1:Ntypes)';
% 	cnt9 = 1e-3+histc(J9,1:Ntypes)';
% 	ex=sum(cnt9)/sum(cntA);
% 	obs=cnt9./cntA;
% 	bar(log2([obs(1:4),0*obs(5:8);0*obs(1:4),obs(5:8)]./ex)','stacked');
% set(gca,'XTickLabel',types, 'FontSize',16, 'YLim', [-2.2 2.2], 'XLim',[.5 8.5]); ylabel('log2(obs/exp)'); grid on
% 	for i=1:8, fprintf('%s=%d, ', types{i}, cntA(i)); end
% 	for i=1:8, fprintf('%s=%d, ', types{i}, cnt9(i)); end
% 	for i=1:8, fprintf('%s=%.1f%%, ', types{i}, 100*cntA(i)./sum(cntA)); end
% 	for i=1:8, fprintf('%s=%.1f%%, ', types{i}, 100*cnt9(i)./sum(cnt9)); end
% end

% actual data for non-proliferating cells
figure(2); clf;
v=violinplot(Dnp,TT, 'Bandwidth',bw,'HalfViolin','right', 'QuartileStyle','none','DataStyle','scatter',...
		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.2, 'EdgeColor',[0 0 0], ...
		'MarkerSize',12, 'Width',.9, 'Orientation', 'horizontal');
grid on; set(gca,'FontSize',16); axis([3 18 0.75 5.25]); set(gca,'YTick',1:4,'YTickLabel',[10,36,77,100]);
xlabel('Avg. methylation at polycomb CpG islands'); ylabel('week');
title('Non-proliferating cells (actual)');
% set(gcf,'PaperSize',[20 15],'PaperPosition',[0 0 20 15]); print(gcf,'-dpdf','-r300','T.NP.actual.plain.pdf');
if 1,
	% use different colors for different cell types
	for i=1:4,
        if length(v)<i || isempty(v(i)),continue; end
		xx=get(v(i).ScatterPlot,'XData'); yy=get(v(i).ScatterPlot,'YData'); set(v(i).ScatterPlot,'MarkerFaceColor',[1 1 1]);
		% find non-proliferating cells
		I=ismember(xx,Dnp.(lbl{i}));
		hold on; scatter(xx(I),yy(I),12,'Filled','MarkerFaceColor',[0 0.447 0.741]); hold off;
		% find proliferating cells
		I=ismember(xx,Dpr.(lbl{i}));
		hold on; scatter(xx(I),yy(I),12,'Filled','MarkerFaceColor',[0.85 0.325 0.098]); hold off;
		v(i).ViolinPlot.FaceColor=[1 0.7 0.125];
	end
end
set(gcf,'PaperSize',[20 15],'PaperPosition',[0 0 20 15]); print(gcf,'-dpdf','-r300','T.NP.V2.pdf');

% now simulate data for the non-proliferating cells
% [parnp,scnp,Snp,Xnp,stnp,LLnp] = two_state(Dnp,TT,1);
% figure(3); clf;
% v=violinplot(Snp,TT, 'Bandwidth',bw,'HalfViolin','right', 'QuartileStyle','none','DataStyle','scatter',...
% 		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.2, 'EdgeColor',[0 0 0], ...
% 		'MarkerSize',12, 'Width',.9, 'Orientation', 'horizontal');
% grid on; set(gca,'FontSize',16); axis([3 18 0.75 5.25]); set(gca,'YTick',1:4,'YTickLabel',[10,36,77,100]);
% xlabel('Avg. methylation at polycomb CpG islands'); ylabel('week'); title('(simulated)');
% set(gcf,'PaperSize',[20 15],'PaperPosition',[0 0 20 15]); print(gcf,'-dpdf','-r300','T.NP.one-state.simu.pdf');
% 
% [parnp,scnp,Snp,Xnp,stnp,LLnp,PSTnp] = two_state(Dnp,TT,2,parnp);
% save_data(fname, [fname(1:end-4) '.NP.PST.txt'],PSTnp,Nnp);
% 
% figure(4); clf;
% v=violinplot(Snp,TT, 'Bandwidth',bw,'HalfViolin','right', 'QuartileStyle','none','DataStyle','scatter',...
% 		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.2, 'EdgeColor',[0 0 0], ...
% 		'MarkerSize',12, 'Width',.9, 'Orientation', 'horizontal');
% grid on; set(gca,'FontSize',16); axis([3 18 0.75 5.25]); set(gca,'YTick',1:4,'YTickLabel',[10,36,77,100]);
% xlabel('Avg. methylation at polycomb CpG islands'); ylabel('week'); title('(simulated)');
% set(gcf,'PaperSize',[20 15],'PaperPosition',[0 0 20 15]); print(gcf,'-dpdf','-r300','T.NP.two-state.simu.pdf');


% actual data for non-proliferating cells
figure(5); clf;
v=violinplot(Dpr,TT, 'Bandwidth',bw,'HalfViolin','right', 'QuartileStyle','none','DataStyle','scatter',...
		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.2, 'EdgeColor',[0 0 0], ...
		'MarkerSize',12, 'Width',.9, 'Orientation', 'horizontal');
grid on; set(gca,'FontSize',16); axis([3 18 0.75 5.25]); set(gca,'YTick',1:4,'YTickLabel',[10,36,77,100]);
xlabel('Avg. methylation at polycomb CpG islands'); ylabel('week'); title('Proliferating cells (actual)');
% set(gcf,'PaperSize',[20 15],'PaperPosition',[0 0 20 15]); print(gcf,'-dpdf','-r300','T.PR.actual.plain.pdf');
if 1,
	% use different colors for different cell types
	for i=1:4,
        if length(v)<i || isempty(v(i)),continue; end
		xx=get(v(i).ScatterPlot,'XData'); yy=get(v(i).ScatterPlot,'YData'); set(v(i).ScatterPlot,'MarkerFaceColor',[1 1 1]);
		% find non-proliferating cells
		I=ismember(xx,Dnp.(lbl{i}));
		hold on; scatter(xx(I),yy(I),12,'Filled','MarkerFaceColor',[0 0.447 0.741]); hold off;
		% find proliferating cells
		I=ismember(xx,Dpr.(lbl{i}));
		hold on; scatter(xx(I),yy(I),12,'Filled','MarkerFaceColor',[0.85 0.325 0.098]); hold off;
		v(i).ViolinPlot.FaceColor=[1 0.7 0.125];
	end
end
set(gcf,'PaperSize',[20 15],'PaperPosition',[0 0 20 15]); print(gcf,'-dpdf','-r300','T.PR.V2.pdf');



% now simulate data for the non-proliferating cells
% [parpr,scpr,Spr,Xpr,stpr,LLpr] = two_state(Dpr,TT,1);
% figure(6); clf;
% v=violinplot(Spr,TT, 'Bandwidth',bw,'HalfViolin','right', 'QuartileStyle','none','DataStyle','scatter',...
% 		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.2, 'EdgeColor',[0 0 0], ...
% 		'MarkerSize',12, 'Width',.9, 'Orientation', 'horizontal');
% grid on; set(gca,'FontSize',16); axis([3 18 0.75 5.25]); set(gca,'YTick',1:4,'YTickLabel',[10,36,77,100]);
% xlabel('Avg. methylation at polycomb CpG islands'); ylabel('week'); title('(simulated)');
% set(gcf,'PaperSize',[20 15],'PaperPosition',[0 0 20 15]); print(gcf,'-dpdf','-r300','T.PR.one-state.simu.pdf');
% 
% [parpr,scpr,Spr,Xpr,stpr,LLpr,PSTpr] = two_state(Dpr,TT,2,parpr);
% save_data(fname, [fname(1:end-4) '.PR.PST.txt'],PSTpr,Npr);
% figure(7); clf;
% v=violinplot(Spr,TT, 'Bandwidth',bw,'HalfViolin','right', 'QuartileStyle','none','DataStyle','scatter',...
% 		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.2, 'EdgeColor',[0 0 0], ...
% 		'MarkerSize',12, 'Width',.9, 'Orientation', 'horizontal');
% grid on; set(gca,'FontSize',16); axis([3 18 0.75 5.25]); set(gca,'YTick',1:4,'YTickLabel',[10,36,77,100]);
% xlabel('Avg. methylation at polycomb CpG islands'); ylabel('week'); title('(simulated)');
% set(gcf,'PaperSize',[20 15],'PaperPosition',[0 0 20 15]); print(gcf,'-dpdf','-r300','T.PR.two-state.simu.pdf');
% 
% [par,sc,S,X,st,LL,PST] = two_state(D,TT,2,parpr);
% save_data(fname, [fname(1:end-4) '.PST.txt'],PST,N);
% figure(8); clf;
% v=violinplot(S,TT, 'Bandwidth',bw,'HalfViolin','right', 'QuartileStyle','none','DataStyle','scatter',...
% 		'ShowMean',false,'ShowMedian',false, 'ShowWhiskers',false,'ViolinAlpha',0.2, 'EdgeColor',[0 0 0], ...
% 		'MarkerSize',12, 'Width',.9, 'Orientation', 'horizontal');
% grid on; set(gca,'FontSize',16); axis([3 18 0.75 5.25]); set(gca,'YTick',1:4,'YTickLabel',[10,36,77,100]);
% xlabel('Avg. methylation at polycomb CpG islands'); ylabel('week'); title('(simulated)');
% set(gcf,'PaperSize',[20 15],'PaperPosition',[0 0 20 15]); print(gcf,'-dpdf','-r300','T.two-state.simu.pdf');


% visualize two state model
% xxx = 0:.05:40; post1 = nan(4,length(xxx)); post2 = post1;
% clear nynp nono nypr nopr;
% figure(9); clf;
% for i=1:4,
% 	% sample from the fitted parameters - simulating the proliferating cells
% 	subplot(4,1,5-i); cla;
% 	t = TT(i); yng = find(stnp>=t); old = find(stnp<t); nynp(i) = length(yng); nonp(i) = length(old);
% 
% 	xxx = 0:.05:40;
% 	h1 = histc(Xnp(yng,t),xxx); h2 = histc(Xnp(old,t),xxx); nn = sum(h1+h2);
% 	kde  = ksdensity(Xnp(:,t),xxx,'Bandwidth',bw);
% 	bar(xxx, kde,1,'facealpha',.1,'facecolor',[.3 .3 .3], 'edgecolor','none');
% 	kde1 = ksdensity(Xnp(yng,t),xxx, 'Bandwidth',bw) * sum(h1) / nn;
% 	hold on;
% 	if nonp(i),
% 		kde2 = ksdensity(Xnp(old,t),xxx, 'Bandwidth',bw) * sum(h2) / nn;
% 		bar(xxx, kde2,1,'facealpha',.6,'facecolor',[1 0 0], 'edgecolor','none');
% 		plot(xxx, kde, 'k-','LineWidth',1); ax=axis;
% 		% iii=kde>=1e-4; post1(i,iii) = kde2(iii)./kde(iii); plot(xxx, ax(4)*post1(i,:), 'k:','LineWidth',2);
% 	end
% 	bar(xxx, kde1,1,'facealpha',.6,'facecolor',[0 0 1], 'edgecolor','none');
% 	hold off;
% 
% 	set(gca,'FontSize',16,'YTick',[],'XLim',[3 18]); grid on; ax = axis; ylabel(TT(i));
% 	if i==1, xlabel('Avg. methylation at polycomb CpG islands'); end;
% end
% set(gcf,'PaperSize',[20 16.5],'PaperPosition',[0 0 20 16.5]); print(gcf,'-dpdf','-r300','T.NP.simu.pdf');
% 
% figure(10); clf;
% for i=1:4,
% 	% and for the proliferating cells
% 	subplot(4,1,5-i); cla;
% 	t = TT(i); yng = find(stpr>=t); old = find(stpr<t); nypr(i) = length(yng); nopr(i) = length(old);
% 
% 	h1 = histc(Xpr(yng,t),xxx); h2 = histc(Xpr(old,t),xxx); nn = sum(h1+h2);
% 	kde  = ksdensity(Xpr(:,t),xxx,'Bandwidth',bw);
% 	bar(xxx, kde,1,'facealpha',.1,'facecolor',[.3 .3 .3], 'edgecolor','none');
% 	kde1 = ksdensity(Xpr(yng,t),xxx, 'Bandwidth',bw) * sum(h1) / nn;
% 	hold on;
% 	if nopr(i),
% 		kde2 = ksdensity(Xpr(old,t),xxx, 'Bandwidth',bw) * sum(h2) / nn;
% 		bar(xxx, kde2,1,'facealpha',.6,'facecolor',[1 0 0], 'edgecolor','none');
% 		plot(xxx, kde, 'k-','LineWidth',1); ax=axis;
% 		% iii=kde>=1e44; post2(i,iii) = kde2(iii)./kde(iii); plot(xxx, ax(4)*post2(i,:), 'k:','LineWidth',2);
% 	end
% 	bar(xxx, kde1,1,'facealpha',.6,'facecolor',[0 0 1], 'edgecolor','none');
% 	hold off;
% 
% 	set(gca,'FontSize',16,'YTick',[],'XLim',[3 18]); grid on; ax = axis; ylabel(TT(i));
% 	if i==1, xlabel('Avg. methylation at polycomb CpG islands'); end;
% end
% set(gcf,'PaperSize',[20 16.5],'PaperPosition',[0 0 20 16.5]); print(gcf,'-dpdf','-r300','T.PR.simu.pdf');
% 
% fprintf('Non-proliferating cells: %% of young cells: %.2f%% %.2f%% %.2f%% %.2f%%\n', 100*nynp./(nynp+nonp));
% fprintf('switch rate: %.3f/wk, meth gain rate (young): %.3f/wk, meth gain rate (old): %.3f/wk\n', parnp),
% fprintf('LL (per sample): %.3f %.3f %.3f %.3f (%.3f)\n', LLnp, nansum(LLnp));
% fprintf('\n');
% 
% 
% fprintf('Proliferating cells:     %% of young cells: %.2f%% %.2f%% %.2f%% %.2f%%\n', 100*nypr./(nypr+nopr));
% fprintf('switch rate: %.3f/wk, meth gain rate (young): %.3f/wk, meth gain rate (old): %.3f/wk\n', parpr),
% fprintf('LL (per sample): %.3f %.3f %.3f %.3f (%.3f)\n', LLpr, nansum(LLpr));
% fprintf('\n');
