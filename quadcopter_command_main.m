
% Main file for modelization, simulation, command of a quadcopter UAV, and visualization 
% of its trajectory, tracking performance ...
%
% Matlab code developped by M. Borelle 
% 
% Version 2025
%
%

clear
%clc


% addpath(genpath("D:\mborelle\Documents\MATLAB\Projet perso")) %ONERA
% addpath(genpath("Documents/MATLAB/Projet perso")) 



% State variables -> 12
% [x,y,z,vx,vy,vz, theta,phi,psi, vtheta , vphi, vpsi] 

% Input -> 4
%
% 
% commande vitesse de rotation de chaque moteur (4 moteur quadricopter)
% [w1,w2,w3,w4]
%
%
% commande acceleration angulaire et poussée thrust
% [ atheta, aphi, apsi, F ]


t_Start = tic;

% Simulink

% equation mécanique
% gravity

g = 9.81;
L = 0.23; % arm length m
I = diag([7.5e-3,7.5e-3,1.3e-2]); %Inertia matrix
m = 0.65; %weight UAV

k_D = 0.1; % Aerodynamic thrust drag coefficient
k_r = 0.1; %Aerodynamic moment drag coefficient
k_f = 3.13e-5; % Thrust coefficient
k_M = 7.7e-5; % Moment coefficient
nu = 4;

wsteady_sq = m*g/(4*k_f);

%data  
%global data perf;
data.m = m;
data.g = g;
data.L = L;
data.k_f = k_f;
data.k_M = k_M;
data.k_D = k_D;
data.I = I;

% Simulation times, in seconds.
start_time = 0;
end_time = 15;
dt = 0.01; %0.005  %0.01
t = start_time:dt:end_time;

% Number of points in the simulation.
N = numel(t);

% Initial simulation state.
X = zeros(3,N);
X(:,1) = [0; 0; 0]; % 0, 0 , 5
Xdot = zeros(3, N);
Theta = zeros(3, N);
a = zeros(3,N);


%deviation = 100;
%Thetadot = deg2rad(2 * deviation * rand(3, 1) - deviation);
Thetadot = zeros(3,N);

omega_B = thetadot2omega(Thetadot(:,1), Theta(:,1));
omegadot_B = zeros(3,N);

Xglob = [X;Xdot;Theta;Thetadot]; %global state vector

%control parameters 2nd order dynamic placement
xi_x = 1; %
t5x = 3; % tps réponse 5% (en s)
w_x = 4.75/t5x;

xi_y = 1; 
t5y = 3; % tps réponse 5% (en s)
w_y = 4.75/t5y;

xi_z = 1; % sqrt(2)/2
t5z = 4; % tps réponse 5% (en s)
w_z = 4.75/t5z;

xi_phi = 1; % 
t5phi = 0.5; % tps réponse 5% (en s)
w_phi = 4.75/t5phi;

xi_theta = 1; % 
t5theta = 0.5; % tps réponse 5% (en s)
w_theta = 4.75/t5theta;

xi_psi = 1; %
t5psi = 2; % tps réponse 5% (en s)
w_psi = 4.75/t5psi;

% perf
perf.xi_x=xi_x;
perf.w_x=w_x;
perf.xi_y=xi_y;
perf.w_y=w_y;
perf.xi_z=xi_z;
perf.w_z=w_z;
perf.xi_phi=xi_phi;
perf.xi_theta=xi_theta ;
perf.xi_psi=xi_psi;
perf.w_phi=w_phi ;
perf.w_theta=w_theta;
perf.w_psi=w_psi;


% reference to follow
Nnew = 400;
x_ref = [2*ones(N-Nnew,1); 5*ones(Nnew,1)];
y_ref = [1*ones(N-Nnew,1); -2*ones(Nnew,1)];
z_ref = 1*[7*ones(N-Nnew,1); 5*ones(Nnew,1)]; %10
phi_ref = 0*[pi/10*ones(N-Nnew,1);0*ones(Nnew,1)];
theta_ref = 0*[-pi/10*ones(N-Nnew,1);0*ones(Nnew,1)];
psi_ref = 1*[-pi/4*ones(N-Nnew,1);-pi/2*ones(Nnew,1)]; % pi/2
%phi_ref


N_ref_step1 = 1000;
N_ref_step2 = 1300;
theta_circle = linspace(0,2*pi,N);
x_ref = 4*cos(theta_circle) + 1;
y_ref = 4*sin(theta_circle) + 1;
z_ref = 1*[5*ones(N_ref_step1,1); 5*ones(N_ref_step2-N_ref_step1,1) ; 2*ones(N-N_ref_step2,1)];



