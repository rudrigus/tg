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
quantidadeImagens = 3;
ImTemp = imread(strcat(Diretorio_leitura,'Img',int2str(inicio),'.bmp'));
tamanho = size(ImTemp);
Im = zeros(tamanho(1),tamanho(2),quantidadeImagens);


    imagemInicial = inicio;
    for i = 1:1:quantidadeImagens
        Im(:,:,i) = imread(strcat(Diretorio_leitura,'Img',int2str(imagemInicial-i+1),'.bmp'));
    end
    
    I = Mean(Im,3);
    
    
    %[ImagemTratada,posArameTopo,posArameBase,limEsqPoca(j-inicio+1),limDirPoca(j-inicio+1),ladoEsqArame,ladoDirArame] = processamento(I,tamanho);
    

%%Retirar scanlines
a = I>10;
%c = cast(a,'uint8');
I = I.*a;
%image(I);colormap(gray(256));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Encontrar posicao do arame (algoritmo 3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% filtro de mediana
H = fspecial('average',3);
I2 = imfilter(I,H,'replicate');
%I2=I;

a  = I2>20;
I2 = I2.*a;

ImagemTratada = I2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% limites verticais do arame

% perfil horizontal, de cima para baixo
somaHor     = sum(a,2);
derivadaHor = diff(somaHor);

% limiar entre inicio e final do arame
limiar1 = 125;
% limites verticais do arame
[M,posArameTopo] = max(derivadaHor(1:1:limiar1-1));
[M,posArameBase] = max(derivadaHor(limiar1:1:tamanho(1)-1));
posArameBase     = posArameBase + limiar1;


%%
% limites horizontais do arame
% perfil vertical, da esquerda para a direita
somaVert     = sum(a,1);
derivadaVert = diff(somaVert);



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Borda esquerda da poça
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[M, limEsqPoca] = max(derivadaVert(1:1:tamanho(2)/2));

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Laterais do arame, inicioArame (esquerda) e fimArame (direita)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
afastamento1 = 5;
n=15;
intervalo = (posArameBase - posArameTopo - afastamento1*2)/(n-1);
inicioArame = zeros(n,1);
fimArame = zeros(n,1);
derivadaArame = zeros(n,tamanho(2)-1);
for i = 1:1:n
    derivadaArame(i,:) = diff(a(posArameTopo + afastamento1 + round(intervalo*(i-1)),:));
    [M,inicioArame(i)] = min(derivadaArame(i,:));
    [M fimArame(i)] = max(derivadaArame(i,inicioArame(i):1:tamanho(2)-1));
    fimArame(i) = fimArame(i) + inicioArame(i);
end

ladoEsqArame = robustfit(posArameTopo+afastamento1:intervalo:posArameBase-afastamento1,inicioArame);
ladoDirArame = robustfit(posArameTopo+afastamento1:intervalo:posArameBase-afastamento1,fimArame);


% % topo
% derivadaArameTopo = diff(a(posArameTopo+afastamento1,:));
% [M,inicioArameTopo] = min(derivadaArameTopo);
% [M fimArameTopo] = max(derivadaArameTopo(inicioArameTopo:1:tamanho(2)-1));
% fimArameTopo = fimArameTopo + inicioArameTopo;
% 
% % Base
% derivadaArameBase = diff(a(posArameBase-afastamento1,:));
% [M,inicioArameBase] = min(derivadaArameBase);
% [M fimArameBase] = max(derivadaArameBase(inicioArameBase:1:tamanho(2)-1));
% fimArameBase = fimArameBase + inicioArameBase;
% 
% % calculo do desvio angular do arame
% centroTopo = (inicioArameTopo + fimArameTopo)/2;
% centroBase = (inicioArameBase + fimArameBase)/2;

centroTopo = (ladoEsqArame(2)*posArameTopo + ladoEsqArame(1) + ladoDirArame(2)*posArameTopo + ladoDirArame(1))/2;
centroBase = (ladoEsqArame(2)*posArameBase + ladoEsqArame(1) + ladoDirArame(2)*posArameBase + ladoDirArame(1))/2;
pixelsArameBase = (ladoDirArame(2)*posArameBase + ladoDirArame(1)) - (ladoEsqArame(2)*posArameBase + ladoEsqArame(1));


anguloDesvio = atan((centroTopo-centroBase)/(posArameTopo-posArameBase));
anguloDesvio = anguloDesvio*180/pi;

%%
% calcular angulo da camera em relacao ao arame
%  x  da imagem corresponde a primeira dimensao (cima->baixo)
%  y  da imagem corresponde a segunda dimensao  (esq->dir)
%  z  da imagem nao sera utilizado
%  X  real corresponde a direcao do arame
%  Y  real corresponde a direcao perpendicular ao cordao de 
%     solda e ao arame (esq->dir)
%  Z  corresponde a direcao do cordao de solda


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Borda direita da poça
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[M, limDirPoca] = min(derivadaVert(tamanho(2)/2:1:tamanho(2)-1));
limDirPoca = limDirPoca + centroBase;


%%
%mostrar imagem com medidas
figure;image(ImagemTratada);colormap(gray(256))
hold on;
% plot(1:1:tamanho(2),posArameTopo,'--r',1:1:tamanho(2),posArameBase,'--r',[inicioArameTopo,fimArameTopo],posArameTopo,'+g',[inicioArameBase,fimArameBase],posArameBase,'+g',[centroBase centroTopo],[posArameBase posArameTopo],'b',limEsqPoca,1:1:tamanho(1),'--y',limDirPoca,1:1:tamanho(1),'--y');
plot(1:1:tamanho(2),posArameTopo,'--r',1:1:tamanho(2),posArameBase,'--r',limEsqPoca,1:1:tamanho(1),'--y',limDirPoca,1:1:tamanho(1),'--y');
%plot(inicioArame,posArameTopo:intervalo:posArameTopo+intervalo*(n-1),fimArame,posArameTopo:intervalo:posArameTopo+intervalo*(n-1));
plot([posArameTopo*ladoEsqArame(2)+ladoEsqArame(1), tamanho(1)*ladoEsqArame(2)+ladoEsqArame(1)],[posArameTopo tamanho(1)],'r')
plot([posArameTopo*ladoDirArame(2)+ladoDirArame(1), tamanho(1)*ladoDirArame(2)+ladoDirArame(1)],[posArameTopo tamanho(1)],'r')



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