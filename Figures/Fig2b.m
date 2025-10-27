filename = 'Masika.xlsx';
T = readtable(filename, 'Sheet', 'Fig2');
type = table2array(T(:,2));
age = table2array(T(:,3));
meth = table2array(T(:,4));
types = {'BCell','NveCD4T','NveCd8T','Mono','EffCD4T','MemCD8T','RegT','NK'};
[~,J]=ismember(type(age==100),types);
cnt = histc(J,1:length(types));
[~,J]=ismember(type(age==100 & meth>=0.089),types);
cnt1 = histc(J,1:length(types));
expc = cnt/sum(cnt)*sum(cnt1) + 0.01;
obsv = cnt1 + 0.01;
d = log2(obsv./expc)'; d(2,5:8)=d(1,5:8); d(1,5:8)=0;
bar(d','stacked'); set(gca,'XTick',1:8,'XTickLabel',types);
axis([0.25 8.75 -2.25 2.25]); grid

NP = {'BCell','NveCD4T','NveCd8T','Mono'};
P = {'EffCD4T','MemCD8T','RegT','NK'};

II=find(age==10);  D=meth(II); [m,s]=normfit(D); 100*[m,s],;
II=find(age==36);  D=meth(II); [m,s]=normfit(D); 100*[m,s],;
II=find(age==77);  D=meth(II); [m,s]=normfit(D); 100*[m,s],;
II=find(age==100); D=meth(II); [m,s]=normfit(D); 100*[m,s],;

II=find(ismember(type,P) & age==10);  D=meth(II); [m,s]=normfit(D); 100*[m,s],;
II=find(ismember(type,P) & age==36);  D=meth(II); [m,s]=normfit(D); 100*[m,s],;
II=find(ismember(type,P) & age==77);  D=meth(II); [m,s]=normfit(D); 100*[m,s],;
II=find(ismember(type,P) & age==100); D=meth(II); [m,s]=normfit(D); 100*[m,s],;
