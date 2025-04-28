function [MsCoupled, MsUnCoupled, Ks, Ka, Fa] = matrixSetup()

global ms xa b xb c a ra wa rb wb wh % for structural matrices
global q S Cla Clb a0 Cmac Cmacb T4 T5 T10 T12% for aerodynamic matrices


%% matrix terms
% Stheta = (ms*xa+ms*(c-a+xb))*b; % accounts for flap aswell, apparently not needed?
Stheta = ms*xa*b;
Sbeta  = ms*xb*b;
Itheta = ms*ra^2;
Ibeta  = ms*rb^2;
Kh     = ms*wh^2*b;
Ktheta = ms*(wa*ra)^2;
Kbeta  = ms*(wb*rb)^2;


%% Structural Matrices
% mass matrix
MsCoupled = ms*b^2.*[1      xa              xb;
                     xa     ra^2            rb^2+xb*(c-a);
                     xb     rb^2+xb*(c-a)   rb^2]; % version from reference paper

MSCoupled = [ms        Stheta                  Sbeta;
             Stheta    Itheta                  Ibeta+(c-a)*b*Sbeta;
             Sbeta     Ibeta+(c-a)*b*Sbeta     Ibeta]; % own, derived version

MsUnCoupled = diag(diag(MsCoupled)); % diagonalize matrix

% stiffness matrix
Ks = [Kh   0       0;
      0    Ktheta  0;
      0    0       Kbeta]; % own, derived version


%% Steady Aerodynamic Matrices
% stiffness matrix
Ka = [0     q*S*Cla             Clb                        ; 
      0     q*S*Cla*(0.5+a)*b   q*S*(Clb*(0.5+a)+2*Cmacb*b);
      0     q*S*b*T12           q*S*b/pi*(T5 - T4*T10 + T10*T12)];

% aerodynamic force vector
Fa = q*S*(Cla*a0*[1;(0.5+a)*b;(0.5+c)*b] + Cmac*[0;1;1]);

end