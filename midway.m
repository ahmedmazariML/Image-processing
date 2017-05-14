%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Egalisation d'histogrammes

clear all;
close all;

I=double(imread('castle.jpg'))/255;
I=mean(I,3);
figure;
imshow(I);title('Original Image');

I_ajusted=histeq(I,256);
figure;
imshow(I_ajusted);title('Ajusted Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Midway

close all;
clear all;

I1 = double(imread('NotreDame1.tif'))/255;
I2 = double(imread('NotreDame2.tif'))/255;

[I1_sort,I1_index]  = sort(I1(:));
[I2_sort,I2_index]  = sort(I2(:));
I1_midway(I1_index) = (I1_sort + I2_sort)/2;
I2_midway(I2_index) = (I1_sort + I2_sort)/2;
I1_midway = reshape(I1_midway,size(I1));
I2_midway = reshape(I2_midway,size(I2));

figure; subplot(2,2,1), imshow(I1), title('Image 1');
subplot(2,2,2), imshow(I2), title('Image 2');
subplot(2,2,3), imshow(I1_midway), title('Image 1 midway');
subplot(2,2,4), imshow(I2_midway), title('Image 2 midway');
