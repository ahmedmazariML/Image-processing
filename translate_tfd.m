function imgTrans = translate_tfd(imgOriginal, tau_x, tau_y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Translation en utilisant la transformée de fourier discrète : 
%     imgOriginal :image à zoomer
%     tau_x: taux de translation sur l'axe horizontal
%     taux_y: taux de translation sur l'axe vertical
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Normalisation sur l'intervalle [0,1]
imgOriginal=imgOriginal/255; 

[M,N,d]=size(imgOriginal);

% Appliquer la transformée de fourier discrète 2D
tfd=fft2(imgOriginal);

trans=zeros(M,N);

% Pour chaque canal couleur, nous multiplions la valeur de la TFD de chaque
% pixel par exp(-2i*pi*k/M*tau_y) exp(-2i*pi*l/N*tau_x)
% Nous traitons chaque cadran de la matrice TFD à part 
% Pour les fréquences négatives, l'indexation est inversée 

facteur_k=((-2i*pi)/M)*tau_y;
facteur_l=((-2i*pi)/N)*tau_x;

for c=1:3
  for k=1:floor(M/2)
    for l=1:floor(N/2)
      trans(k,l,c)=tfd(k,l,c)*exp(facteur_k*(k-1))*exp(facteur_l*(l-1));
    end
    for l=floor((N/2))+1:N
      trans(k,l,c)=tfd(k,l,c)*exp(facteur_k*(k-1))*exp(facteur_l*(l-1-N));
    end
  end
  for k=floor(M/2)+1:M
    for l=1:N/2
      trans(k,l,c)=tfd(k,l,c)*exp(facteur_k*(k-1-M))*exp(facteur_l*(l-1));
    end
    for l=floor(N/2)+1:N
      trans(k,l,c)=tfd(k,l,c)*exp(facteur_k*(k-1-M))*exp(facteur_l*(l-1-N));
    end
  end
end

translated=ifft2(trans);

imgTrans=real(translated);
