function [val, err] = majorizes(p, q)
%MAJORIZES checks if a probability vector p majorizes another probability 
%vector q
%  This function has 2 required arguments:
%  p: a 1-D array, containing the input state of the system.
%  q: float, the maximal error allowed on the system as measured by the 
%       trace distance.
%
% [val, err] = majorizes(p, q) returns 1 if p majorizes q up to a fixed
% numerical accuracy, err is the majorization pseudo-distance between p and q 
%
%   authors: Patryk Lipka-Bartosik
%   last updated: 29 June 2020


tol = 1e-10;                                                               % numeric accuracy for checking majorization
% returns 1 if p majorizes q and 0 otherwise
v_maj = min(cumsum(sort(p, 'descend')) - cumsum(sort(q, 'descend')));
v_maj = min(v_maj, 0);

maj_cond = (abs(v_maj) <= tol);

val = maj_cond;
err =  abs(v_maj);
end