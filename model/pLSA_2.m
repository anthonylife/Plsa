%PLSA loading information and call plsa to model the text.
%
%  Note, different from version 1, which stores P(z|d,w)
%  explicitly, this program avoids it to reduce memory
%  occupancy. So it can process more documents.
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
%  @date:10/27/2012

% 1.Setting some model parameters and global variables
% ====================================================
% set pLSA EM parameter
global Model;
Model.maxiter = 100;    % maximal number of iterations for EM
Model.stopdiff = 0.1;   % training stop condition
Model.topword = 15;     % number of top output words for each topic     
if exist('K', 'var'),
    Model.K = K;
else,
    Model.K = 5;       % default topic number for pLSA
end

% corpus parameter setting(get by python script)
global Corp;
Corp.featurefile = '../features/feature.txt';
Corp.dictfile = '../features/dict.txt';
Corp.nd = 0;
Corp.nw = 0;
Corp.X = 0;

% 2.Loading documents information
% ===============================
Corp.X = load(Corp.featurefile);
Corp.X = spconvert(Corp.X);
Corp.nd = size(Corp.X, 1)
Corp.nw = size(Corp.X, 2)

% 3.Randomly initialization and allocation
% ========================================
global Pz; global Pd_z; global Pw_z;
[Pz, Pd_z, Pw_z] = pLSA_init();

Pz_cache = Pz; Pd_z_cache = Pd_z; Pw_z_cache = Pw_z;

% 4.Call EM algorithm to train model and learn parameter
% ======================================================
for i=1:Model.maxiter,
    fprintf('Current iteration:%d...\n', i);
    
    % Calculate new P(d|z)
    for j=1:Corp.nd,
        Pd_z_cache(j,:) = Corp.X(j,:)*Pw_z.*Pz.*Pd_z(j,:);
    end
    C = sum(Pd_z_cache,1);
    Pd_z_cache = Pd_z_cache*diag(1./C);

    % Calculate new P(w|z)
    for j=1:Corp.nw,
        Pw_z_cache(j,:) = Corp.X(:,j)'*Pd_z.*Pz.*Pw_z(j,:);
    end
    C = sum(Pw_z_cache,1);
    Pw_z_cache = Pw_z_cache*diag(1./c);

    % Calculate new P(z)
    for j=1:Model.K,
        Pz_cache(j) = Corp.X.*repmat(Pd_z(:,j),1,Corp.nw).*...
            repmat(Pw_z(:,j)',Corp.nd,1).*Pz(j);
    end
    Pz_cache = Pz_cache./sum(Pz_cache);

    % Update model parameter
    Pz = Pz_cache; Pd_z = Pd_z_cache; Pw_z = Pw_z_cache;

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
