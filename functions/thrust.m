
function T_B = thrust(inputs, k_f)
% Compute thrust given current inputs and thrust coefficient.

    % Inputs are values for ${\omega_i}^2$

    T_B = [0; 0; k_f * sum(inputs)]; %oriented toward z in the quadcopter body frame 

end