function [D, Dpr, Dnp, A, TT, tit, N, Npr, Nnp, T] = load_data(fname)
	% A=readtable('poly_CpG_islands_meth_cell.tom10.txt');
	% A=readtable('selected_polycomb_CpG_methylation.0.05.txt');
	if nargin<1, fname='poly_CpG_islands_meth_cell.txt',; end
	A=readtable(fname);
	cellID = A.Var1(:);
	cellType = A.Var2(:);
	cellMeth = 100 * A.Var3(:);
	cellT = A.Var4(:);
	TT = unique(cellT);

	for i=1:length(TT),
		II=(cellT==TT(i));
		tit{i} = sprintf('T%03d',TT(i));
		D.(tit{i}) = cellMeth(II);
		N.(tit{i}) = cellID(II);
		T.(tit{i}) = cellType(II);
	end

	% proliferating cells
	set1 = {'EffCD4T','MemCD8T','RegT','NK'};
	[~,I]=ismember(cellType,set1);
	for i=1:length(TT),
		II=(I>0 & cellT==TT(i));
		tit{i} = sprintf('T%03d',TT(i));
		Dpr.(tit{i}) = cellMeth(II);
		Npr.(tit{i}) = cellID(II);
	end

	% non-proliferating cells
	set2 = {'BCell','NveCD4T','NveCd8T'};
    set2 = {'NveCd8T'};
	[~,I]=ismember(cellType,set2);
	for i=1:length(TT),
		II=(I>0 & cellT==TT(i));
		tit{i} = sprintf('T%03d',TT(i));
		Dnp.(tit{i}) = cellMeth(II);
		Nnp.(tit{i}) = cellID(II);
	end

end
