function [ImageBoost, ImageDim ] = rehaussement(Image, proportion)

% Convertir l'image de RGB en HSV
HSV = rgb2hsv(Image);
ImageBoost=HSV;
ImageDim=HSV;

% Pour le boost, réhausser S avec la proportion
HSV_boost= HSV(:,:,2)+ proportion * HSV(:,:,2);
% Si une valeur est superieure ) à 1 on la met au maximum qui est 1
HSV_boost(HSV_boost>1)=1;
ImageBoost(:,:,2)=HSV_boost;
ImageBoost=hsv2rgb(ImageBoost); %conversion inverse

% Pour la diminution, on retranche la proportion de S
HSV_dim= HSV(:,:,2)- proportion * HSV(:,:,2);
ImageDim(:,:,2)=HSV_dim;
ImageDim=hsv2rgb(ImageDim); %converstion inverse






