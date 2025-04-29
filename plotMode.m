function [] = plotMode(eigvecC, eigvecUC)
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
Xc = cell(1, 3);
Yc = cell(1, 3);
Xuc = cell(1,3);
Yuc = cell(1,3);

% Loop for coupled modes
for i = 1:3
    mode = eigvecC(:, i);
    h_i  = mode(1);
    theta_i = mode(2);
    beta_i = mode(3);
    [Xc{i}, Yc{i}] = coordinates(h_i, theta_i, beta_i);
end

% Loop for uncoupled modes
for i = 1:3
    mode = eigvecUC(:, i);
    h_i  = mode(1);
    theta_i = mode(2);
    beta_i = mode(3);
    [Xuc{i}, Yuc{i}] = coordinates(h_i, theta_i, beta_i);
end    

    grid on
    %axis equal
    hold on
 
    plot(Xc{1}, Yc{1}, 'blue.-',   'LineWidth',3, 'MarkerSize',30)
    plot(Xc{2}, Yc{2}, 'blue--.',  'LineWidth',3, 'MarkerSize',30)
    plot(Xc{3}, Yc{3}, 'blue:.',   'LineWidth',3, 'MarkerSize',30)
    plot(Xuc{1}, Yuc{1}, 'red.-',  'LineWidth',3, 'MarkerSize',30)
    plot(Xuc{2}, Yuc{2}, 'red--.', 'LineWidth',3, 'MarkerSize',30)
    plot(Xuc{3}, Yuc{3}, 'red:.',  'LineWidth',3, 'MarkerSize',30)
    
    hold off
    title('Steady Aeroelastic Modes of the Typical Section')
    xlabel('x (elastic axis at x = 0)')
    ylabel('y')
    legend({'1st Coupled', '2nd Coupled', '3rd Coupled', '1st Uncoupled', '2nd Uncoupled', '3rd Uncoupled'}, 'Location','southwest', NumColumns=2)
end