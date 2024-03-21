function [path, num_expanded] = Avoid_block(map, start, goal)
%   Find the shortest path from start to goal.
%   PATH = Avoid_block(map, start, goal) returns an M-by-3 matrix, where each row
%   consists of the (x, y, z) coordinates of a point on the path. 
%
%   [PATH, NUM_EXPANDED] = Avoid_block(...) returns the path as well as
%   the number of points that were visited while performing the search.

function cost = euclidean_heuristic(start_pos, goal_pos)
    cost = sqrt(sum((double(start_pos) - double(goal_pos)).^2));
end
path = [];
num_expanded = 0;

start_xyz = start;
goal_xyz = goal;

start = points_to_idx(map, start);
goal = points_to_idx(map, goal);

% init distance map
dist = inf(size(map.occ_map)); % init as inf distance
dist(start(1), start(2), start(3)) = 0; % set start dist as 0
unvisited = ones(map.nx, map.ny, map.nz); % unvisited: 1, visited: inf
% set back tracking map
prev = zeros(size(map.occ_map,1), size(map.occ_map,2), size(map.occ_map,3), 3);

% A set of possible directions of movement
movement = [1,0,0;-1,0,0; 0,1,0; 0,-1,0; 0,0,1; 0,0,-1];
% Avoid algorithm
fscore = inf(size(map.occ_map)); % init as inf distance
fscore(start(1), start(2), start(3)) = euclidean_heuristic(start, goal); % set start dist
onset = inf(size(map.occ_map));
onset(start(1), start(2), start(3)) = 1;

while (~all(onset(:)==inf))
    % find the min point with lowest fscore in the onset
    onfscore = fscore.*onset;
    [~, id] = min(onfscore(:));
    
    if id == (goal(3)-1)*map.nx*map.ny + (goal(2)-1)*map.nx + goal(1);
        % if found the goal position, stop searching
        break
    end
    % remove current node from the set
    onset(id) = inf;
    unvisited(id) = inf;
    num_expanded = num_expanded + 1; 
    % check 6-connected neighbors
    [i,j,k] = ind2sub([map.nx,map.ny,map.nz],id);
    for d = 1:size(movement,1)
        nijk = bsxfun(@plus, int32([i,j,k]), int32(movement(d,:)));
        % if neighbor (in the map) and (unvisited) and (unoccupied)
        if all(nijk > 0) && all(int32([map.nx, map.ny, map.nz]) >= int32(nijk)) ...
            && unvisited(nijk(1),nijk(2),nijk(3)) == 1 ...
            && map.occ_map(nijk(1),nijk(2),nijk(3)) ~= 1
            % gscore is the distance from start to the neighbor via current position
            nid = (nijk(3)-1)*map.nx*map.ny + (nijk(2)-1)*map.nx + nijk(1);
            gscore = dist(id) + sqrt(sum(movement(d,:).^2));
            if onset(nid) == inf
                onset(nid) = 1;
            elseif gscore >= dist(nid) 
                % then it is a longer path
                continue
            end
            
            % then this is the best path till now
            prev(nijk(1), nijk(2), nijk(3),:) = [i,j,k];
            dist(nid) = gscore;
            fscore(nid) = dist(nid) + euclidean_heuristic(nijk, goal);
        end
    end
end



if dist(goal(1), goal(2), goal(3)) == inf
    path = [];
else
    path = [goal(1), goal(2), goal(3)];
    % back track to the start pos
    cur_p = reshape(prev(goal(1), goal(2), goal(3), :),[1,3]);
    while any(cur_p ~= start)
        path = [cur_p;path];
        cur_p = reshape(prev(cur_p(1), cur_p(2), cur_p(3), :), [1,3]);
    end
    path = [cur_p;path];
end
path = idx_to_points(map, path);

if size(path, 1) > 0
path = [start_xyz; path; goal_xyz];
end

plot3(path(:,1), path(:,2), path(:,3), '-o'); % Plot the path
% Customize the plot
grid on; % Turn on the grid
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
title('3D Trajectory Visualization');
hold on; % Keep the plot
start_point = path(1, :);
end_point = path(end, :);
plot3(start_point(1), start_point(2), start_point(3), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'b'); % Start point in blue
plot3(end_point(1), end_point(2), end_point(3), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r'); % End point in red
hold off; % 
view(3); % Sets the default three-dimensional view

end