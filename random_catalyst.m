function cat = random_catalyst(dC, distr)
%random_catalyst draws a random catalyst according to a specified
%probability distribution.
%  This function has 2 required arguments:
%  dC: a float, dimension of the catalyst.
%  distr: a string, specifies distribution used to sample the eigenvalues of 
%  the catalyst.
%
% cat = random_catalyst(dC, distr) returns a random catalyst drawn
% according to the distribution specified by distr
% 
%   authors: Patryk Lipka-Bartosik
%   last updated: 29 June 2020 

% select distribution
if strcmp(distr, 'weibul')
    pd = makedist('Weibull');
end
if strcmp(distr, 'uniform')
    pd = makedist('Uniform');
end
if strcmp(distr, 'exp')
    pd = makedist('Exponential');
end
if strcmp(distr, 'beta')
    pd = makedist('Beta');
end
if strcmp(distr, 'poisson')
    pd = makedist('Poisson');
end
if strcmp(distr, 'rician')
    pd = makedist('Rician');
end
if strcmp(distr, 'rayleigh')
    pd = makedist('Rayleigh');
end

% set seed
% rng('default')

% generate dC random values and normalize
cat = random(pd, [dC, 1]);
cat = cat / sum(cat);
cat = sort(cat, 'descend');

end
