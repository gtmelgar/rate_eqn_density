close all
addpath('./source')

laser = getDefaultParameters();
laser.I = 5e-3;

tSpan = [0 10e-9];

[T45,Y45] = ode45(@(t,y) laser_eqn_static(t,y,laser),tSpan,[0 0]);
[carrierDen, photonDen] = get_steady_state(laser);

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

thres_N0_mA = (laser.const.q.*laser.V./laser.etai.*laser.N0./laser.taon)/1e-3;
thres_N_mA = (laser.const.q.*laser.V./laser.etai.*carrierDen./laser.taon)/1e-3;