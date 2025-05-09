function [A] = stateSpaceA(V, Ms, Ma, Ca, Ks, Ka, W)
    global b eps1 eps2
    W0 = V/b.*diag([eps1, eps2, eps1, eps2, eps1, eps2]);
    Mae = Ms-Ma;
    Kae = Ks-Ka;
    I = [1 0 0; 1 0 0; 0 1 0; 0 1 0; 0 0 1; 0 0 1];

    A = [Mae^-1*Ca             -Mae^-1*Kae              Mae^-1*W;
         eye(3)                 zeros(3)                zeros(3,6);
         zeros(6,3)               I                      -W0];
end