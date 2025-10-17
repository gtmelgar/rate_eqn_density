% test case that compares difference between analytical and numericaly
% solved frequency response

close all
addpath('./source') % add path

% get and set laser parameters
laser = getDefaultParameters();
laser.I = 10e-3;

% solve differential equation
tSpan = [0 10e-9];
freqX = (0.5:0.25:40).*1e9;
freqY = get_freq_resp(laser,freqX);
[transferFunction] = get_freq_resp_rate_eqn(laser,freqX);

% plot results
figure;
plot(freqX/1e9, transferFunction,'-','LineWidth',3); hold on
plot(freqX/1e9, freqY,'--','LineWidth',2);
xlabel('freq (GHz)')
ylabel('Magnitude (dB)')
legend({'ode45','calculated'})
