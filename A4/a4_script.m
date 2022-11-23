fprintf("as window size goes up it improves the warp quality but only up to a certain point. after a large enough window size artifacts are introduced")
% ==============sphere======================================================
% 
img1 = imread("Sequences/sphere/sphere_0.png");
img2 = imread("Sequences/sphere/sphere_1.png");
% sphere is not greyscale
grey_image1 = rgb2gray(img1);
grey_image2 = rgb2gray(img2);

dimension = 3;
threshold = 0.0000000001;

% get the u v and binary map of the sphere
[sphere_flow, sphere_bin_map, sphere_back_warp, sphere_differences] = image_calculator(img1,img2,grey_image1, grey_image2, dimension, threshold);
show(sphere_flow, sphere_bin_map, sphere_back_warp, sphere_differences, img1);
pause;

%====================synth=================================================
synth1 = imread("Sequences/synth/synth_0.png");
synth2 = imread("Sequences/synth/synth_1.png");
%synth is already greyscale
dimension = 3;
threshold = 0.001;
%get the u v and binary map of the sphere
[synth_flow, synth_bin_map, synth_back_warp, synth_differences] = image_calculator(synth1,synth2,synth1, synth2, dimension, threshold);
show(synth_flow, synth_bin_map, synth_back_warp, synth_differences, synth1);
pause;


% ===================corridor 1 and 2 ======================================
corridor1 = imread("Sequences/corridor/bt_0.png");
corridor2 = imread("Sequences/corridor/bt_1.png");
%greyscale already too
dimension = 3;
threshold = .0009;
%get the u v and binary map of the sphere
[corridor_flow, corridor_bin_map, corridor_back_warp, corridor_differences] = image_calculator(corridor1,corridor2, corridor1, corridor2, dimension, threshold);

show(corridor_flow, corridor_bin_map, corridor_back_warp, corridor_differences, corridor1);
pause;


% =my own test cases from middlebury dataset===============================
urban1 = imread("Sequences/Urban/frame10.png");
urban2 = imread("Sequences/Urban/frame11.png");
dimension = 6;
threshold = 0.00011;
%greyscaled
grey_urban1 = rgb2gray(urban1);
grey_urban2 = rgb2gray(urban2);

[urban_flow, urban_bin_map, urban_back_warp, urban_differences] = image_calculator(urban1,urban2,grey_urban1, grey_urban2, dimension, threshold);

show(urban_flow, urban_bin_map, urban_back_warp, urban_differences, urban1);
% some artifacts show up here because of the size of the jump and also
% occlusion of parts of the image specifically the building and roof of the
% lower left side






% No idea where the starter code is for the harris detectors, either way
% ran out of time

