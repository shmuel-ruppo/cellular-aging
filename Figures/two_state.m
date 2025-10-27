function [param, sc, O, x, st, LL, PST] = two_state(D, TT, md, p0)
	% initial guess parameters
	if nargin<4, p0 = [0, 0.1, 0]; end %[switch prob, rate1, rate2];

	ncells = 1000; % number of cells

	% fit from first time point
	lbl = sprintf('T%03d',TT(1));
	[m,s]=normfit(D.(lbl));
	init  = m + s * randn(ncells,1);

	% generate an <ncells> x 101 matrix of random numbers (last column = 1)
    % the switching time (per cell)
	a = [rand(ncells,100), zeros(ncells,1)];

	% monte carlo simulation: incremeting events w/ rate1 until switch time, then w/ rate2
	% generate an <ncells> x 100 matrix of random numbers.
	% increase the methylation level if each random number is smaller than the fitted rate
	y = rand(ncells,100);

	% fit swtime, rate1, and rate2, to fit the actual single cell methylation data

	% define the objective function
	f = @(p) MC(p, D, TT, ncells, init, a, y);

	if md==1, % one-state model
		lc = [0,    0.005, 0];
		uc = [0,    0.250, 0];
		tit = 'simulating a one-state model';
	else,     % two-state model
		lc = [0.00, 0.005, 0.05];
		uc = [0.02, 0.050, 0.20];
		% lc = [0.00, 0.005,0.035];
		% uc = [0.01, 0.035, 0.20];
		tit = 'simulating a two-state model';
	end

	nruns = 100;
	options = optimoptions('fmincon','Display','off','Algorithm','active-set');
	pp = nan(nruns,3); score = nan(nruns,1)';
	parfor iter=1:nruns,
		[ppp, sss] = fmincon(f, p0, [], [], [], [], lc, uc,[],options);
		pp(iter,:) = ppp;
		score(iter) = sss;
	end
	% get optimal set of parameters
	[sc,iter] = min(score);
	param = pp(iter,:);

	% retun (and compute the log likelihood)
	[sc,x,O,st,LL,PST] = f(param);
end
