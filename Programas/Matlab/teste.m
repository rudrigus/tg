close all;
clc;

cd d:/trabaio/TG
Diretorio_leitura = './Tese_Luciano/Videos/sincronizada/1000 fps/Resultados Filtro Adaptativo/';



% rgbImage = imread(strcat(Diretorio_leitura,'Img220.bmp')); 
% [rows columns numberOfColorBands] = size(rgbImage); 
% subplot(3, 2, 1); 
% imshow(rgbImage, []); 
% title('Original color Image'); 
% set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.

%STEP 2

%---------------------------------------------------Convert rgb image to grayscale-----------------------------------------

% grayImage = rgb2gray(rgbImage); 
grayImage = imread(strcat(Diretorio_leitura,'Img220.bmp')); 

a = grayImage>10;
c = cast(a,'uint8');
grayImage = grayImage.*c;


subplot(3, 2, 2); 
imshow(grayImage, []); 
title('Converted to gray scale');

%STEP 3

%------------------------------------------------------Detection of edge by canny-------------------------------------------------------

cannyImage = edge(grayImage,'canny'); 
subplot(3, 2, 3); 
imshow(cannyImage, []); 
title('Canny Edge Image');

%STEP 4

%-------------------------------------------------------------dilation--------------------------------------------------------

windowSize = 5; 
halfWidth = floor(windowSize/2); 
dilatedImage = zeros(rows, columns); 
for col = (halfWidth+1) : columns - halfWidth 
    x1 = col - halfWidth; 
    x2= col + halfWidth; 
    for row = (halfWidth+1) : rows - halfWidth 
        y1 = row - halfWidth; 
        y2 = row + halfWidth; 
        dilatedImage(row, col) = max(max(cannyImage(y1:y2, x1:x2))); 
    end 
end

%Displaying the dilated image

subplot(3, 2, 4); 
imshow(dilatedImage, []); 
caption = sprintf('Dilated with a window size of %d',windowSize); 
title(caption);

%STEP 5

%------------------------------------------------------------Erosion-------------------------------------------------

windowSize = 5; 
halfWidth = floor(windowSize/2); 
erodedImage = zeros(rows, columns); 
for col = (halfWidth+1) : columns - halfWidth 
    x1 = col - halfWidth; 
    x2= col + halfWidth; 
    for row = (halfWidth+1) : rows - halfWidth 
        y1 = row - halfWidth; 
        y2 = row + halfWidth; 
        erodedImage(row, col) = min(min(dilatedImage(y1:y2, x1:x2))); 
    end 
end

%Displaying eroded image

subplot(3, 2, 5); 
imshow(erodedImage, []); 
caption = sprintf('Eroded image with a window size of %d',windowSize); 
title(caption); 
[B,L] = bwboundaries(grayImage, 'noholes');

STATS = regionprops(L, 'all');

figure, 
imshow(grayImage), 
title('Results'); 

hold on 
for i = 1 : length(STATS) 
  W(i) = uint8(abs(STATS(i).BoundingBox(3)-STATS(i).BoundingBox(4)) < 0.1); 
  W(i) = W(i) + 2 * uint8((STATS(i).Extent - 1) == 0 ); 
  centroid = STATS(i).Centroid; 
  switch W(i) 
      case 1 
          
          plot(centroid(1),centroid(2),'bO'); 
          title('circle'); 
      case 2 
          
          plot(centroid(1),centroid(2),'bX'); 
          title('rectangle'); 
      case 3 
          
          plot(centroid(1),centroid(2),'bS'); 
          title('square'); 
  end 
end 
return