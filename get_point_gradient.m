function [gradient] = get_point_gradient(surface, i, j, skeleton, error_function)
    global grid_resolution;
    global derivative_step;
    
    base_error = error_function(surface, skeleton);
    surface(i,j) = surface(i,j) + derivative_step;
    new_error = error_function(surface, skeleton);
    surface(i,j) = surface(i,j) - derivative_step;
    gradient = new_error - base_error;
end