function [] = plotEigVal(eigValues, numModes) 

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
       plot(realParts(mode, :), imagParts(mode, :), '.', ...
           'Color', colors(mode, :), 'LineWidth', 2, ...
           'DisplayName', sprintf('Eigenvalue %d', mode));
   end

   xlabel('Real Part');
   ylabel('Imaginary Part');
   xlim([-20 10])
   ylim([0 400])
   %title('Eigenvalues Plotted for a Velocity Range 0m/s - 350m/s');
   grid on;
   legend show;

   hold off
end
