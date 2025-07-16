function freqRespdB = get_freq_resp(param,freqX)
% get_freq_resp - calculates difference between measured and calculated frequency response 
% 
% input:
% param - structure consisting of laser parameters
% freqX - frequency vector in Hz 
% 
% output:
% freqRespdB - calculated frequency response from laser parameters

con_factor = param.V/param.Vp;
[carrierDen, photonDen] = get_steady_state(param);

gainTemp = param.gain*(carrierDen-param.N0)./ (1+param.eps.*photonDen);
A = param.gain./(1+param.eps.*photonDen);
Ap = gainTemp*param.eps./(1+param.eps.*photonDen);

gammaNN = 1./param.taon + photonDen.*A;
gammaNS = gainTemp - photonDen.*Ap;
gammaSN = con_factor*param.beta/param.taon+con_factor.*photonDen.*A;
gammaSS = 1/param.taop - con_factor*gainTemp + con_factor*photonDen.*Ap;

WrSquared = gammaNS.*gammaSN + gammaNN.*gammaSS;
Gamma = gammaNN + gammaSS;
omegaBW = 2*pi*freqX;

freqRespLin = (WrSquared./(WrSquared - omegaBW.^2 + 1i.*omegaBW.*Gamma));

freqRespdB = 20*log10(abs(freqRespLin'));
