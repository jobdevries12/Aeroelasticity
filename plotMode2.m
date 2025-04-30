function [] = plotMode2(eigvec)
    % plots the flutter eigenvector, basically a copy of plotMode
    global a b c

    function [X, Y] = coordinates(h, theta, beta)
        % elastic axis
        X0 = 0;
        Y0 = h;
        % leading edge
        X1 = -b*(1+a)*cos(theta);
        Y1 = Y0 + b*(1+a)*sin(theta);
        % hinge line
        X2 = b*(c-a)*cos(theta);
        Y2 = Y0 - b*(c-a)*sin(theta);
        % trailing edge
        X3 = X2 + b*(1-c)*cos(theta+beta);
        Y3 = Y2 - b*(1-c)*sin(theta+beta);

        X = [X1, X2, X3];
        Y = [Y1, Y2, Y3];
    end


% Preallocate cell arrays
X = cell(1, 3);
Y = cell(1, 3);
Xuc = cell(1,3);
Yuc = cell(1,3);

% Loop for coupled modes
for i = 1:3
    mode = eigvec(:, i);
    h_i  = mode(1);
    theta_i = mode(2);
    beta_i = mode(3);
    [X{i}, Y{i}] = coordinates(h_i, theta_i, beta_i);
end
    figure
    grid on
    %axis equal
    hold on
 
    plot(X{1}, Y{1}, 'green.-',   'LineWidth',3, 'MarkerSize',30)
    plot(X{2}, Y{2}, 'green--.',  'LineWidth',3, 'MarkerSize',30)
    plot(X{3}, Y{3}, 'green:.',   'LineWidth',3, 'MarkerSize',30)
   
    hold off
    title('Flutter Modes of the Typical Section')
    xlabel('x (elastic axis at x = 0)')
    ylabel('y')
    legend({'1st', '2nd', '3rd'}, 'Location','southwest')
end