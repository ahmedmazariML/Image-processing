function imgFiltred = wiener_filter(I_noisy,I, sigma, sigma_b)

[M,N,d]=size(I_noisy);


Nr = ifftshift((-fix(M/2):ceil(M/2)-1));
Nc = ifftshift((-fix(N/2):ceil(N/2)-1));
[Nc,Nr] = meshgrid(Nr,Nc);

% TFD de l'image bruitée
tfd_bruitee=fft2(I_noisy);

% TFD de la gaussienne
H=repmat(exp(-2*pi^2*sigma^2.*((Nc/M).^2+(Nr/N).^2)),[1,1,d]);

% puissances des signaux bruit et image originale
Sb=sigma_b^2;
Sx=abs(fft2(I))^2;  

%formule du filtre de wiener 
W = conj(H)./(abs(H)^2 + Sb./Sx);

%on multiplie les TFD
X=W.*tfd_bruitee;

%Transformée de fourrier inverse
imgFiltred=real(ifft2(X));
