function [gradient] = get_gradient(surface, skeleton)
    global grid_resolution;
    global apunka_derivative_step;
    base_error = calc_error(surface, skeleton);
    gradient = zeros(size(surface));
    pert = zeros(size(surface));
    for i = 1:(2 * grid_resolution + 1)
        for j = 1:(2 * grid_resolution + 1)
            pert(i,j) = apunka_derivative_step;
            surface = surface + smooth_perturbation(pert);
            new_error = calc_error(surface, skeleton);
            gradient(i,j) = (new_error - base_error);
            surface = surface - smooth_perturbation(pert);
            pert(i,j) = 0;
        end
    end     
end