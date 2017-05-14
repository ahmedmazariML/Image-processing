function zoomed_image = zoom_out(imgOriginal, zf)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Zoom_out: effectue un zoom arrière de l'image
%     imgOriginal :image à zoomer
%     zf: facteur de zoom
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[M,N,d]=size(imgOriginal);
% Une image est crée de zf fois plus petite que l'image originale
zoomed_image=zeros(floor(M/zf),floor(N/zf),d);
[Mz,Nz,d]=size(zoomed_image);

i=1;
j=1;
% Un sous echantillonage est effectué en ne gardant qu'un pixel tous les zf pixel dans les deux dimensions
for iz=1:Mz
  for jz=1:Nz
    zoomed_image(iz,jz,:)=imgOriginal(i,j,:);
    j=j+zf;
end
j=1;
i=i+zf;
end
