function val = flattest(p, eps)
%FLATTEST calculates the eps-flattest approximation of a probability vector
% according to the algorithm from (Extremal distributions under approximate 
% majorization, J. Phys. A: Math. Theor., 2018) 
% URL: http://dx.doi.org/10.1088/1751-8121/aac87c
%  This function has 2 required arguments:
%  p: a 1-D array, containing the input state of the system.
%  eps: float, the maximal error allowed on the system as measured by the 
%       trace distance.
%
% val = flattest(p, eps) returns the eps-flattest state approximation of p
% 
%   requires: CVX (http://cvxr.com/cvx/)
%   authors: Patryk Lipka-Bartosik
%   last updated: 29 June 2020

p = p(:);
prec = 2e-4;
dS = length(p);

% finding a
a = linspace(0, max(p), ceil(1/prec));

f = ones(1, dS) * pos(p - a);
ind = sum(f >= eps);
a = a(ind);

% finding b
b = linspace(0, max(p), ceil(1/prec));

f = ones(1, dS) * pos(b - p);
ind = sum(f <= eps);
b = b(ind);

% fixing cp
eta = ones(dS, 1) / dS;
if (eps <= vdist(p, eta))
    p_flat = p;
    for i = 1:dS
        if p(i) >= a
           p_flat(i) = a;
        end

        if p(i) <= b
           p_flat(i) = b;
        end
    end
else 
    p_flat = eta;
end

val = p_flat;

end