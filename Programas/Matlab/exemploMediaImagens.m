%%Exemplo de processamento de imagem

clear;
clc;
close all;

%%
%%Carregar imagens
cd d:/trabaio/TG
Diretorio_leitura = './Tese_Luciano/Videos/sincronizada/1000 fps/Resultados Filtro Adaptativo/';
Diretorio_escrita = './Img_alteradas/';
inicio = 150;
fim    = 200;
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Média de imagens para reduzir ruídos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
quantidadeImagens = 2;
ImTemp = imread(strcat(Diretorio_leitura,'Img',int2str(inicio),'.bmp'));
tamanho = size(ImTemp);
Im = zeros(tamanho(1),tamanho(2),quantidadeImagens);

figure;
ylabel('y')
    imagemInicial = inicio;
    for i = 1:1:quantidadeImagens
        Im(:,:,i) = imread(strcat(Diretorio_leitura,'Img',int2str(imagemInicial-i+1),'.bmp'));
        subplot(1,quantidadeImagens+1,quantidadeImagens - i + 1)
        image(Im(:,:,i));colormap(gray(256))
        title(strcat('Imagem  ', int2str(quantidadeImagens - i + 1)))
        set(gca, 'YTick', []);
        set(gca, 'XTick', []);
        
    end
    %Im(:,:,quantidadeImagens) = ImTemp;
    I = Mean(Im,3);
subplot(1,quantidadeImagens + 1,quantidadeImagens+1)
image(I);colormap(gray(256))
title('Imagem média')
set(gca, 'YTick', []);
set(gca, 'XTick', []);
