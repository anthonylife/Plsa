%COMPPERPLEX compute perplexity of whole corpus.

function perplex = compPerplex()
global Corp; global Model;
global Pz; global Pw_z;

corp_entropy = sum(Corp.X*log(Pw_z*Pz'));

perplex = exp(-corp_entropy/sum(sum(Corp.X)));
