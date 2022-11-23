function [u, v, binary_map] = myFlow(image1, image2, window_length, threshold)

%sets the values between 0 and 1 scaled to the min and max of the images
image1 = rescale(image1);
image2 = rescale(image2);

default_image1 = image1;
default_image2 = image2;

%set the filters
filter_x_axis = [-1/12 2/3 0 -2/3 1/12];

%transpose to set y
filter_y_axis = transpose(filter_x_axis);

    scale = 1;
    d = window_length;
    %create empty u, v, and binmap
    u = zeros(size(image1));
    v = zeros(size(image1));
    binary_map = zeros(size(u));

   %looping through the dimensions
while true
    
    %set to default again for every loop
    u = zeros(size(image1));
    v = zeros(size(image1));
    binary_map = zeros(size(u));

    %convolving the filters at every pixel
    Idx = imfilter(image1, filter_x_axis);
    Idy = imfilter(image1, filter_y_axis);

    %gaussian filter for the temporal derivative
    sigma = 1;

    %take the temporal derivative gaussian of the image and then subtract
    %the two
    Idt = imgaussfilt(image1, sigma) - imgaussfilt(image2, sigma);
    
    %partials for sum sum idxidx etc. sets up A 1 is a small sigma of the entire
    %image for the gaussian, and so is a small smoothing effect
    Idxdy = imgaussfilt(Idx.*Idy, 1);
    Idxdx = imgaussfilt(Idx.*Idx, 1);
    Idydy = imgaussfilt(Idy.*Idy, 1);
    Idxdt = imgaussfilt(Idx.*Idt, 1);
    Idydt = imgaussfilt(Idy.*Idt, 1);
    
    %take the dimension window size gaussian filter at the points
    Idxdy_filtered = imgaussfilt(Idxdy, d);
    Idxdx_filtered = imgaussfilt(Idxdx, d);
    Idydy_filtered = imgaussfilt(Idydy, d);
    Idxdt_filtered = imgaussfilt(Idxdt, d);
    Idydt_filtered = imgaussfilt(Idydt, d);
    
    %get the row and columns sizes
    rows = size(image1, 1);
    columns = size(image1, 2);
   
    
    %for each pixel compute Au = b or (A^T*A)u = A^T*B or
    % u = (A^T*A)^-1*A^T* B
    for row = 1:rows
        for col = 1:columns
            %makes A and B so we can take the inverse and solve
            A = [Idxdx_filtered(row, col), Idxdy_filtered(row, col) ; Idxdy_filtered(row, col), Idydy_filtered(row, col)];
            B = [-Idxdt_filtered(row, col) ; -Idydt_filtered(row, col)];

            %if the eigenvalues are over the threshold then it's ok and the
            %and we can find the inverse
            %A = {Idxdx, Idxdy Idxdy, Idydy} 
            eiganvalues = eig(A);
            %if it's valid
            if (eiganvalues > threshold)
%                 x = inv(A) * B;
                  x = A \ B;
                %record the values
                u(row, col) = x(1);
                v(row, col) = x(2);

                binary_map(row, col) = 1;

                %otherwise set it to 0 to show invalid both in binmap and
                %in u and v
            else
                binary_map(row, col) = 0;
                u(row, col) = 0;
                v(row, col) = 0;
            end
 
        end
    end

    %break out of the loop if you are done with the dimensions
          if max(u(:)) < 5 && max(v(:)) < 3
              
        break;
          end
    %if not rescale again down by half to try and get the pixel movement
    %down to 1 pixel
    scale = scale * 2;
    image1 = imresize(default_image1, 1/scale);
    image2 = imresize(default_image2, 1/scale);
end

%if rescaled rescale back up to default
u = imresize(u, size(default_image1)) * scale;
v = imresize(v, size(default_image1)) * scale;
binary_map = imresize(binary_map, scale);

end