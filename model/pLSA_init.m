%PLSA_INIT initialize pLSA model parameter including Pz, Pd_z
%  Pw_z.

function [Pz, Pd_z, Pw_z] = pLSA_init()
global Model;
global Corp;

% P(z), uniform prior distribution
Pz = repmat(1/Model.K, Model.K, 1);

% Pd_z, randomness and normalization
Pd_z = rand(Corp.nd, Model.K);
Pd_z = Pd_z * diag(1./sum(Pd_z, 1));
%for i =1:Corp.nd
%    for j=1:length(Pz)
%        if Pd_z(i,j) == 0
%            disp('0');
%            pause;
%        end
%    end
%end
%Pd_z(1,:)

% Pw_z, randomness and normalization
Pw_z = rand(Corp.nw, Model.K);
Pw_z = Pw_z * diag(1./sum(Pw_z, 1));
%for i =1:Corp.nw
%    for j=1:length(Pz)
%        if Pw_z(i,j) == 0
%            disp('0');
%            pause;
%        end
%    end
%end
%%Pw_z(1,:)
