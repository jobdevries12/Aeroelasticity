function [A] = stateSpaceA(V, Ms, Ma, Ca, Ks, Ka, W)
    global b eps1 eps2
    W0 = V/b.*diag([eps1, eps2, eps1, eps2, eps1, eps2]);
    Mae = Ms-Ma;
    Kae = Ks-Ka;

    A = [Mae^-1*Ca             -Mae^-1*Kae              Mae^-1*W;
         repmat(eye(3), 2, 1)   zeros(6,3)             -W0;
         zeros(3)               eye(3)                  zeros(3,6)]
end