function [fin_surface, fin_error] = pointwise_grad_descent(surface, skeleton, error_function)
    global descent_multiplier;
    global grid_resolution;
    h = fspecial('gaussian',[5,5],2);
    fin_surface = surface;
    maskmat = zeros(size(surface));
    fin_error = 0;
    for i=1:(2*grid_resolution + 1)
        for j=1:(2*grid_resolution + 1)
            maskmat(i,j) = 1;
            prev_error = error_function(fin_surface, skeleton);
            base_error = prev_error;
            grad = get_point_gradient(fin_surface, i, j, skeleton, error_function);
            current_error = error_function(fin_surface - descent_multiplier * grad * maskmat, skeleton);
            while current_error < prev_error && descent_multiplier < 1024
                descent_multiplier = descent_multiplier * 2;
                prev_error = current_error;
                current_error = error_function(fin_surface - descent_multiplier * grad * maskmat, skeleton);
            end

            while current_error > base_error
                descent_multiplier = descent_multiplier / 2;
                current_error = error_function(fin_surface - descent_multiplier * grad * maskmat, skeleton);
            end

            fin_surface = fin_surface - smooth_perturbation(descent_multiplier * grad * maskmat, h);
            fin_error = current_error;
            maskmat(i,j) = 0;
        end
    end
end