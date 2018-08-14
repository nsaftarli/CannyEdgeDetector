%Canny Edge Detector

fprintf('The test image:\n')
img = imread('bowl-of-fruit.jpg');
imshow(img, []);
pause;
img = rgb2gray(img);
my_edges = MyCanny(img,3,10);
imshow(my_edges,[]);
pause;

fprintf('Second image:\n')
img = imread('building.png');
imshow(img, []);
pause;
img = rgb2gray(img);
my_edges = MyCanny(img,3,15);
imshow(my_edges,[]);
pause;