opengl 'hardware';

close all;
clear all;

image_path = ('http://192.168.1.2:8080/shot.jpg');

triger = 2000;
G = fspecial('gaussian',[5 5],1.5);

current_image = imread( image_path );
current_image = imfilter(current_image,G,'same');
current_image = double(current_image);
Gauss.mean = current_image;
Gauss.standard_deviation = 256*ones(size(current_image));

sigma = 3;
rho = 0.999;
%%
figure(1);
set(gcf,'Renderer','opengl');

for j=1:triger
    current_image = imread(image_path);
    current_image = imfilter(current_image,G,'same');
    current_image = double(current_image);

    Gauss.movement = (abs(current_image-Gauss.mean)./sqrt(Gauss.standard_deviation));
    Gauss.movement = Gauss.movement>sigma;

    Gauss.mean = rho*Gauss.mean+(1-rho)*(current_image);
    Gauss.standard_deviation = rho*Gauss.standard_deviation+(1-rho)*(current_image-Gauss.mean).^2;
    Gauss.error = mean(mean(mean((current_image-Gauss.mean).^2)));

    subplot(1,2,1);
    imagesc(uint8(Gauss.mean));

    subplot(1,2,2);
    imagesc(Gauss.movement);
    drawnow; 
end
