

% Rotation
% Euler Angle
r2d = 180/pi;

phi = pi/3;
theta = pi/4;
psi = pi/6;

Rx = rotx(phi*r2d) % in deg
Ry = roty(theta*r2d)
Rz = rotz(psi*r2d)

M_xyz = Rx*Ry*Rz

M_zyx = Rz*Ry*Rx

M = rotation_ZYX(phi,theta,psi)

M*[1 0 0]'

M2 = rotation_XYZ(phi,theta,psi)

M2*[1 0 0]'




function M = rotation_ZYX(phi,theta,psi)

ct = cos(theta);
st = sin(theta);

cpsi = cos(psi);
spsi = sin(psi);
cphi = cos(phi);
sphi = sin(phi);


M = [ct*cpsi, cpsi*st*sphi-spsi*cphi, cpsi*st*cphi + spsi*sphi  ; ...
    ct*spsi, spsi*st*sphi + cpsi*cphi, spsi*st*cphi - cpsi*sphi ; ...
    -st, ct*sphi, ct*cphi];

end



function M = rotation_XYZ(phi,theta,psi)

ct = cos(theta);
st = sin(theta);

cpsi = cos(psi);
spsi = sin(psi);
cphi = cos(phi);
sphi = sin(phi);


M = [ct*cpsi, -ct*spsi , st   ; ...
    cpsi*st*sphi + spsi*cphi , -spsi*st*sphi + cpsi*cphi, -ct*sphi  ; ...
    - cpsi*st*cphi + spsi*sphi,spsi*st*cphi + cpsi*sphi , ct*cphi];


end