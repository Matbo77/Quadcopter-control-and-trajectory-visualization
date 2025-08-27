
function tau = torques(wi_sq, L, k_M, k_f)
% Compute torques, given current inputs, length, drag coefficient, and thrust coefficient.
% wi_sq are values for ${\omega_i}^2$

    tau = [
        L * k_f * (wi_sq(2) - wi_sq(4))  %1-3
        L * k_f * (wi_sq(3) - wi_sq(1))  % 2-4
        k_M * (wi_sq(1) - wi_sq(2) + wi_sq(3) - wi_sq(4))
    ];

    % k_M * (inputs(1) + inputs(3) - (inputs(2) + inputs(4)))

    % tau = [tau_phi, tau_theta, tau_psi]
end