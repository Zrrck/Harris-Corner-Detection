clc;clear all;close all;
I1=imread ('okul2.jpg');
I2 = rgb2gray(I1);
I2  = im2double(I2);

K=0.04;
Threshold=1;

figure;

imshow(I2);





dx = [-1 0 1;-1 0 1;-1 0 1];
dy = [1 1 1;0 0 0;-1 -1 -1];
Ix = conv2(I2, dx, 'same');   
Iy = conv2(I2, dy, 'same');
Ix_new = Ix.^2;
Iy_new = Iy.^2;
Ixy_new = Ix.*Iy;
figure;
imshow(Ix_new);
figure;
imshow(Iy_new);
figure;
imshow(Ixy_new);

Det_M= (Ix_new.*Iy_new );
Trace_M=Ix_new + Iy_new;

R = Det_M - K*((Trace_M)).^2;

disp(max(max(R)));

[h , w] = size(R);

for i = 1:1:h
    for j = 1:1:w
        if R(i,j) > 0.5
        I3(i,j) = 255;
        else
            I3(i,j) = 0;
        end
    
    end
end
figure;

imshow(I3);


