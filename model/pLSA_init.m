%PLSA_INIT initialize pLSA model parameter including Pz, Pd_z
%  Pw_z.

function [Pz, Pd_z, Pw_z] = pLSA_init()
global Model;
global Corp;

% P(z), uniform prior distribution
Pz = repmat(1/Model.K, Model.K, 1);

% Pd_z, randomness and normalization
Pd_z = rand(Corp.nd, Model.K);
Pd_z = Pd_z * (1./diag(sum(Pd_z, 1)));

% Pw_z, randomness and normalization
Pw_z = rand(Corp.nw, Model.K);
Pw_z = Pw_z * (1./diag(sum(Pw_z, 1)));
