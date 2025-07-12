function freqRespdB = get_freq_resp(param,freqX)

con_factor = param.V/param.Vp;

gainTemp = param.gain*(carrierNum-param.N0)./ (1+param.eps.*photonNum);
A = param.gain./(1+param.eps.*photonNum);
Ap = gainTemp*param.eps./(1+param.eps.*photonNum);

gammaNN = 1./param.taon + photonNum.*A;
gammaNS = gainTemp - photonNum.*Ap;
gammaSN = con_factor*param.beta/param.taon+con_factor.*photonNum.*A;
gammaSS = 1/param.taop - con_factor*gainTemp + con_factor*photonNum.*Ap;

WrSquared = gammaNS.*gammaSN + gammaNN.*gammaSS;
Gamma = gammaNN + gammaSS;
omegaBW = 2*pi*freqX;

freqRespLin = (WrSquared./(WrSquared - omegaBW.^2 + 1i.*omegaBW.*Gamma));

freqRespdB = 20*log10(abs(freqRespLin'));
