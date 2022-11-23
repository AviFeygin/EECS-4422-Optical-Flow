function show(flow, bin_map, back_warp, differences, img1)


    show = figure("Name",'flow to color, binary map, backwarp , differences');
    montage({flow, bin_map, back_warp, differences});

    flicker = figure("Name",'flicker');
    for i = 1:50
        if mod(i, 2) == 0
            imshow(back_warp, 'InitialMagnification','fit');
            drawnow;
        else
            imshow(img1, 'InitialMagnification', 'fit');
            drawnow;
        end
    end
end
