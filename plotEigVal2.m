function plotEigVal(V, eigValues)
    global rho_air

    % Dynamic pressure from velocity
    q = 0.5 * rho_air * V.^2; % q has same length as V

    % Organize eigenvalues into a matrix
    num_modes = length(eigValues{1}); % how many eigenvalues per V
    num_V = length(V);
    eigenvalues_save = zeros(num_modes, num_V);

    for i = 1:num_V
        eigenvalues_save(:, i) = eigValues{i};
    end

    %% Filter to keep the ones with flutter
    real_parts = real(eigenvalues_save);
    lower_bound = -0.1;
    upper_bound = 0.05;
    filter_mask = (real_parts >= lower_bound) & (real_parts <= upper_bound);
    filtered_eigenvalues = eigenvalues_save .* filter_mask;

    %% Flutter plot: real part vs dynamic pressure
    figure, hold on
    mode_to_plot = 5; % You can change this
    plot(q, real(eigenvalues_save(mode_to_plot, :)), 'r.', 'LineWidth', 2)
    xlabel('Dynamic pressure [Pa]')
    ylabel('Damping \sigma [1/s]')
    plot(xlim, [0 0], 'k', 'LineWidth', 1) % zero damping line
    grid on
    set(gca, 'FontSize', 14)
    title(['Real part of mode ', num2str(mode_to_plot), ' vs dynamic pressure'])

    %% Flutter plot: real vs imaginary parts (root locus)
    figure, hold on
    modes_to_plot = [4, 5, 6]; % you can adjust these
    colors = {'g.', 'r.', 'b.'};

    for idx = 1:length(modes_to_plot)
        mode_idx = modes_to_plot(idx);
        plot(real(eigenvalues_save(mode_idx, :)), imag(eigenvalues_save(mode_idx, :)), colors{idx}, 'LineWidth', 2)
    end

    xlabel('Damping \sigma [1/s]')
    ylabel('Frequency [rad/s]')
    legend(arrayfun(@(x) ['Mode ', num2str(x)], modes_to_plot, 'UniformOutput', false))
    grid on
    set(gca, 'FontSize', 14)
    title('Flutter root locus plot')

end

