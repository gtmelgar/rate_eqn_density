function opt_param = scale_params(param)
% scale_params - scales parameters to be optimized using scaling variables 
%
% input:
% param - variables in param.opt which are set to 1 will be optimized and scaled using this function 
% 
% output:
% opt_param - vectorized parameters to optimize

x0cell = fieldnames(param.opt);
numOptVal = sum(struct2array(param.opt)==1);

opt_param.x0_name   = cell(numOptVal,1);
opt_param.x0_scaled = zeros(numOptVal,1);
opt_param.lb= zeros(numOptVal,1);
opt_param.ub = zeros(numOptVal,1);

jj = 1;
for ii = 1:length(x0cell)
    if param.opt.(x0cell{ii}) == 1
        opt_param.x0_name{jj}   = x0cell{ii};
        opt_param.x0_scaled(jj) = param.(x0cell{ii})./param.scaling.(x0cell{ii});
        opt_param.lb(jj)        = param.bounds.(x0cell{ii})(1)./param.scaling.(x0cell{ii});
        opt_param.ub(jj)        = param.bounds.(x0cell{ii})(2)./param.scaling.(x0cell{ii});
        jj = jj + 1;
    end
end
