clear

%% simulation settings
dS = 3;                              % dimension of states p and q
Ncats = 1e1;                         % number of random catalysts used to compute psucc
Nsims = 1;                           % number of times psucc is computed 
Neps = 50;                           % array of errors on the catalyst
dist = 'uniform';                    % distribution used when sampling catalysts
dC_tab = [4^2, 4^3, 4^4];            % array of catalyst dimensions

load('states.mat')                   % load exemplary states p and q
params = {0, dist, Ncats, Nsims};

% array of errors on the catalyst (3 regions)
partition = [3/4, 3/16, 1/16];
eps_tab_small = linspace(0, 0.05, Neps * partition(1) );
eps_tab_medium = linspace(0.05 + eps_tab_small(end) - eps_tab_small(end-1), ... 
                          0.15, Neps * partition(2) );
eps_tab_large = linspace(0.15 + eps_tab_medium(end) - eps_tab_medium(end-1), ...
                         0.25, Neps * partition(3) );
eps_tab = [eps_tab_small, eps_tab_medium, eps_tab_large];

% array of success probabilities
psucc = zeros(length(dC_tab), length(eps_tab));

%% main loop
% loop over catalyst dimensions
for i_dC = 1:length(dC_tab)
    dC = dC_tab(i_dC);
    params{1} = dC;
    
    % loop over allowable errors on the catalyst
    for i_eps = 1:length(eps_tab)
        eps = eps_tab(i_eps);
        
        % estimate probability of success (psucc)
        psucc(i_dC, i_eps) = estimate_psucc(p, q, eps, params);
        
        if mod(i_eps, 5) == 0
            str = ['dC = ', num2str(dC_tab(i_dC)), ' | ', ... 
                   'eps = ', num2str(eps_tab(i_eps)), '\n'];
            fprintf(str)
        end 
    end
end

%% plotting
hold;
x = eps_tab; str = ''; 
for dim = 1:length(dC_tab)
    plot(x, psucc(dim, :), 'LineWidth', 2)
    legend(str)
end

legend(['d_{C} = ', num2str(dC_tab(1))], ['d_{C} = ', num2str(dC_tab(2))], ...
       ['d_{C} = ', num2str(dC_tab(3))]); 
ylabel('P_{succ}')
xlabel('\epsilon_C')
xlim([0, 0.25])