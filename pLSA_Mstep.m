%PLSA_MSTEP calculate P(z), P(d|z) and P(w|z) given n(d,w) and
%  P(z|d, w).

function pLSA_Mstep()
global Model;
global Corp;
global Pz, Pd_z, Pw_z, Pz_dw;

% P(d|z), P(w|z) numerator 
for i=1:Model.k,
    Pd_z(:,i) = sum(Corp.X.*Pz_dw(i,:,:), 3);
    Pw_z(:,i) = sum(Corp.X.*Pz_dw(i,:,:), 2);
end

% P(z)
Pz = sum(Pw_z, 1);
Pz = Pz ./ sum(Pz);

% P(d|z, P(w|z)
C = sum(Pd_z, 1);
Pd_z = Pd_z * diag(1./C);

C = sum(Pw_z, 1);
Pw_z = pw_z * diag(1./C);
