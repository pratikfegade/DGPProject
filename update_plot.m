function [] = update_plot(surface, sampled_pts)
    global grid_resolution f;
    clf(f);
    surf(linspace(-100, 100, 2*grid_resolution+1), linspace(-100,100, 2*grid_resolution+1), surface');
    hold all
    scatter3(sampled_pts(1,:), sampled_pts(2,:), sampled_pts(3,:));
    drawnow;
end