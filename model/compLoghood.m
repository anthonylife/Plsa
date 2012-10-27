%COMPLIKEHOOD compute the log-likelihood of generating whole corpus

function loghood = compLoghood()
global Corp; global Model;
global Pz; global Pd_z; global Pw_z;

% Tradeoff between memory and speed
loghood = 0.0;
for i=1:Corp.nw
    loghood = loghood + Corp.X(:,i)'*log(Pd_z.*repmat(Pw_z(i,:),Corp.nd,1)*Pz+1);
end

%for i=1:Corp.nw,
%    for j =1:Corp.nd,
%        loghood = loghood + Corp.X(j,i)*log(sum(Pd_z(j,:).*Pw_z(i,:).*Pz'));
%    end
%end
