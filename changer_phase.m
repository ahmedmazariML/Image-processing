function [Image1out, Image2out ] = changer_phase(Image1, Image2)

% Transformée de fourier des images en entrée, les images doivent etre de même taille
tfd1=fft2(Image1);
tfd2=fft2(Image2);

%Echanger les phases des deux images
Image1out = abs(tfd1) .* exp(j*arg(tfd2));
Image2out = abs(tfd2) .* exp(j*arg(tfd1));

% Prendre la partie réelle
Image1out = real(ifft2(Image1out));
Image2out = real(ifft2(Image2out));


