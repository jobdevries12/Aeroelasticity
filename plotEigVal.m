function [] = plotEigVal(eigValues, modeNumber)
   numModes = 3;  % Number of eigenvalues to plot
numSteps = length(eigValues);

realParts = zeros(numModes, numSteps);
imagParts = zeros(numModes, numSteps);

for i = 1:numSteps
    eigVal = eigValues{i};  % Vector of eigenvalues
    realParts(:, i) = real(eigVal(1:numModes));
    imagParts(:, i) = imag(eigVal(1:numModes));
end

% Plot
figure;
hold on;
colors = lines(numModes);  % Distinct colors for each mode

for mode = 1:numModes
    plot(realParts(mode, :), imagParts(mode, :), 'o-', ...
        'Color', colors(mode, :), 'LineWidth', 2, ...
        'DisplayName', sprintf('Eigenvalue %d', mode));
end

xlabel('Real Part');
ylabel('Imaginary Part');
title('First 3 Eigenvalues vs. Velocity');
grid on;
legend show;
axis equal;  % Optional: equal scaling for real/imag axes
