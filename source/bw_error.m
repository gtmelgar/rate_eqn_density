function error = bw_error(x0,param,opt_param,freqX,freqY)
% bw_error - calculates difference between measured and calculated frequency response 
% 
% input:
% x0    - vectorized set of parameters to optimize 
% param - structure consisting of laser parameters
% freqX - frequency vector in Hz 
% freqY - response to optimize to
% 
% output:
% error - calculcated error between measured and calculated frequency response

param = set_params(x0,param,opt_param);

linFreqResp = get_freq_resp(param,freqX);

error = sum((linFreqResp - freqY).^2,'all');