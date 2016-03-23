function [ImagemTratada,posArameTopo,posArameBase,limEsqPoca,limDirPoca,ladoEsqArame,ladoDirArame,pixelsArameBase] = processamento (I, tamanho, filtrar,j)
Threshold1 = 7;
Threshold2 = 26;
Threshold3 = 127;
Isemfiltro=I;
if filtrar==1 
% imwrite(I,colormap(gray(256)),strcat('Relatorio/Figuras/','imagem',int2str(j),'-comum.jpg'));
  %% Retirar scanlines
  a = I > Threshold1;
  %c = cast(a,'uint8');
  I = single(I).*a;
%   imwrite(I,colormap(gray(256)),strcat('Relatorio/Figuras/','imagem',int2str(j),'-',int2str(j+2),'-threshold1.jpg'));
  
%   title('Primeira Binarização');

  %% Filtro de gaussiana
  H = fspecial('gaussian',3);
  I = imfilter(I,H,'replicate');
%   imwrite(I,colormap(gray(256)),strcat('Relatorio/Figuras/','imagem',int2str(j),'-',int2str(j+2),'-filtro-gaussiana.jpg'));
  %   title('Filtro de gaussiana');
end

%% Binarizacao
B  = I > Threshold2;
I2 = I.*B;
ImagemTratada = min(I2,Threshold3);
% imwrite(ImagemTratada,colormap(gray(256)),strcat('Relatorio/Figuras/','imagem',int2str(j),'-',int2str(j+2),'-threshold23.jpg'));
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
n = posArameBase - posArameTopo - afastamento1 - afastamento2; % Usar n valor menor (como n = 16) para diminuir processamento
n = 16;
intervalo = 1;% correcao caso se diminua valor de n(posArameBase - posArameTopo - afastamento1 - afastamento2)/(n-1)
intervalo = (posArameBase - posArameTopo - afastamento1 - afastamento2)/(n-1);
inicioArame = zeros(n,1);
fimArame = zeros(n,1);
derivadaArame = zeros(n,tamanho(2)-1);
for i = 1:1:n
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
pixelsArameBase = (posArameBase*ladoDirArame(2)+ladoDirArame(1)) - (posArameBase*ladoEsqArame(2)+ladoEsqArame(1));

% if ((pixelsArameBase < 85) || (pixelsArameBase > 105)) && tamanho(1) > 1000
  
%   % impressão de imagem corrigida
%   figure;image(ImagemTratada);colormap(gray(256));axis image;
%   set(gca,'LooseInset',get(gca,'TightInset'));
% %   title('Imagem com medidas');
%   hold on;
  %bordas laterais
%   b1=plot(ones(1,tamanho(1))*limEsqPoca,1:1:tamanho(1),'--y',ones(1,tamanho(1))*limDirPoca,1:1:tamanho(1),'--y','LineWidth',2);
%   legend(b1,'Bordas da poça');
  %lados esquerdo e direito do arame
%   le1=plot(inicioArame,posArameTopo+afastamento1:intervalo:posArameBase-afastamento2,'g','LineWidth',1.2);
%   ld1=plot(fimArame,posArameTopo+afastamento1:intervalo:posArameBase-afastamento2,'b','LineWidth',1.2);
%   % com regressao

%   le2=plot([posArameTopo*ladoEsqArame(2)+ladoEsqArame(1) posArameBase*ladoEsqArame(2)+ladoEsqArame(1)],[posArameTopo posArameBase],'g','LineWidth',2);
%   ld2=plot([posArameTopo*ladoDirArame(2)+ladoDirArame(1) posArameBase*ladoDirArame(2)+ladoDirArame(1)],[posArameTopo posArameBase],'b','LineWidth',2);
%   legend([le2,ld2],'Borda esquerda do eletrodo','Borda direita do eletrodo');
  %topo e base do arame
%   t1=plot(1:1:tamanho(2),ones(tamanho(2))*posArameTopo,'r','LineWidth',2);
%   b3=plot(1:1:tamanho(2),ones(tamanho(2))*posArameBase,'--r','LineWidth',2);
%   legend(t1,'Topo e base do arame');
  
% legend([b1(1),le2(1),ld2(1),t1(1),b3(1)],'Bordas da poça','Borda esquerda do eletrodo','Borda direita do eletrodo','Topo do eletrodo','Base do eletrodo');

  % PERFIS
  % horizontal
%     ph=plot(somaHor(:,1,1)/(max(somaHor)/tamanho(2)),1:1:tamanho(1),'g','LineWidth',2);
%     pdh=plot(tamanho(2)/2 + derivadaHor(:,1)/(-2*min(derivadaHor)/tamanho(2)),1:1:tamanho(1)-1,'r','LineWidth',1.2);
%     legend([ph,pdh],'Perfil horizontal','Derivada do perfil horizontal');
  % vertical
%     pv=plot(tamanho(1)-somaVert(1,:,1)/(max(somaVert)/tamanho(1)),'g','LineWidth',2);
%     pdv=plot(tamanho(1)/2-derivadaVert(1,:,1)/(-2*min(derivadaVert)/tamanho(1)),'r','LineWidth',1.2);
%     legend([pv,pdv],'Perfil vertical','Derivada do perfil vertical');
%   % arame
%   for i = 1:1:n/4
%     pda=plot((posArameTopo + afastamento1 + round(intervalo*4*(i-1))) - derivadaArame(4*i-3,:)/3,'r','LineWidth',1.2);
%   end
%   legend([le1,ld1,pda],'Borda esquerda do eletrodo','Borda direita do eletrodo','Derivadas horizontais');
  
  
% end


%% apresentar valores
% topobase=[posArameTopo posArameBase]
% topoesquerdo = (posArameTopo*ladoEsqArame(2)+ladoEsqArame(1))
% baseEsquerdo = (posArameBase*ladoEsqArame(2)+ladoEsqArame(1))
% topoDireito = (posArameTopo*ladoDirArame(2)+ladoDirArame(1))
% baseDireito = (posArameBase*ladoDirArame(2)+ladoDirArame(1))
% 
% limEsqPoca = limEsqPoca
% limDirPoca = limDirPoca
% 
% topobasemm=[posArameTopo posArameBase]/pixelsArameBase
% topoesquerdomm = (posArameTopo*ladoEsqArame(2)+ladoEsqArame(1))/pixelsArameBase
% baseEsquerdomm = (posArameBase*ladoEsqArame(2)+ladoEsqArame(1))/pixelsArameBase
% topoDireitomm = (posArameTopo*ladoDirArame(2)+ladoDirArame(1))/pixelsArameBase
% baseDireitomm = (posArameBase*ladoDirArame(2)+ladoDirArame(1))/pixelsArameBase
% 
% limEsqPocamm = limEsqPoca/pixelsArameBase
% limDirPocamm = limDirPoca/pixelsArameBase

