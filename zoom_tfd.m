function imgZoomed = zoom_tfd(imgOriginal, factor)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Zoom zéro paddding: 
%     imgOriginal :image à zoomer
%     factor: facteur de zoom 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Normalisation de l'image
imgOriginal=imgOriginal/255; 

% Nous obtenons les dimensions de l'image
% afin de manipuler la matrice TFD
[n,m,d]=size(imgOriginal);
%if mod(n,2)==1 
%  imgOriginal(n+1,:)=zeros(m);
%end
%if mod(m,2)==1 
%  imgOriginal(:,m+1)=zeros(n);
%end
% La transformée de fourier est appliquée à l'image originale
tfd=fft2(imgOriginal);

% Une matrice de zéros est construite d'une taille 
%factor fois la taille de l'image originale
fftzoomed=zeros(n*factor, m*factor);

%Les dimensions de l'image zoomée
[N,M,D]=size(fftzoomed);

% Pour chaque canal couleur, nous divisons l'image en quatre cadrans
% chaque cadran sera placé à une extremité (coin) 
% de l'image zoomée
incrx=0;
incry=0;
if(mod(N,2)==0)
  incry=1;
end
if(mod(M,2)==0)
  incrx=1;
end

for i=1:3
  fftzoomed(1:floor(n/2),1:floor(m/2),i)=tfd(1:floor(n/2),1:floor(m/2),i); %haut gauche
  fftzoomed(1:floor(n/2),M-floor(m/2)+incry:M,i)=tfd(1:floor(n/2),(floor(m/2))+1:m,i); %haut droite
  fftzoomed(N-floor(n/2)+incrx:N,1:floor(m/2),i)=tfd((floor(n/2))+1:n,1:floor(m/2),i); %bas gauche
  fftzoomed(N-floor(n/2)+incrx:N,M-floor(m/2)+incry:M,i)=tfd((floor(n/2))+1:n,(floor(m/2))+1:m,i); %bas droite
end

% La transformée de fourier discrète inverse est appliquée
zoomed=ifft2(fftzoomed);

% la partie réele est prise et multipliée deux fois par le facteur de zoom
% pour retrouver la constante de normalisaton 1/n*m
imgZoomed=real(zoomed)*factor^2;
