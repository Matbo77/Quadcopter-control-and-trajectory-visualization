function w_sq = torque2motor_speed(u,data)
    % w_sq = [w_1^2 ; w_2^2 ; w_3^2 ; w_4^2] % square motors rotation speed
    % u : torque input vector

    m = data.m;
    g = data.g;
    L = data.L;
    k_f = data.k_f;
    k_M = data.k_M;
%     I = data.I;
%     Ixx = I(1,1);
%     Iyy = I(2,2);
%     Izz = I(3,3);
%     
%     z = Xglob(3); % at time k
%     z_ref = Xref(3);
%     dz = Xglob(6);
% 
%     phi = Xglob(7);
%     phi_ref = Xref(7);
%     theta = Xglob(8);
%     theta_ref = Xref(8);
%     psi = Xglob(9);
%     psi_ref = Xref(9);

%     dphi = Xglob(10);
%     dtheta = Xglob(11);
%     dpsi = Xglob(12);

    %perf
%     xi_z = perf.xi_z;
%     w_z = perf.w_z;
%     xi_phi = perf.xi_phi;
%     xi_theta = perf.xi_theta;
%     xi_psi = perf. xi_psi;
%     w_phi = perf.w_phi;
%     w_theta = perf.w_theta;
%     w_psi = perf.w_psi;


    %wsteady_sq = m*g/(4*k_f);
    
%        u_1 = m*g - m*(2*xi_z*w_z*dz + w_z^2*(z - z_ref)) ; 
%        u_2 = Ixx*((Iyy-Izz)/Ixx*dtheta*dpsi - 2*xi_phi*w_phi*dphi - w_phi^2*(phi - phi_ref)) ; 
%        u_3 = Iyy*((Izz-Ixx)/Iyy*dphi*dpsi - 2*xi_theta*w_theta*dtheta - w_theta^2*(theta - theta_ref)) ; 
%        u_4 = Izz*((Ixx-Iyy)/Izz*dphi*dtheta - 2*xi_psi*w_psi*dpsi - w_psi^2*(psi - psi_ref)) ;


    %u = [u_1; u_2 ;u_3; u_4]; % torque input vector

    u_1 = u(1);
    u_2 = u(2);
    u_3 = u(3);
    u_4 = u(4);
    
     w_sq = [1/(4*k_f)*u_1 - 1/(2*L*k_f)*u_3 + 1/(4*k_M)*u_4 ; ...
            1/(4*k_f)*u_1 + 1/(2*L*k_f)*u_2 - 1/(4*k_M)*u_4 ; ...
            1/(4*k_f)*u_1 + 1/(2*L*k_f)*u_3 + 1/(4*k_M)*u_4 ; ...
            1/(4*k_f)*u_1 - 1/(2*L*k_f)*u_2 - 1/(4*k_M)*u_4];



end