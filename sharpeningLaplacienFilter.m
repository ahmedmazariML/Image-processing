function imgSharpened = sharpeningLaplacienFilter(imgOriginal, itter)



imgCopy = imgOriginal;

%Preallocate the matrices with zeros
F1=[0 1 0;1 -4 1; 0 1 0];
F2=[1 1 1;1 -8 1; 1 1 1];

I = conv2(imgOriginal,F1,'same');
I = uint8(I);
for i=1:itter
  
  B = imgOriginal -0.1*I;
  imgOriginal = B;
end;

figure,imshow(imgCopy);title('Original Image');
figure,imshow(imgOriginal);title('Sharpened Image');

imgSharpened = real(imgOriginal);
