%COMPLIKEHOOD compute the log-likelihood of generating whole corpus

function le = compLikelihood()
global Corp; global Model;
global Pz; global Pd_z; global Pw_z;

for i=1:Model.K,
    Pzdw(:,:,i) = Pd_z(:,i)*Pw_z(:,i)'*Pz(i);
end

% vectorization
le = sum(sum(Corp.X*sum(Pzdw, 1)'));
