

function [phi_ref,theta_ref] = input_Theta_from_position_ref(Xglob,Xref,u_1,perf,data)
%  [phi,theta] ref
    % feedback-linearization and 2nd order dynamic pole placement

    m = data.m;
    g = data.g;
    L = data.L;
    k_f = data.k_f;
    k_M = data.k_M;
    k_D = data.k_D;

    xi_x = perf.xi_x;
    w_x = perf.w_x;
    xi_y = perf.xi_y;
    w_y = perf.w_y;

    x = Xglob(1);
    y = Xglob(2);
    dx = Xglob(4);
    dy = Xglob(5);
    psi = Xglob(9);

    xref = Xref(1);
    yref = Xref(2);

if ~u_1 == 0     
    %M = [sin(psi) -cos(psi) ; cos(psi) sin(psi)];

    M = [sin(psi) cos(psi) ; -cos(psi) sin(psi)];

    %inv_M = [sin(psi) -cos(psi) ; cos(psi) sin(psi)];

    Theta_ref = M^(-1)*(m/u_1*[ -2*xi_x*w_x*dx - w_x^2*(x-xref); -2*xi_y*w_y*dy - w_y^2*(y-yref) ] + k_D/u_1*[dx ; dy]);
else
    disp("pb : u_1 = 0" )
    Theta_ref = [0;0];
end

phi_ref = Theta_ref(1);
theta_ref = Theta_ref(2);


end