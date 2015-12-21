%%Exemplo de processamento de imagem
% Levenberg Marquardt

clear;
clc;
close all;
 
%%
%%Carregar imagens
cd d:/trabaio/TG
Diretorio_leitura = './Tese_Luciano/Videos/sincronizada/1000 fps/Resultados Filtro Adaptativo/';
Diretorio_escrita = './Img_alteradas/';
inicio = 150;
fim    = 153;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Média de imagens para reduzir ruídos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
quantidadeImagens = 3;
ImTemp = imread(strcat(Diretorio_leitura,'Img',int2str(inicio),'.bmp'));
tamanho = size(ImTemp);
Im = zeros(tamanho(1),tamanho(2),quantidadeImagens);

for j = inicio:1:fim
    imagemInicial = j;
    for i = 1:1:quantidadeImagens
        Im(:,:,i) = imread(strcat(Diretorio_leitura,'Img',int2str(imagemInicial+i-1),'.bmp'));
    end
    Im(:,:,quantidadeImagens) = ImTemp;
    I = Mean(Im,3);
    
    [ImagemTratada,posArameTopo,posArameBase,limEsqPoca(j-inicio+1),limDirPoca(j-inicio+1),ladoEsqArame,ladoDirArame] = processamento(I,tamanho);
    
%     hold on;
%     plot(1:1:tamanho(2),posArameTopo,'--r',1:1:tamanho(2),posArameBase,'--r',limEsqPoca(j-inicio+1),1:1:tamanho(1),'--y',limDirPoca(j-inicio+1),1:1:tamanho(1),'--y');
%     plot([posArameTopo*ladoEsqArame(2)+ladoEsqArame(1) tamanho(1)*ladoEsqArame(2)+ladoEsqArame(1)],[posArameTopo tamanho(1)],'r')
%     plot([posArameTopo*ladoDirArame(2)+ladoDirArame(1) tamanho(1)*ladoDirArame(2)+ladoDirArame(1)],[posArameTopo tamanho(1)],'r')
%     hold off
end
figure; hold on
plot(inicio:1:fim,limEsqPoca);
plot(inicio:1:fim,limDirPoca);


%%
%mostrar imagem com medidas
figure;image(ImagemTratada);colormap(gray(256))
hold on;
plot(1:1:tamanho(2),posArameTopo,'--r',1:1:tamanho(2),posArameBase,'--r',limEsqPoca(fim-inicio),1:1:tamanho(1),'--y',limDirPoca(fim-inicio),1:1:tamanho(1),'--y');
plot([posArameTopo*ladoEsqArame(2)+ladoEsqArame(1) tamanho(1)*ladoEsqArame(2)+ladoEsqArame(1)],[posArameTopo tamanho(1)],'r')
plot([posArameTopo*ladoDirArame(2)+ladoDirArame(1) tamanho(1)*ladoDirArame(2)+ladoDirArame(1)],[posArameTopo tamanho(1)],'r')



% figure;plot([inicioArameTopo,fimArameTopo],posArameTopo);
%%perfil horizontal
%figure;plot(somaHor,1:1:tamanho(1),derivadaHor,1:1:tamanho(1)-1);

%set(gca,'YDir','reverse')


% J = imadjust(I,[.15 .5],[.00 .99]);
% imshow(I);
% figure;imshow(J);
% H = fspecial('average',3);
% K = imfilter(I,H,'replicate');
% figure;imshow(K);