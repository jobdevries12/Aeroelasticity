clear all;
close all;
clc;

inputs;

% steady aero
[MsC, MsUC, Ks, Ka, Fa] = matrixSetup();
[eigvalC, eigvecC]      = sturcturalAnalysis(MsC, Ks); % coupled mass matrix
[eigvalUC, eigvecUC]    = sturcturalAnalysis(MsUC, Ks); % uncoupled mass matrix
Vdiv                    = divergence(Ks)
Vrev                    = controlReversal(Ks)
plotMode(eigvecC, eigvecUC);

% unsteady aero
eigValues = {};
Vend = 700;
Vstep = 10;
for V = 10:Vstep:Vend
    [Ma, Ca, Ka, W] = unsteadyAeroMatrices(V);
    [A] = stateSpaceA(V, MsC, Ma, Ca, Ks, Ka, W);
    
    eigValues{end+1} = eig(A);
end

plotEigVal(eigValues, 4)