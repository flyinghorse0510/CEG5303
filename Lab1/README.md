# CEG5303 Lab 1

In this lab assignment, we modelled quadcopter system using Matlab and simulink using basic aerodynamics. Various control methods including PID and MPC are realized to control the quadcopter to follow a given trajectory. The basic dynamics model given by the TA is also refined to 
consider a more realistic wind dragging effect.

## Group 20

Member
- MA HAOYUAN (`complex_trajectory`)
- SUN CHENCHEN (`mpc`)
- SUN YIJING (`obstacle_avoidance_ptimization_algorithm`)

## Report
The report is inside the `latex` folder. 

## Getting started

### Basic realization using PID
1. Run `Quadcopter.m` under `basic` folder. This will run the simulation using PID control method
2. Change the PID parameter in `Quadcopter.m` to make the drone follow the trajectory more closely
3. Change the waypoints parameter in `Quadcopter.m` for a more complex trajectory

### More realistic wind effect model
The code is modified from the `basic` folder by changing the `dynamics`
part in the Simulink model. Run it the same way as `Basic realization'. Code is in `wind` folder

### Model Predictive Control (MPC) with quadcopter
1. Run `main.m` under `mpc` folder
2. The `QuadrotorStateFcn.m` and `QuadrotoerStateJacobianFcn.m` is generated using `getQuadrotorDynamicsAndJacobian.m`. The actual dynamics model is implemented inside `getQuadrotorDynamicsAndJacobian.m`. It requires Matlab's `Symbolic Math Toolbox` to run.
3. The drone's reference trajectory is defined in `QuadrotorReferenceTrajectory.m`. It's implemented in the `P = f(t)` style
4. Similary, the external wind disturbance is defined in `getWindDistrubance.m`

### Obstacle Avoidance Optimization Algorithm
1. Run `main` under `obstacle_avoidance_ptimization_algorithm` folder

### Plot Words with Trajectories
1. Run `Quadcopter.m` under `complex_trajectory` folder. This will run the simulation using PID control method

