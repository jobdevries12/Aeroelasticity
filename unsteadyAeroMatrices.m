function [M, C, K, W] = unsteadyAeroMatrices(V)

global a b c T1 T3 T4 T5 T7 T8 T9 T10 T11 T12 T13 rho_air psi1 psi2 eps1 eps2

%% Non-Circulatory Matrices
Mnc = -rho_air * b^2 * [ pi          -pi*b*a              -T1*b;
                        -a*pi*b       pi*b^2*(1/8+a^2)    -(T7+(c-a)*T1)*b^2;
                        -T1*b         2*T13*b^2           -1/pi*T3*b^2];
                    
Cnc = -rho_air * b^2 * [0   pi*V                        -T4*V;
                        0   pi*(1/2-a)*V*b               (T1-T8-(c-a)*T4+1/2*T11)*V*b;
                        0   (-2*T9-T1+T4*(a-1/2))*V*b   -1/(2*pi)*T4*T11*V*b]; % Not multiplied by -rho*b?

Knc = -rho_air * b^2 * [0    0   0;
       0    0   (T4+T10)*V^2;
       0    0   1/pi*V^2*(T5-T4*T10)];

%% Circulatory Matrices

% Theodorsen Term
momentArm = [1;   -(1/2+a)*b;   T12*b/(2*pi)]; % moment arms to obtain lift, moment about e.a. and moment about hinge
VCc       = [1/V  b/V*(1/2-a) b/V*1/(2*pi)*T11]; % Theodorsen unsteady terms for ciruclatory lift
VKc       = [0    1           1/pi*T10]; % % Theodorsen steady terms for ciruclatory lift

Cc = -pi*rho_air*V^2*b.*momentArm*VCc;
Kc = -pi*rho_air*V^2*b.*momentArm*VKc;

Kw = 2*pi*rho_air*V^2*b*(psi1*eps1 + psi2*eps2) * momentArm * [1/b 0.5-a T11/(2*pi)];

%% Lag-States
W = 2*pi*rho_air*V^2*b.*momentArm*[psi1*eps1^2*V/b^2 psi2*eps2^2*V/b^2 psi1*eps1*V/b*(eps1*(1/2-a)-1) psi2*eps2*V/b*(eps2*(1/2-a)-1) psi1*eps1*V/b*(eps1*T11/(2*pi) - T10/pi) psi2*eps2*V/b*(eps2*T11/(2*pi) - T10/pi)];

%% Assembled Matrices
M = Mnc;
C = Cnc + Cc;
K = Knc + Kc + Kw;
end