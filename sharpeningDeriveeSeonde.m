function imgSharpened = sharpeningDeriveeSeonde(imgOriginal, iter, epsilon)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sharpening: effectue un sharpening de l'image avec le laplacien
% iter: nombre d'itération
% epsilon: poucentage de soustraction du laplacien à chaque iteration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

imgCopy = imgOriginal;

for i=1:iter
  % A chaque itération, on calcule 2 fois le gradient en x puis 2 fois le gradient en y
  grad_x =imgOriginal(1:end-1,:,:)-imgOriginal(2:end,:,:);
  grad_xx = grad_x(1:end-1,:,:)-grad_x(2:end,:,:);
  grad_y = imgOriginal(:,1:end-1,:)-imgOriginal(:,2:end,:);
  grad_yy = grad_y(:,1:end-1,:)-grad_y(:,2:end,:);
  % Faire la somme des deux gradient, 
  p = grad_xx(1:end,1:end-2,:)+grad_yy(1:end-2,1:end,:);
  B = imgOriginal(1:end-2,1:end-2,:);
  % soustraire à l'image son laplacien*epsilon
  B = B - epsilon*p;
  imgOriginal = B;
end;

figure,imshow(imgCopy);title('Original Image');
figure,imshow(B);title('Sharpened Image');

imgSharpened = real(B);

