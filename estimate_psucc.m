function val = estimate_psucc(p, q, eps, params)
%ESTIMATE_PSUCC estimates the probability that a randomly drawn state can
%catalyze a fixed state transformation. 
%  This function has four required arguments:
%  p: a 1-D array, containing the input state of the system S.
%  q: a 1-D array, containing the target state of the system S.
%  eps: float, the maximal error allowed on the catalyst as measured by the 
%       trace distance.
%  params: a cell containing simulation parameters
%
% val = estimate_psucc(p, q, eps, params) returns the probability (number
% between 0 and 1) that a random state drawn according to the distribution 
% specified in params is an eps-approximate catalyst for transformation p
% -> q.
%
%   requires: CVX (http://cvxr.com/cvx/),
%   authors: Patryk Lipka-Bartosik
%   last updated: 29 June 2020

dC = params{1};             % catalyst dimension
dist = params{2};           % distribution
Ncats = params{3};          % number of random catalysts used to compute psucc
Nsims = params{4};          % number of times psucc is computed 

val = 0;

for sim = 1:Nsims
    
    psucc = 0;
    
    % estimate psucc
    for i = 1:Ncats
        cIN = random_catalyst(dC, dist);
        
        % choose optimal catalyst state (eps-flattest state)
        cOUT = flattest(cIN, eps);

        % check majorization
        pc = kron(p, cIN); qc_flat = kron(q, cOUT);
        flag =  majorizes(pc, qc_flat);

        psucc = psucc + flag;
    end

    psucc = psucc / Ncats; 
    val = val + psucc;
end

val = val / Nsims;