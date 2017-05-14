function imgFiltred = gaussian_deconv(Image, sigma)

[M,N,d]=size(Image);

%Nc et Nr comportent les coordonées dans l'image (x,y) dans l'ordre lu par la machine
Nr = ifftshift((-fix(M/2):ceil(M/2)-1));
Nc = ifftshift((-fix(N/2):ceil(N/2)-1));
[Nc,Nr] = meshgrid(Nr,Nc);

% TFD de l'image d'entrée
tfd=fft2(Image);

% Les valeurs de la TFD sont multipliées par la TFD de la gaussienne
G=repmat(exp(-2*pi^2*sigma^2 .*((Nc/M).^2+(Nr/N).^2)),[1,1,d]);

tfd_image=tfd./G;

%Transformée de fourrier inverse
imgFiltred=real(ifft2(tfd_image));
