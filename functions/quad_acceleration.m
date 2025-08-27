function a = quad_acceleration(wi_sq, Theta, xdot, data)
% wi_sq : omega_i_square -> inputs    
    

    m = data.m;
    g = data.g;
%     L = data.L;
    k_f = data.k_f;
%     k_M = data.k_M;
    k_D = data.k_D;
%     I = data.I;
%     Ixx = I(1,1);
%     Iyy = I(2,2);
%     Izz = I(3,3);
    
    gravity = [0; 0; -g];

    %R_B2I = rot_mat_B2I(Theta); %R_inv
    R_I2B = rot_mat_I2B(Theta);

    T_B = thrust(wi_sq, k_f); % thrust in the quadcopter body frame

    T = R_I2B * T_B; % thrust in inertial reference frame

    Fd = -k_D * xdot;

    a = gravity + 1 / m * T + 1 / m * Fd;

end