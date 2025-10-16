% test case comparing the analytical and numerically solved carrier
% and photon density

close all
addpath('./source')

% get and set laser parameters
laser = getDefaultParameters();
laser.I = 5e-3;
% solve differential equation
tSpan = [0 2e-9];
[T45,Y45] = ode45(@(t,y) laser_eqn_static(t,y,laser),tSpan,[0 0]);
% analytical solution
[carrierDen, photonDen] = get_steady_state(laser);

% plot results
figure;
subplot(2,1,1);
plot(T45/1e-9,Y45(:,1));
hold on
plot([T45(1); T45(end)]/1e-9, [carrierDen;carrierDen],'--')
xlabel('time(ns)')
ylabel('carrier density')
legend({'ode45', 'calculated'})
subplot(2,1,2); 
plot(T45/1e-9,Y45(:,2))
hold on
plot([T45(1); T45(end)]/1e-9, [photonDen;photonDen], '--')
xlabel('time(ns)')
ylabel('photon density')
legend({'ode45', 'calculated'})

% thershold density using carrier at transparency and at steady state
thres_N0_mA = (laser.const.q.*laser.V./laser.etai.*laser.N0./laser.taon)/1e-3;
thres_N_mA = (laser.const.q.*laser.V./laser.etai.*carrierDen./laser.taon)/1e-3;