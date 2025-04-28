function [Vrev] = controlReversal(Ks)
% calculate control reversal

global Clb Cla Cmacb b S rho_air

qrev = -Clb*Ks(2,2) / (Cla*Cmacb*2*b*S); % [Pa]
Vrev = sqrt(2*qrev / rho_air); % [m/s]
end