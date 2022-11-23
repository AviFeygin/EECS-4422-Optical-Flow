function [flow,bin_map, back_warp, differences] = image_calculator(original1, original2, greyscale1, greyscale2, dimension, threshold)

[u,v, bin_map] = myFlow(greyscale1, greyscale2, dimension, threshold);
image_flow = zeros(size(u, 1), size(v, 2), 2);

image_flow(:, :, 1) = u;
image_flow(:, :, 2) = v;

flow = flowToColor(image_flow);
back_warp = myWarp(original1, u, v);
differences = imabsdiff(back_warp, original1);

end

