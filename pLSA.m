%PLSA loading information and call plsa to model the text 
%
%  Procedures:
%    1.Setting some model parameters and global variables;
%    2.Loading documents information;
%    3.Randomly initialization and allocation;
%    4.Call EM algorithm to train model and learn parameter;
%    5.Evaluation by perplexity;
%    6.Topic explanation.
%
%  @author:anthonylife
%  @date:10/26/2012

% 1.Setting some model parameters and global variables
% ====================================================
% set pLSA EM parameter
global Model;
Model.maxiter = 100;   % maximal number of iterations for EM
Model.stopdiff = 0.1;    % training stop condition
if isfield(K, 'var'),
    Model.K = K;
else,
    Model.K = 20;    % default topic number for pLSA
end

% corpus parameter setting(get by python script)
global Corp;
Corp.file = './data.txt';
Corp.nd = 0;
Corp.nw = 0;
Corp.X = 0；

% 2.Loading documents information
% ===============================
Corp.X = load(Corp.file);
Corp.X = spconvert(Corp.X);
Corp.nd = size(X, 1);
Corp.nw = size(X, 2);

% 3.Randomly initialization and allocation
% ========================================
global Pz, Pd_z, Pw_z, Pz_dw;
[Pz, Pd_z, Pw_z] = pLSA_init();
Pz_dw = zeros(0.0, Model.k, Corp.nd, Corp.nw);

% 4.Call EM algorithm to train model and learn parameter
% ======================================================
for i=1:Model.maxiter,
    fprintf('Current iteration:%d...', i);
    
    % E-step
    pLSA_Estep();

    % M-step
    pLSA_Mstep();

    % Likelihood
    le = compLikelihood();
    fprintf('Likelihood: %f...\n', le);
end

% 5.Evaluation by perplexity
% ==========================
perplex = compPerplex();
fprintf('Perplexity of test data: %f...\n');

% 6.Topic explanation
% ===================
explaTopic();
fprintf('Finish.\n');
