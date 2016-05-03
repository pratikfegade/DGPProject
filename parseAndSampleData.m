function sampled_pts = parseAndSampleData(pointsFile, jointsFile)
global grid_fraction grid_resolution

% Skeleton sampling params
sampling_rate = 10;

% Skeleton input
skeleton_points = importdata(pointsFile)';
skeleton_joints = importdata(jointsFile)';

% Normalise skeleton
ske_min = min(skeleton_points, [], 2);
ske_max = max(skeleton_points, [], 2);
mean = (ske_min + ske_max) / 2;
skeleton_points = bsxfun(@minus, skeleton_points, mean);
max_dims = ske_max - ske_min;
max_dim_length = max(max_dims(1:2,:), [], 1);
skeleton_points = skeleton_points * (grid_fraction * 200) / max_dim_length;

% Keep feet on the ground
skeleton_points(3,:) = skeleton_points(3,:) - min(skeleton_points(3,:)) + 5;

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
end