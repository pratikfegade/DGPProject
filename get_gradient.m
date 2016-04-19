function [gradient] = get_gradient(surface, skeleton)
    global grid_resolution;
    global apunka_derivative_step;
    base_error = calc_error(surface, skeleton);
    gradient = zeros(size(surface));
    for i = 1:(2 * grid_resolution + 1)
        for j = 1:(2 * grid_resolution + 1)
            surface(i,j) = surface(i,j) + apunka_derivative_step;
            new_error = calc_error(surface, skeleton);
            gradient(i,j) = (new_error - base_error);
            surface(i,j) = surface(i,j) - apunka_derivative_step;
        end
    end     
end