function Edges = MyCanny(img,std_dev,t)

    low_t = 5;
    % img = double(rgb2gray(img));
    img = double(img);

 
    %Get some image details
    img_size = size(img);
    img_height = img_size(1);
    img_width = img_size(2);
 
    
    %Take derivative of gaussian as a vector, so it's separable
    kernel = fspecial('gaussian',[5 1],std_dev);
    h = fspecial('sobel');

    %Filter the kernel with the derivative filter
    g_dy = imfilter(kernel,h,'conv');
 
    %Get image derivatives in X and Y directions
    d_img_x = imfilter(img,g_dy','conv');
    d_img_y = imfilter(img,g_dy,'conv');

 
    %Get the gradient directions and magnitudes for each pixel
    grad_dir = atan2(d_img_y,d_img_x);
    grad_mag = sqrt(d_img_x.^2 +  d_img_y.^2);

    grad_mag_h = (grad_mag > t);
    grad_mag_l = (grad_mag > low_t);

 
    %Suppress every pixel whose gradient magnitude is below the threshold
    grad_mag = (grad_mag(:,:) > t) .* grad_mag;


     %Loop to check if every pixel is at a local max
     edg_img = zeros(img_height,img_width);
 
     for i=2:img_height-1,
         for j=2:img_width-1,
             pixel_m = grad_mag(i,j);
             pixel_d = abs(grad_dir(i,j));

            if pixel_d < 0,
                pixel_d = pixel_d + pi;
            end
            
 
             if (pixel_d >= 0 & pixel_d < (pi/6)) | (pixel_d <= pi & pixel_d >= (5*pi/6)),
                 %Check left/right
                 if pixel_m > grad_mag(i,j-1) & pixel_m > grad_mag(i,j+1),
                     edg_img(i,j) = 1;
                 end
             end
 
             if (pixel_d >= (pi/3) & pixel_d < (2*pi/3)),
                 %Check up/down
                 if pixel_m > grad_mag(i-1,j) & pixel_m > grad_mag(i+1,j),
                     edg_img(i,j) = 1;
                 end
             end
 
             if (pixel_d >= (pi/6) & pixel_d < (pi/3)),
                 %Check top-right/bottom-left
                 if pixel_m > grad_mag(i-1,j+1) & pixel_m > grad_mag(i+1,j-1),
                     edg_img(i,j) = 1;
                 end
             end
 
             if (pixel_d >= (2*pi/3) & pixel_d <(5*pi/6)),
                 %Check top-left/bottom-right
                 if pixel_m > grad_mag(i-1,j-1) & pixel_m > grad_mag(i+1,j+1),
                     edg_img(i,j) = 1;
                 end
             end
         end
     end

     imshow(edg_img,[])


     Edges = edg_img;
 

 
 
 