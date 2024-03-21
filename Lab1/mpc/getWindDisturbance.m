function [windDisturbance] = getWindDisturbance(t)
% This function generates wind disturbances for the quadrotor model
% based on a list of stop points.
%
% Inputs:
%   t: Time vector

%
% Output:
%   windDisturbance: Matrix of wind disturbances, where each row represents
%                    a time point and the columns are [windX, windY]

% Initialize wind disturbance matrix
windDisturbance = zeros(length(t), 3);

%   stopPoints: Matrix of stop points, where each row represents a stop point
%               in the format [time, windX, windY, windZ]
stopPoints = [1, 15, 0, 0; 
              5, 0, 15, 0; 
              8, 10, 10, 1];


% Iterate through stop points
for i = 1:size(stopPoints, 1)
    % Get current stop point
    stopTime = stopPoints(i, 1);
    windX = stopPoints(i, 2);
    windY = stopPoints(i, 3);
    windZ = stopPoints(i, 4);
    
    % Find time points after the current stop point
    indices = find(t >= stopTime);
    
    % Set wind disturbance values for the corresponding time points
    windDisturbance(indices, 1) = windX;
    windDisturbance(indices, 2) = windY;
    windDisturbance(indices, 3) = windZ;
end
end