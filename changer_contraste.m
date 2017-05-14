function [ImageOut ] = changer_contraste(Image)

% Nous changeons le contraste à l'aide d'une fonction affine out(x)= ax+b
% Nous changeons la dynamique du signal de [min(Image), max(Image] vers [0,1]

ImageOut=zeros(size(Image));

for i=1:size(Image,3)
i
a=1/(max(max(Image(:,:,i)))-min(min(Image(:,:,i))));
b=-min(min(Image(:,:,i)))/(max(max(Image(:,:,i)))-min(min(Image(:,:,i))));

ImageOut(:,:,i)=a*Image(:,:,i)+b;

end
