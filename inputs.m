clear all
close all
clc

global a b c xa xb ra rb rho_air mu ms wh wa wb S q a0 Cla Clb Cmac Cmacb T1 T3 T4 T5 T7 T8 T9 T10 T11 T12 T13 psi1 psi2 eps1 eps2



%% Section Parameters
% distances
a  = -0.4;
b  = 1;
c  = 0.6;
xa = 0.2;
xb = -0.025; 

% Theodorsen T-parameters
T1 = -1/3*sqrt(1-c^2)*(2+c^2)+c*acos(c);
T3 = -(1/8+c^2) * acos(c)^2 + 1/4*c*sqrt(1-c^2)*acos(c)*(7+2*c^2) - 1/8*(1-c^2)*(5*c^2+4);
T4 = -acos(c) + c*sqrt(1-c^2);
T5 = -(1-c^2) - acos(c)^2 + 2*c*sqrt(1-c^2)*acos(c);
T7 = -(1/8+c^2)*acos(c) + 1/8*c*sqrt(1-c^2)*(7+2*c^2);
T8 = -1/3*sqrt(1-c^2)*(2*c^2+1)+c*acos(c);
T9 = 1/2*(1/3*sqrt(1-c^2)+a*T4);
T10 = sqrt(1-c^2) + acos(c);
T11 = acos(c)*(1-2*c)+sqrt(1-c^2)*(2-c);
T12 = sqrt(1-c^2)*(2+c) - acos(c)*(2*c+1);
T13 = 1/2*(-T7-(c-a)*T1);

% radii of gyration (divided by b)
ra = sqrt(0.25); 
rb = sqrt(0.00625); 

% masses
rho_air = 1.225; % [kg/m3]
mu      = 40; % ms/(pi*rho_air*b^2)
ms      = pi*rho_air*b^2*mu;

% uncoupled natural frequencies
wh = 50;  % [rad/s]
wa = 100; % [rad/s]
wb = 300; % [rad/s]

% aerodynamics
S       = 2*b; % [m2] PLACEHOLDER
q       = 1; % [Pa] PLACEHOLDER
a0      = 0; % [rad]
Cla     = 2*pi; 
Clb     = 2*T10;
Cmac    = 0; 
Cmacb   = -1/2*(T4+T10); 

%% Lag terms
psi1 = 0.165;
psi2 = 0.335;
eps1 = 0.0455;
eps2 = 0.3;