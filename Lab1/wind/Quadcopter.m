%Quadcopter simulation and PID control based on cartesian coordinate system. 
%Input to the system is force in z, torques in roll pitch and yaw
close all;
clear;
clc;
g = 9.81;
m = 2.355; %mass of quadcopter


% new wind combination
Kp_z = 30;
Ki_z = 0;
Kd_z = 50;

Kp_pos = 10;
Ki_pos = 0.05;
Kd_pos = 3;

Kp_att = 0.03;
Ki_att = 0;
Kd_att = 0.4;

Kp_psi = 1;
Ki_psi = 0.1;
Kd_psi = 1.5;

%Generate some waypoints for the quadcopter to follow (every row is x,y,z)
%Free free to generate your own trajectory by modifying the waypoints.
%Notice we only give waypoints in x, y, z. Roll, pitch, yaw needs to be
%close to 0.
waypoints = [
    0 0 1;
    1 0 1;
    0 0.8 1.5;
    -1 0 1;
    0 -1 1;];


t = 120; %time length of simulation
dt = 0.01;
%generate time vector
t_ref = 0:dt:t; 
%Get x, y, z reference from waypoints
x = waypoints(:,1);
y = waypoints(:,2);
z = waypoints(:,3);
%Make x,y,z reference to be same length as time
duration_each = floor(size(t_ref,2) / (size(waypoints,1)));
x_ref = repelem(x, duration_each);
y_ref = repelem(y, duration_each);
z_ref = repelem(z, duration_each);
if length(x_ref) < size(t_ref,2)
    x_ref(size(t_ref,2)) = x_ref(end);
    y_ref(size(t_ref,2)) = y_ref(end);
    z_ref(size(t_ref,2)) = z_ref(end);
end

% generate the wind speed time series
wind_speed = [0 4.3 0; 
              0 4.3 0; 
              0 4.3 0;
              0 4.3 0; 
              0 4.3 0];
duration_each = floor(size(t_ref,2) / (size(wind_speed, 1)));
wind_speed_series = repelem(wind_speed, duration_each, 1);
if (length(wind_speed_series) < size(t_ref,2))
    wind_speed_series(size(t_ref,2), :) = wind_speed_series(end, :);
end
v_w = [t_ref', wind_speed_series];

%Combine time and reference
x_ref = [t_ref', x_ref];
y_ref = [t_ref', y_ref];
z_ref = [t_ref', z_ref];

%Run the simulink simulation (Need to finish the TODOs in the simulink before running the simulation!)
out = sim('Quadcopter_simulation',t);

%Get output states
time = out.states.Time;
x_out = out.states.Data(:,1);
y_out = out.states.Data(:,2);
z_out = out.states.Data(:,3);
x_dot_out = out.states.Data(:,4);
y_dot_out = out.states.Data(:,5);
z_dot_out = out.states.Data(:,6);
phi_out = out.states.Data(:,7);
theta_out = out.states.Data(:,8);
psi_out = out.states.Data(:,9);
phi_dot_out = out.states.Data(:,10);
theta_dot_out = out.states.Data(:,11);
psi_dot_out = out.states.Data(:,12);

%Plot the X,Y,Z states.
figure(1);
subplot(3,1,1);hold on;
plot(time,x_out); plot(time,x_ref(:,2));
title ('X to time'); ylabel('X');
subplot(3,1,2);hold on;
plot(time,y_out); plot(time,y_ref(:,2));
title ('Y to time'); ylabel('Y');
subplot(3,1,3);hold on;
plot(time,z_out); plot(time,z_ref(:,2));
title ('Z to time'); ylabel('Z');
xlabel('Time');
legend('State','Reference');
%Plot the roll, pitch, yaw states.
figure(2);
subplot(3,1,1);plot(time,phi_out); title ('phi to time'); ylabel('phi');
subplot(3,1,2);plot(time,theta_out); title ('theta to time'); ylabel('theta');
subplot(3,1,3);plot(time,psi_out); title ('psi to time'); ylabel('psi');
xlabel('Time');

%%%%%%%%%%%%%%%%%%%%%%%
figure(3);
plot3(x_out,y_out,z_out,'-b');
hold on
plot3(x,y,z,'*r');
plot3(x,y,z,'-g');
legend({'Quadcopter','Waypoints','Reference Trajectory'});
% some axis properties:
box on
grid on
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Position');

%get control usage
u_T = out.control.Data(:,1);
u_phi = out.control.Data(:,2);
u_theta = out.control.Data(:,3);
u_psi = out.control.Data(:,4);
figure(4);
plot(time,u_T, time,u_phi,time,u_theta, time, u_psi)
title('Control usage');
legend('T','torque phi','torque theta','torque psi');

%Plot the X,Y,Z states.
figure(5);
subplot(3,1,1);hold on;
plot(time,x_dot_out);
title ('X dot to time'); ylabel('X');
subplot(3,1,2);hold on;
plot(time,y_dot_out);
title ('Y dot to time'); ylabel('Y');
subplot(3,1,3);hold on;
plot(time,z_dot_out);
title ('Z dot to time'); ylabel('Z');
xlabel('Time');
legend('State');