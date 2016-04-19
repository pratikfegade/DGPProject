function [op] = plot_surf( surface )
%PLOT_SURF Summary of this function goes here
%   Detailed explanation goes here
  op = 0;
  global grid_resolution;
  surf(linspace(-100, 100, 2*grid_resolution+1), linspace(-100,100, 2*grid_resolution+1), surface')

end

