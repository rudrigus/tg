%%Exemplo de processamento de imagem
% Levenberg Marquardt

clear;
clc;
close all;
 
%%
%%Carregar imagens
cd ~/UNB/TG
Diretorio_leitura = './Imagens/Capturas/1000 fps/Resultados Filtro Adaptativo/';
Diretorio_escrita = './Img_alteradas/';
inicio = 150;
fim    = 153;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Media de imagens para reduzir ruidos
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
    I = mean(Im,3);
    
    % processamento eh chamado para calcular valores
    [ImagemTratada,posArameTopo,posArameBase,limEsqPoca(j-inicio+1),limDirPoca(j-inicio+1),ladoEsqArame,ladoDirArame] = processamento(I,tamanho,1);
    
%     hold on;
%     plot(1:1:tamanho(2),posArameTopo,'--r',1:1:tamanho(2),posArameBase,'--r',limEsqPoca(j-inicio+1),1:1:tamanho(1),'--y',limDirPoca(j-inicio+1),1:1:tamanho(1),'--y');
%     plot([posArameTopo*ladoEsqArame(2)+ladoEsqArame(1) tamanho(1)*ladoEsqArame(2)+ladoEsqArame(1)],[posArameTopo tamanho(1)],'r')
%     plot([posArameTopo*ladoDirArame(2)+ladoDirArame(1) tamanho(1)*ladoDirArame(2)+ladoDirArame(1)],[posArameTopo tamanho(1)],'r')
%     hold off
end

%%
% mostrar imagem com medidas
figure;image(ImagemTratada);colormap(gray(256))
hold on;
%bordas laterais
plot(ones(1,tamanho(1))*limEsqPoca(fim-inicio+1),1:1:tamanho(1),'--y',ones(1,tamanho(1))*limDirPoca(fim-inicio+1),1:1:tamanho(1),'--y')
%lados esquerdo e direito do arame
plot([posArameTopo*ladoEsqArame(2)+ladoEsqArame(1) posArameBase*ladoEsqArame(2)+ladoEsqArame(1)],[posArameTopo posArameBase],'r')
plot([posArameTopo*ladoDirArame(2)+ladoDirArame(1) posArameBase*ladoDirArame(2)+ladoDirArame(1)],[posArameTopo posArameBase],'r')
%topo e base do arame
plot(1:1:tamanho(2),ones(tamanho(2))*posArameTopo,'b');
plot(1:1:tamanho(2),ones(tamanho(2))*posArameBase,'b');


%% Correcao de valores com distorcao de perspectiva
% O que estamos buscando aqui é a matriz de transformação gerada a partir
% da imagem.
% Medidas reais do arame: h=10,25mm r=0,5mm (d=1mm)
X=[100; 100; 0; 0];
Y=[1025; 0; 0; 1025];

CantosImagem = [posArameBase*ladoDirArame(2)+ladoDirArame(1) posArameBase; ...
         posArameTopo*ladoDirArame(2)+ladoDirArame(1) posArameTopo; ...
         posArameTopo*ladoEsqArame(2)+ladoEsqArame(1) posArameTopo; ...
         posArameBase*ladoEsqArame(2)+ladoEsqArame(1) posArameBase];
        
x = CantosImagem(:,1);
y = CantosImagem(:,2);

%Calculo da transformada
B = [ x y ones(size(X)) zeros(4,3)        -x.*X -y.*X ...
      zeros(4,3)        x y ones(size(X)) -x.*Y -y.*Y ];
B = reshape (B', 8 , 8 )';
D = [ X , Y ];
D = reshape (D', 8 , 1 );
l = inv(B) * D;
% A = reshape([l(1:6)' 0 0 1 ],3,3)';
% C = [l(7:8)' 1];


% Imagem corrigida

A = reshape([l(1:8)' 1 ],3,3)';
tform = maketform('projective',A');
I2 = imtransform(I,tform,'XYScale',1);
% image(I2);colormap(gray(256))
tamanho2 = size(I2);

[I2,posArameTopo,posArameBase,limEsqPoca(j-inicio+1),limDirPoca(j-inicio+1),ladoEsqArame,ladoDirArame] = processamento(I2,tamanho2,0);


figure;image(I2);colormap(gray(256))
hold on;
%bordas laterais
plot(ones(1,tamanho2(1))*limEsqPoca(fim-inicio+1),1:1:tamanho2(1),'--y',ones(1,tamanho2(1))*limDirPoca(fim-inicio+1),1:1:tamanho2(1),'--y')
%lados esquerdo e direito do arame
plot([posArameTopo*ladoEsqArame(2)+ladoEsqArame(1) posArameBase*ladoEsqArame(2)+ladoEsqArame(1)],[posArameTopo posArameBase],'r')
plot([posArameTopo*ladoDirArame(2)+ladoDirArame(1) posArameBase*ladoDirArame(2)+ladoDirArame(1)],[posArameTopo posArameBase],'r')
%topo e base do arame
plot(1:1:tamanho2(2),ones(tamanho2(2))*posArameTopo,'b');
plot(1:1:tamanho2(2),ones(tamanho2(2))*posArameBase,'b');


%%
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