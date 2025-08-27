function omegadot = quad_angular_acceleration(wi_sq, omega, data)
    
%     m = data.m;
%     g = data.g;
    L = data.L;
    k_f = data.k_f;
    k_M = data.k_M;
    %k_D = data.k_D;
    I = data.I;
    Ixx = I(1,1);
    Iyy = I(2,2);
    Izz = I(3,3);
    
    % rotor speed rotation wi_sq
    tau = torques(wi_sq, L, k_M, k_f);
    %tau = [tau_phi, tau_theta, tau_psi]

    %omegadot = inv(I) * (tau - cross(omega, I * omega)); 
    %other way to write the formula

    omegadot = [ 1/Ixx*tau(1) - (Iyy-Izz)/Ixx*omega(2)*omega(3) ; ...
     1/Iyy*tau(2) - (Izz-Ixx)/Iyy*omega(1)*omega(3) ; ...
    1/Izz*tau(3) - (Ixx-Iyy)/Izz*omega(1)*omega(2)];

end