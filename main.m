clear all;
%close all;
clc;

inputs;

%% Steady Aero
[MsC, MsUC, Ks, Ka, Fa] = matrixSetup();
[eigvalC, eigvecC]      = sturcturalAnalysis(MsC, Ks); % coupled mass matrix
[eigvalUC, eigvecUC]    = sturcturalAnalysis(MsUC, Ks); % uncoupled mass matrix
Vdiv                    = divergence(Ks);
Vrev                    = controlReversal(Ks)
plotMode(eigvecC, eigvecUC);

%% Unsteady Aero

% Initialise arrays and loop settings
eigValues = {};
eigVectors = {};
Vend = 350;
Vstep = 0.1;
Vflutter = NaN; % Initialize critical velocity
unstableDetected = false; % Flag to detect first instability

% loop over velocities to compute flutter graph
for i = 1:length(velocities)
    V = velocities(i);
    
    % setup state-space system
    [Ma, Ca, Ka, W] = unsteadyAeroMatrices(V);
    A = stateSpaceA(V, MsC, Ma, Ca, Ks, Ka, W);

    % Store eigenvalues and eigenvectors
    [eigvec, D] = eig(A);  % V: eigvec, D: diagonal matrix of eigenvalues
    eigValues{end+1} = diag(D);
    eigVectors{end+1} = eigvec;
    
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

% plot flutter graph
plotEigVal(eigValues, 6)

% plot flutter mode
eigVecFlutter = eigVectors{2996}; % eigenvectors at flutter onset velocity (=299.6) this only is the flutter velocity for Vstep = 0.1!
modesFlutter = [eigVecFlutter(1:3,1) eigVecFlutter(1:3,3) eigVecFlutter(1:3,5)]
realModesFlutter = real([eigVecFlutter(1:3,1) eigVecFlutter(1:3,3) eigVecFlutter(1:3,5)])

plotMode2(realModesFlutter)