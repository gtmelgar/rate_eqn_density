function dy = laser_eqn_sine(t,y,param,freq)
% laser rate equation from: 
% A. Melgar Multi-Objective Laser Rate Equation Based Parameter Extraction 
% Using VCSEL Small Signal Response and RIN Spectra
%
% removes the need for explicit Ioff
% TO DO: add thermal variation
% TO DO: add stochastic noise

laser_current = param.I + param.const.freqAmp*sin(2*pi*freq.*t);

carrierDen = y(1);
photonDen = y(2);

con_factor = param.V/param.Vp;
dN = (param.etai.*laser_current)./(param.const.q.*param.V) - carrierDen./param.taon - (param.gain.*(carrierDen-param.N0)*photonDen)./(1+param.eps.*photonDen);
dS = -(photonDen./param.taop) + (con_factor.*param.beta.*carrierDen)./param.taon + (con_factor.*param.gain.*(carrierDen-param.N0).*photonDen)./(1+param.eps.*photonDen);

dy = [dN; dS];