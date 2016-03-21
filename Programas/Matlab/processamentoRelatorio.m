function [ImagemTratada,posArameTopo,posArameBase,limEsqPoca,limDirPoca,ladoEsqArame,ladoDirArame,pixelsArameBase] = processamento (I, tamanho, filtrar,j)
Threshold1 = 7;
Threshold2 = 26;
Threshold3 = 127;
Isemfiltro=I;
% if filtrar==1 
imwrite(I,colormap(gray(256)),strcat('Relatorio/Figuras/','imagem',int2str(j),'-comum.jpg'));
  %% Retirar scanlines
  a = I > Threshold1;
  %c = cast(a,'uint8');
  I = single(I).*a;
  imwrite(I,colormap(gray(256)),strcat('Relatorio/Figuras/','imagem',int2str(j),'-',int2str(j+2),'-threshold1.jpg'));
  
%   title('Primeira Binarização');

  %% Filtro de gaussiana
  H = fspecial('gaussian',3);
  I = imfilter(I,H,'replicate');
  imwrite(I,colormap(gray(256)),strcat('Relatorio/Figuras/','imagem',int2str(j),'-',int2str(j+2),'-filtro-gaussiana.jpg'));
  %   title('Filtro de gaussiana');
% end

%% Binarizacao
B  = I > Threshold2;
I2 = I.*B;
ImagemTratada = min(I2,Threshold3);
imwrite(I,colormap(gray(256)),strcat('Relatorio/Figuras/','imagem',int2str(j),'-',int2str(j+2),'-threshold23.jpg'));
% title('Segunda Binarização');

% figure;image(ImagemTratada);colormap(gray(256));axis image;
% title(j)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Limites verticais do arame

% perfil horizontal, de cima para baixo
% Usar ImagemTratada
somaHor     = sum(ImagemTratada,2);
derivadaHor = diff(somaHor);

% limiares tamanhos uteis
meioVert = floor(tamanho(1)/2);
meioHor =  floor(tamanho(2)/2);

% limites verticais do arame
[M,posArameTopo] = max(derivadaHor(1:1:meioVert-1));
[M,posArameBase] = max(derivadaHor(meioVert:1:tamanho(1)-1));
posArameBase     = posArameBase + meioVert;



%%
% limites horizontais do arame
% perfil vertical, da esquerda para a direita
% Usar B
somaVert     = sum(B,1);
derivadaVert = diff(somaVert);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Borda esquerda da poca
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[M, limEsqPoca] = max(derivadaVert(1:1:meioHor));

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Borda direita da poca
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[M, limDirPoca] = min(derivadaVert(meioHor:1:tamanho(2)-1));
limDirPoca = limDirPoca + meioHor;



%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Laterais do arame, inicioArame (esquerda) e fimArame (direita)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
afastamento1 = floor(0.01*tamanho(1));
afastamento2 = floor(0.01*tamanho(1));
n = posArameBase - posArameTopo - afastamento1 - afastamento2; % Usar n valor menor (como n = 15) para diminuir processamento
intervalo = 1;% correcao caso se diminua valor de n(posArameBase - posArameTopo - afastamento1 - afastamento2)/(n-1)
inicioArame = zeros(n,1);
fimArame = zeros(n,1);
derivadaArame = zeros(n,tamanho(2)-1);
for i = 1:1:n+1
    derivadaArame(i,:) = diff(ImagemTratada(posArameTopo + afastamento1 + round(intervalo*(i-1)),:));
    [M, inicioArame(i)] = min(derivadaArame(i,floor(meioHor/2):1:meioHor));
    inicioArame(i) = inicioArame(i) + floor(meioHor/2);
    [M, fimArame(i)] = max(derivadaArame(i,meioHor:1:tamanho(2)-1));
    fimArame(i) = fimArame(i) + meioHor;
end
% X = size(posArameTopo+afastamento1:intervalo:posArameBase-afastamento2)
% Y = size(inicioArame)

ladoEsqArame = robustfit(posArameTopo+afastamento1:intervalo:posArameBase-afastamento2,inicioArame);
ladoDirArame = robustfit(posArameTopo+afastamento1:intervalo:posArameBase-afastamento2,fimArame);

%% calculo de cantos sem usar regressao (abandonado pois era muito suscetivel a ruidos)
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

%% calculo de cantos com regressao (funcionou muito melhor com a regressao robusta)
pixelsArameBase = (ladoDirArame(2)*posArameBase + ladoDirArame(1)) - (ladoEsqArame(2)*posArameBase + ladoEsqArame(1));

% if ((pixelsArameBase < 85) || (pixelsArameBase > 105)) && tamanho(1) > 1000
  
%   % impressão de imagem corrigida
  figure;image(ImagemTratada);colormap(gray(256));axis image;
  set(gca,'LooseInset',get(gca,'TightInset'));
%   title('Imagem com medidas');
  hold on;
  %bordas laterais
  plot(ones(1,tamanho(1))*limEsqPoca,1:1:tamanho(1),'--y',ones(1,tamanho(1))*limDirPoca,1:1:tamanho(1),'--y','LineWidth',2)
  %lados esquerdo e direito do arame
  plot([posArameTopo*ladoEsqArame(2)+ladoEsqArame(1) posArameBase*ladoEsqArame(2)+ladoEsqArame(1)],[posArameTopo posArameBase],'b')
  plot([posArameTopo*ladoDirArame(2)+ladoDirArame(1) posArameBase*ladoDirArame(2)+ladoDirArame(1)],[posArameTopo posArameBase],'b')
  %topo e base do arame
  plot(1:1:tamanho(2),ones(tamanho(2))*posArameTopo,'b','LineWidth',2);
  plot(1:1:tamanho(2),ones(tamanho(2))*posArameBase,'b','LineWidth',2);
  plot(inicioArame,posArameTopo+afastamento1:1:posArameBase-afastamento2,'r');
  plot(fimArame,posArameTopo+afastamento1:1:posArameBase-afastamento2,'g');
% end

%%
% calcular angulo da camera em relacao ao arame
%  x  da imagem corresponde a primeira dimensao (cima->baixo)
%  y  da imagem corresponde a segunda dimensao  (esq->dir)
%  z  da imagem nao sera utilizado
%  X  real corresponde a direcao do arame
%  Y  real corresponde a direcao perpendicular ao cordao de 
%     solda e ao arame (esq->dir)
%  Z  corresponde a direcao do cordao de solda




