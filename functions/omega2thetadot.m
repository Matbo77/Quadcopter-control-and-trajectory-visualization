

function thetadot = omega2thetadot(omega_B, Theta)
    % speed rotation conversion using the Jacobian J
    
    phi = Theta(1);
    theta = Theta(2);
    %psi = Theta(3);
    
    %J_inv = [1 0 -sin(theta) ; 0 cos(phi) sin(phi)*cos(theta) ;  0 -sin(phi) cos(phi)*cos(theta)] ;
    J = [1  tan(theta)*sin(phi) tan(theta)*cos(phi) ; 0 cos(phi) -sin(phi) ; 0 sin(phi)/cos(theta) cos(phi)/cos(theta)];

    thetadot = J*omega_B;

  
end