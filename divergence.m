function [Vdiv] = divergence(Ks)
% calculate divergence 

global S Cla a b rho_air

qdiv = Ks(2,2) / (S*Cla*(0.5+a)*b); % [Pa]
Vdiv = sqrt(2*qdiv / rho_air); % [m/s]

end