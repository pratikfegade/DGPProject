% grid goes from -100 to 100 in both dimensions
global grid_resolution
grid_resolution = 20;
% Fraction of grid over which skeleton is present. Need not be changed
% normally
global grid_fraction
grid_fraction = 0.5;

gap_collision_iters = 1;
flatness_iters = 1;
prior_iters = 1;

% gradient descent
gd_iters = 200;
global derivative_step
derivative_step = 0.01;
global descent_multiplier
descent_multiplier = 1;
global smooth_iters
smooth_iters = 2;

sampled_pts = parseAndSampleData('./data/ske_comp_points.txt', './data/ske_comp_joints.txt');

surface = zeros(grid_resolution * 2 + 1);

% error_components = { @gap_collision_penalty, @flatness_penalty, @prior_penalty}
error_components = { @gap_collision_penalty, @flatness_penalty}
% component_iters = [ gap_collision_iters, flatness_iters, prior_iters]
component_iters = [ gap_collision_iters, flatness_iters]
global f;
f = figure;

error_track = [1, 1];
error = inf;
for i = 1:gd_iters
    i
    for j = 1:size(error_components, 2)
        prev_error = error;
        [surface, error] = perform_grad_descent(surface, sampled_pts, error_components{j}, component_iters(j));
        error_track(j) = abs(prev_error - error);
    end
%     [minv, mind] = min(error_track);
%     for j = 1:size(error_components, 2)
%         if j == mind
%             component_iters(j) = 1
%         else
%             component_iters(j) = ceil(error_track(j) / error_track(mind));
%         end
%     end
%     component_iters
    
end