Xref =  zeros(12,N);
Xref(1,:) = x_ref;
Xref(2,:) = y_ref;
Xref(3,:) = z_ref; 
% Xref(7,:) = phi_ref; 
% Xref(8,:) = theta_ref; 
Xref(9,:) = psi_ref; 
u = zeros(nu,N-1);
u_1 = zeros(1,N-1);
wi_sq = zeros(nu,N-1);
% wi_sq = wi^2 : square of the motor rotation speed


%% UAV dynamic and command

for k=1:N-1

    %wi_sq = zeros(4,1); % input(t); 
    %wi_sq(:,k) = wsteady_sq*[1.005 0.995 1.005 0.995]';  % yaw -> tau_psi

    %wi_sq(:,k) = wsteady_sq*[0.98 1 1.02 1]'; % pitch -> tau_theta 

    %wi_sq(:,k) = wsteady_sq*[1 1.02 1 0.98]';   % roll -> tau_phi

    %wi_sq = wsteady_sq*ones(4,1); % input to produce thrust that compensate gravity and stay steady
    
    
    %wi_sq_z = m/(4*k_f)*(g - 2*xi_z*w_z*Xdot(3,k) - w_z^2*(X(3,k)-z_ref(k)))*ones(4,1);
    % (0.8*k+N)/N*

    u_1(k) = m*g + k_D*Xglob(6,k) - m*(2*xi_z*w_z*Xglob(6,k) + w_z^2*(Xglob(3,k) - z_ref(k)));
    u_1(k) = max(0,u_1(k)); % constraint u_1 >= 0
    
    [phi_ref,theta_ref] = input_Theta_from_position_ref(Xglob(:,k),Xref(:,k),u_1(k),perf,data);
    
    % Saturation ref angle
    max_phi_ref = 35*pi/180;
    max_theta_ref = 35*pi/180;
%     max_phi_ref = 70*pi/180;
%     max_theta_ref = 70*pi/180;
    theta_ref_sat =  sign(theta_ref)*min(abs(theta_ref),max_theta_ref);
    phi_ref_sat =  sign(phi_ref)*min(abs(phi_ref),max_phi_ref);

    Xref(7,k) = phi_ref_sat;
    Xref(8,k) = theta_ref_sat;
    
    % Command
    u(:,k) = torque_2nd_order_track_ref(Xglob(:,k),Xref(:,k),perf,data);
    wi_sq(:,k) = torque2motor_speed(u(:,k),data);

    omega_B(:,k) = thetadot2omega(Thetadot(:,k), Theta(:,k));

    % Compute linear and angular accelerations.
    a(:,k) = quad_acceleration( wi_sq(:,k), Theta(:,k), Xdot(:,k), data);
    omegadot_B(:,k) = quad_angular_acceleration(wi_sq(:,k), omega_B(:,k), data);

    omega_B(:,k+1) = omega_B(:,k) + dt * omegadot_B(:,k);
    Thetadot(:,k+1) = omega2thetadot(omega_B(:,k+1), Theta(:,k)); 
    Theta(:,k+1) = Theta(:,k) + dt * Thetadot(:,k+1);

    Xdot(:,k+1) = Xdot(:,k) + dt*a(:,k);
    X(:,k+1) = X(:,k) + dt*Xdot(:,k+1);

    Xglob(:,k+1) = [X(:,k+1);Xdot(:,k+1);Theta(:,k+1);Thetadot(:,k+1)];


end

% problème angle theta 
% et rotation drone


% Suggestion improvments

% add wind perturbation

% add an observer that estimate the state
 
% add measurement noise


% T_B = thrust(wi_sq, k_f)
% tau = torques(wi_sq, L, k_M, k_f)

X
x = X(1,:);
y = X(2,:);
z = X(3,:);


Theta;
phi = Theta(1,:);
theta = Theta(2,:);
psi = Theta(3,:);

min_wi_sq = min(min(wi_sq))

warning("Max acceleration and speed computations") % with saturation

% %     tau = [
%         L * k_f * (inputs(1) - inputs(3))
%         L * k_f * (inputs(2) - inputs(4))
%         k_M * (inputs(1) + inputs(3) - inputs(2) - inputs(4))

%     ];

%
% test = tf([1],[1 2*1 1])


%mat_rot_psi = @(psi) [sin(psi) -cos(psi) ; cos(psi) sin(psi)];



% RMSE_init = mean(sqrt(sum((X(:,1:10) - Xref(1:3,1:10)).^2)))


pos_RMSE = mean(sqrt(sum((X - Xref(1:3,:)).^2)))

toc(t_Start)


%% Visualization UAV trajecotry and tracking performance

% run plot_perf_quadcopter.m

% run plot3D_anime_body_frame.m

% run plot_command_quadcopter.m


