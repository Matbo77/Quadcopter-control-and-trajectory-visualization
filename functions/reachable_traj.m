
function Xref = reachable_traj(Xcurrent,Xref,follow_mode)

% cut the Xref traj into reachable traj (in the time response of each
% control reference input / state)

% follow_mode if the orientation %psi_ref must follow the direction of the
% current trajectory

x_ref = [2*ones(N-Nnew,1); 5*ones(Nnew,1)];
y_ref = [1*ones(N-Nnew,1); -2*ones(Nnew,1)];
z_ref = 1*[7*ones(N-Nnew,1); 5*ones(Nnew,1)]; %10
phi_ref = 0*[pi/10*ones(N-Nnew,1);0*ones(Nnew,1)];
theta_ref = 0*[-pi/10*ones(N-Nnew,1);0*ones(Nnew,1)];
psi_ref = 1*[-pi/4*ones(N-Nnew,1);-pi/2*ones(Nnew,1)]; % pi/2
%phi_ref





Xref =  zeros(12,N);
Xref(1,:) = x_ref;
Xref(2,:) = y_ref;
Xref(3,:) = z_ref; 
% Xref(7,:) = phi_ref; 
% Xref(8,:) = theta_ref; 
Xref(9,:) = psi_ref; 



end