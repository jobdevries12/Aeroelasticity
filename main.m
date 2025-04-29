clear all;
%close all;
clc;

inputs;

% steady aero
[MsC, MsUC, Ks, Ka, Fa] = matrixSetup();
[eigvalC, eigvecC]      = sturcturalAnalysis(MsC, Ks); % coupled mass matrix
[eigvalUC, eigvecUC]    = sturcturalAnalysis(MsUC, Ks); % uncoupled mass matrix
Vdiv                    = divergence(Ks)
Vrev                    = controlReversal(Ks)
plotMode(eigvecC, eigvecUC);

% % unsteady aero

eigValues = {};
eigVectors = {};
Vend = 350;
Vstep = 0.1;
Vflutter = NaN; % Initialize critical velocity
unstableDetected = false; % Flag to detect first instability

% Store velocities as well for later analysis (optional)
velocities = 0:Vstep:Vend;

for i = 1:length(velocities)
    V = velocities(i);
    
    [Ma, Ca, Ka, W] = unsteadyAeroMatrices(V);
    A = stateSpaceA(V, MsC, Ma, Ca, Ks, Ka, W);

    % Store eigenvalues and eigenvectors
    eigValues{end+1} = eig(A);
    [~, eigVectors{end+1}] = eig(A);
    
    % Check for instability (first positive real part)
    realParts = real(eigValues{end});
    
    if ~unstableDetected && any(realParts > 0)
        Vflutter = V % Save the flutter velocity
        unstableDetected = true;
    end
end

if isnan(Vflutter)
    fprintf('No instability detected up to V = %.2f\n', Vend);
end



plotEigVal(eigValues, 6)