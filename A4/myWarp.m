function back_warped = myWarp(image, u, v)
%recreate the map
map = cat(3, u, v);

%used imwarp
back_warped = imwarp(image, map ,'cubic');
f = figure();
montage({(back_warped - image),imabsdiff(back_warped, image)})
% imshow(back_warped - image);
% imshow(imabsdiff(back_warp, original1))
%mat i have no idea how to use the 2 functions he hinted at for this.
%instead i used imwarp.
end