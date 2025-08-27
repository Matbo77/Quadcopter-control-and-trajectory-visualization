function R_B2I = rot_mat_B2I(Theta)
% rotation matrix from quadcopter bodyframe to inertial frame

phi = Theta(1);
theta = Theta(2);
psi = Theta(3);

ct = cos(theta);
st = sin(theta);

cpsi = cos(psi);
spsi = sin(psi);
cphi = cos(phi);
sphi = sin(phi);


R_B2I = [ct*cpsi, cpsi*st*sphi+spsi*cphi, -cpsi*st*cphi + spsi*sphi  ; ...
    -ct*spsi, -spsi*st*sphi + cpsi*cphi, spsi*st*cphi + cpsi*sphi ; ...
    st, -ct*sphi, ct*cphi];

end