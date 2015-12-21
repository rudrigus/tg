% teste de algoritmos de borda

%J = edge(I,'sobel',.035); % com filtro de mediana 3
%J = edge(I,'canny',[.25 .03]);

clc
%clear


cd d:/trabaio/TG
%I = imread('./Imagens/Teste/ImagemTeste4.jpg');
BW = rgb2gray(I);

% retirar informacoes desnecessarias para o calculo da matriz de
% transformacao
% a = cast(BW>100,'uint8');
% BW = I.*a;

% filtro de mediana
H = fspecial('average',3);
BW = imfilter(BW,H,'replicate');


% Encontrar bordas
figure;
BW = edge(BW,'sobel',.035);
% imshow(BW)



% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');