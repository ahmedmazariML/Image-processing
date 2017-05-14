%% Generate observed image
clear all;
close all;
I=double(imread('flowers.bmp'))/255;
I=mean(I,3);
sizeI=size(I);
u=I+0.1*randn(sizeI);

subplot(2,2,3); imshow(u);title('Noisy observed image');
subplot(2,2,4); imhist(u);title('Histogram of noisy image');
subplot(2,2,1); imshow(I);title('Original observed image');
subplot(2,2,2); imhist(I);title('Histogram of original image');
% Denoise
w=3;
sigma_s=1;
sigma_i=2;
[N,M,d]=size(u);


%% Bilateral filtering.

S=zeros(2*w+1,2*w+1);
u_chapeau=zeros(2*w+1,2*w+1);
P=zeros(2*w+1,2*w+1);
I_denoised=u;

%% matrix S
for i1=1:2*w+1
  for i2=1:2*w+1
    S(i1,i2)=exp(-((i1-w-1)^2+(i2-w-1)^2)/(2*sigma_s^2));
  end
end

for p1=1+w:N-w
  for p2=1+w:M-w
      u_chapeau=u(p1-w:p1+w,p2-w:p2+w);
      P=S.*exp(-(u_chapeau.-u_chapeau(w+1,w+1)).^2/(2*sigma_i^2));
      C=sum(sum(P));
      P=P.*u_chapeau;
      I_denoised(p1,p2)=sum(sum(P))/C;  
  end
end

figure;
subplot(1,2,1); imshow(u);title('Noisy observed image');
subplot(1,2,2);imshow(I_denoised);title('Denoised image');
