function imgRotated3 = rotate_image(I, degree)
[M,N]=size(I);
subplot(2,2,1);
imshow(I);
%si degree n'est pas entre -90° et 90° on renverse l'image
while(degree>=90)
  degree=degree-90;
  I=rot90(I,-1);

end;

while(degree<=(-90))
  degree=degree+90;
  I=rot90(I,1);
end;
if(degree==0)
  imgRotated3=I;
  subplot(2,2,2);
  imshow(I);
else
  %Transformation en radian
  theta=(degree/360)*2*pi;

  %constantes
  sin_theta=sin(theta);
  tan_theta2=-tan(theta/2);

  facteur2N=(-2*i*pi/(2*N));
  facteur2M=(-2*i*pi/(2*M));

  %redimenssioner l'image 
  Igrande=zeros(2*M,2*N);
  Igrande((M/2+1):(M/2+M),(N/2+1):(N/2+N))=I;


  %les centres de l'image afin de faire une rotation par le centre 
  mcenter = (2*M/2)-1;
  ncenter = (2*N/2)-1;



  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1ere phase %%%%%%%%%%%%%%%%%%%%%%%%
  %                        |m1| = | 1  -tan(theta/2) ||m|
  %                        |n1| = | 0        1       ||n|

  % TFD à 1 dimension sur les lignes
  tfd =  fft(Igrande, 2*N, 2); 

  for k=1:N
    for l=1:2*M
        phase(l,k)=exp(facteur2N*(l-1-mcenter)*tan_theta2*(k-1));
    end
  end;
  for k=N+1:2*N
    for l=1:2*M
        phase(l,k)=exp(facteur2N*(l-1-mcenter)*tan_theta2*(k-1-2*N));
    end;
  end;

  trans = tfd.*phase;

  % TFD inverse sur les lignes 
  rotatedImg1=ifft(trans, 2*N, 2);

  %Résulat: image étirée sur l'axe des x
  imgRotated1=real(rotatedImg1);
  subplot(2,2,2);
  imshow(imgRotated1);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2eme phase %%%%%%%%%%%%%%%%%%%%%%%%
  %                        |m2| = | 1           0    ||m1|
  %                        |n2| = | sin(theta)  1    ||n1|

  % TFD à 1 dimension sur les colonnes

  tfd =  fft(imgRotated1, 2*M, 1);

  for l=1:M
    for k=1:2*N
        phase(l,k)=exp(facteur2M*(k-1-ncenter)*sin_theta*(l-1));
    end
  end;
  for l=M+1:2*M
    for k=1:2*N
        phase(l,k)=exp(facteur2M*(k-1-ncenter)*sin_theta*(l-1-2*M));
    end;
  end;

  trans = tfd.*phase;
  % TFD inverse sur les colonnes
  rotatedImg2=ifft(trans, 2*M, 1);

  %Résulat: image étirée sur l'axe des y
  imgRotated2=real(rotatedImg2);
  subplot(2,2,3);
  imshow(imgRotated2);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3eme phase %%%%%%%%%%%%%%%%%%%%%%%%
  %                        |m3| = | 1  -tan(theta/2) ||m2|
  %                        |n3| = | 0        1       ||n2|


  % TFD à 1 dimension sur les lignes
  tfd1 =  fft(imgRotated2, 2*N, 2);

  for k=1:N
    for l=1:2*M
        phase1(l,k)=exp(facteur2N*(l-1-mcenter)*tan_theta2*(k-1));
    end
  end;
  for k=N+1:2*N
    for l=1:2*M
        phase1(l,k)=exp(facteur2N*(l-1-mcenter)*tan_theta2*(k-1-2*N));
    end;
  end;

  trans1 = tfd1.*phase1;

  % TFD inverse à 1 dimension sur les lignes
  rotatedImg3=ifft(trans1, 2*N, 2);
  imgRotated3=real(rotatedImg3);
  subplot(2,2,4);
  %résultat final
  imshow(imgRotated3);
end;
