function param = set_params(x0,param,opt_param)
% set_params - updates structure for optimization
%
% input:
% x0        - vectorized set of parameters to optimize 
% param     - structure consisting of laser parameters
% opt_param - optimized set of parameters
% 
% output:
% opt_param - overwritten param structure

for ii = 1:length(opt_param.x0_name)
    param.(opt_param.x0_name{ii}) = x0(ii).*param.scaling.(opt_param.x0_name{ii});
end
