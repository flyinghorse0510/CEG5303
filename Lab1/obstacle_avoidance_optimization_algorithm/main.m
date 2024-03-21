close all;
clear;
clc
addpath(genpath('./'));
% map_col used to generate path and check collision(the blocks will be enlarged to ensure quotrotor to pass)
map_col= load_map_larger('maps/map3.txt', 0.5, 0.2, 0); % xy res, z res, margin
% map used to visualization
map = load_map('maps/map3.txt', 0.5, 0.15, 0.3); 
% test for map1
%start = [5.0 -1 3.5];
%stop  = [5.0 19.0 .5];

% test for map2
%start = [2 30 5];
%stop  = [5 15 2];

% test for map3
start = [3 2 3.5];
stop  = [9 2 3];
%% Generate way points and visualize the environment
path = Avoid_block(map_col, start, stop);

figure(1);
plot_path(map, path);
axis equal
grid on
title('Quad Simulator');xlabel('x');ylabel('y');zlabel('z');
hold on
plot3(start(1),start(2),start(3), '*b', 'MarkerSize', 12)
plot3(stop(1),stop(2),stop(3), '*g', 'markersize', 12)
hold off
view(3)
%% Desired trajectory generation
traj_obj = trajectoryGenerator(map_col, path);

