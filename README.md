
# Quadcopter-control-and-trajectory-visualization

<img src="https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg" alt="Awesome Repo"/>

 <a href= "https://img.shields.io/badge/github-repo-blue?logo=github"> <img src="https://img.shields.io/badge/github-repo-blue?logo=github" alt="GitHub Badge"/></a>
<a href= "https://img.shields.io/badge/MATLAB-R_2022b-orange"> <img src="https://img.shields.io/badge/MATLAB-R_2022b-orange" alt="Matlab Badge"/></a>
<a href= "https://img.shields.io/badge/License-Apache--2.0-yellow"> <img src="https://img.shields.io/badge/License-Apache--2.0-yellow" alt="License Badge"/></a>

<!-- <span style="color:blue; font-size:2em;">*</span> <span style="color: blue; font-size: 24px;">*</span> -->

## Contents:
- Modelization, simulation and control of a <span style="color:red;">quadcopter UAV</span>
- Visualization of its trajectory and tracking performance 
- Implementation of different nonlinear controlers (**upcoming**)
- Development of state estimators based on noisy measurements and inputs, and performance assessment (**upcoming**)
- Control based on the state estimates (**to do**)
- Add perturbations (wind gust) and parametric uncertainties (**to do**)
- Assess controlers robustness (**to do**)


The quadrotor is modeled using the full 6-DOF Newton–Euler equations (second law of Newton and Euler’s rotation equations), including nonlinear couplings, gyroscopic moments, and cross-inertia effects. 
A reference trajectory is used to evaluate controller precision and robustness (**to do**).


# Quadrotor System Overview

## State vector 

 $X = [x,y,z,\dot{x},\dot{y},\dot{z},\phi,\theta,\psi,\dot{\phi},\dot{\theta},\dot{\psi}],$

where:
- $(x, y, z)$: position
- $\dot{x},\dot{y},\dot{z}$: translational velocity
- $(\phi, \theta, \psi)$: roll, pitch, yaw
- $\dot{\phi},\dot{\theta},\dot{\psi}$: angular velocity

## Control input

- Rotation speed control for each motor (quadcopter: 4 motors)
  
$u =[\omega_1,\omega_2,\omega_3,\omega_4]$

## Control scheme


<img alt="Control" src="pictures/quadcopter_control_loop.png" width="100%" height="100%"> </img>

# Goal:
<div align="center">
<img src="pictures/uav3.png" width="25" height="25" alt="UAV"/>
➡️🚩✅ 
<!-- <a href="https://twitter.com/abhisheknaiidu" ><img src="https://img.shields.io/twitter/follow/abhisheknaiidu.svg?style=social" /> </a> -->
Follow the reference trajectory * 🔵 with the best possible accuracy. 


<br>


<!--<a href="https://github.com/abhisheknaiidu/awesome-github-profile-readme/blob/master/LICENSE"><img src="https://img.shields.io/github/license/abhisheknaiidu/awesome-github-profile-readme?color=2b9348" alt="License Badge"/></a> -->


</div>
<img alt="Illustration" src="pictures/quadcopter_trajectory.gif" width="100%" height="100%"> </img>
<img alt="Illustration" src="pictures/quadcopter_traj_anime.jpg"> </img>


<!-- <i>List of functions</i>  -->


## How to use it

1. Add the entire folder to the MATLAB path: `addpath(genpath("path/folder"))`
2. Run the main script `quadcopter_command_main.m` using MATLAB to launch the simulation
3. Run the script `plot3D_anime_body_frame.m` to launch the animation window displaying the 3D trajectory of the quadcopter, its state evolution and the position reference to follow

<div align="center">
<br> 
<br> 
<img src="https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg" alt="Awesome Badge"/>
<br> 
<img src="pictures/uav3.png" width="50" height="50" alt="UAV"/> <i> 🌟 Loved the project? Add it to your **starred repo** ! 🌟 </i> <img src="pictures/uav3.png" width="50" height="50" alt="UAV"/>
</div>
