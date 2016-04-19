% grid goes from -100 to 100 in both dimensions
global grid_resolution
grid_resolution = 20;
% Fraction of grid over which skeleton is present. Need not be changed
% normally
grid_fraction = 0.8;

% Error params
global gap_penalty_multiplier collision_penalty_multiplier
global smoothness_penalty_multiplier concavity_penalty_multiplier prior_penalty_multiplier
gap_penalty_multiplier = 1;
collision_penalty_multiplier = 1;
smoothness_penalty_multiplier = 0.01;
concavity_penalty_multiplier = 1;
prior_penalty_multiplier = 1;

% Skeleton sampling params
sampling_rate = 1;

% gradient descent
gd_iters = 100;
global apunka_derivative_step
apunka_derivative_step = 0.01;
global descent_multiplier
descent_multiplier = 1;

% Skeleton input
skeleton_points = importdata('./data/ske_1_points.txt')';
skeleton_joints = importdata('./data/ske_1_joints.txt')';

% Normalise skeleton
ske_min = min(skeleton_points, [], 2);
ske_max = max(skeleton_points, [], 2);
mean = (ske_min + ske_max) / 2;
skeleton_points = bsxfun(@minus, skeleton_points, mean);
max_dims = ske_max - ske_min;
max_dim_length = max(max_dims(1:2,:), [], 1);
skeleton_points = skeleton_points * (grid_fraction * 200) / max_dim_length;

% Sample skeleton
sampled_pts = [];
for i = 1:size(skeleton_joints, 2)
    joint = skeleton_joints(:,i);
    point1 = skeleton_points(:,joint(1));
    point2 = skeleton_points(:,joint(2));
    num_pts = norm(point1 - point2, 2) * (grid_resolution / 200) * sampling_rate;
    pts = [linspace(point1(1), point2(1), num_pts); ...
           linspace(point1(2), point2(2), num_pts); ...
           linspace(point1(3), point2(3), num_pts)];
    sampled_pts = [sampled_pts,pts];
end
scatter3(sampled_pts(1,:), sampled_pts(2,:), sampled_pts(3,:));

surface = zeros(grid_resolution * 2 + 1) -100;

for i = 1:gd_iters
    i
    [surface, error] = grad_descent(surface, sampled_pts);
    error
end

hold all;
surf(linspace(-100, 100, 2*grid_resolution+1), linspace(-100,100, 2*grid_resolution+1), surface')
scatter3(sampled_pts(1,:), sampled_pts(2,:), sampled_pts(3,:))