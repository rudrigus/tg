%%Exemplo de processamento de imagem
% Levenberg Marquardt

clear;
clc;
close all;

%% Config iniciais
% diretorios imagens
cd ~/UNB/TG
Diretorio_leitura = './Imagens/Capturas/1000 fps/Resultados Filtro Adaptativo/';
Diretorio_escrita = './Img_alteradas/';
% inicio = 150;
% fim    = 153;
inicio = 440;
fim    = 440;

% parametros
diametroArame = 1;
% Medidas reais do arame: h=10,25mm r=0,5mm (d=1mm)
% X=[100; 100; 0; 0];
% Y=[1025; 0; 0; 1025];
X=[250; 250; 150; 150];
Y=[1185; 160; 160; 1185];


%% Imagem base para calibracao
ImagemBase = './Imagens/Capturas/1000 fps/Resultados Filtro Adaptativo/Img440.bmp';
I = imread(ImagemBase);
tamanho = size(I);
% [ImagemTratada,posArameTopo,posArameBase,limEsqPoca,limDirPoca,ladoEsqArame,ladoDirArame,pixelsArameBase] = processamentoRelatorio(I,tamanho,1,440);


%% Correcao de valores com distorcao de perspectiva
% O que estamos buscando aqui é a matriz de transformação gerada a partir da imagem.
% CantosImagem = [posArameBase*ladoDirArame(2)+ladoDirArame(1) posArameBase; ...
%          posArameTopo*ladoDirArame(2)+ladoDirArame(1) posArameTopo; ...
%          posArameTopo*ladoEsqArame(2)+ladoEsqArame(1) posArameTopo; ...
%          posArameBase*ladoEsqArame(2)+ladoEsqArame(1) posArameBase];
%         
% x = CantosImagem(:,1);
% y = CantosImagem(:,2);
% 
% %Calculo da transformada
% B = [ x y ones(size(X)) zeros(4,3)        -x.*X -y.*X ...
%       zeros(4,3)        x y ones(size(X)) -x.*Y -y.*Y ];
% B = reshape (B', 8 , 8 )';
% D = [ X , Y ];
% D = reshape (D', 8 , 1 );
% l = inv(B) * D;
% % A = reshape([l(1:6)' 0 0 1 ],3,3)';
% % C = [l(7:8)' 1];
% 
% % matriz de transformada A
% A = reshape([l(1:8)' 1 ],3,3)'
% tform = maketform('projective',A');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Processamento das imagens
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Media de imagens para reduzir ruidos

quantidadeImagens = 3; 
ImTemp = imread(strcat(Diretorio_leitura,'Img',int2str(inicio),'.bmp'));
tamanho = size(ImTemp);
Im = zeros(tamanho(1),tamanho(2),quantidadeImagens);
LarguraPoca = zeros(fim-inicio+1,1);
limEsqPoca = zeros(fim-inicio+1,1);
limDirPoca = zeros(fim-inicio+1,1);
pixelsArameBase = zeros(fim-inicio+1,1);
posArameTopo = zeros(fim-inicio+1,1);
posArameBase = zeros(fim-inicio+1,1);
CentroArameTopo = zeros(fim-inicio+1,1);
CentroArameBase = zeros(fim-inicio+1,1);
% AnguloDesvio = zeros(fim-inicio+1,1);

for j = inicio:1:fim
  imagemInicial = j;
  for i = 1:1:quantidadeImagens
      Im(:,:,i) = imread(strcat(Diretorio_leitura,'Img',int2str(imagemInicial+i-1),'.bmp'));
  end
  Im(:,:,quantidadeImagens) = ImTemp;
  I = mean(Im,3);

  % % processamentoRelatorio eh chamado para calcular valores
  % [ImagemTratada,posArameTopo,posArameBase,limEsqPoca(j-inicio+1),limDirPoca(j-inicio+1),ladoEsqArame,ladoDirArame,pixelsArameBase(j-inicio+1)] = processamentoRelatorio(I,tamanho,1,j);
    
  %     hold on;
  %     plot(1:1:tamanho(2),posArameTopo,'--r',1:1:tamanho(2),posArameBase,'--r',limEsqPoca(j-inicio+1),1:1:tamanho(1),'--y',limDirPoca(j-inicio+1),1:1:tamanho(1),'--y');
  %     plot([posArameTopo*ladoEsqArame(2)+ladoEsqArame(1) tamanho(1)*ladoEsqArame(2)+ladoEsqArame(1)],[posArameTopo tamanho(1)],'r')
  %     plot([posArameTopo*ladoDirArame(2)+ladoDirArame(1) tamanho(1)*ladoDirArame(2)+ladoDirArame(1)],[posArameTopo tamanho(1)],'r')
  %     hold off
  %end


  %%
  % % mostrar imagem com medidas
  % figure;image(ImagemTratada);colormap(gray(256))
  % title(j)
  % hold on;
  % %bordas laterais
  % plot(ones(1,tamanho(1))*limEsqPoca(j-inicio+1),1:1:tamanho(1),'--y',ones(1,tamanho(1))*limDirPoca(j-inicio+1),1:1:tamanho(1),'--y')
  % %lados esquerdo e direito do arame
  % plot([posArameTopo*ladoEsqArame(2)+ladoEsqArame(1) posArameBase*ladoEsqArame(2)+ladoEsqArame(1)],[posArameTopo posArameBase],'r')
  % plot([posArameTopo*ladoDirArame(2)+ladoDirArame(1) posArameBase*ladoDirArame(2)+ladoDirArame(1)],[posArameTopo posArameBase],'r')
  % %topo e base do arame
  % plot(1:1:tamanho(2),ones(tamanho(2))*posArameTopo,'b');
  % plot(1:1:tamanho(2),ones(tamanho(2))*posArameBase,'b');




  %% Imagem corrigida
  I2=I;
%   I2 = imtransform(I,tform,'XYScale',1);
  % image(I2);colormap(gray(256))
  tamanho2 = size(I2);


  % Obtencao de calculos na imagem corrigida
  [I2,posArameTopo(j-inicio+1),posArameBase(j-inicio+1),limEsqPoca(j-inicio+1),limDirPoca(j-inicio+1),ladoEsqArame,ladoDirArame,pixelsArameBase(j-inicio+1)] = processamentoRelatorio(I2,tamanho2,0,j);
  LarguraPoca(j-inicio+1) = diametroArame * (limDirPoca(j-inicio+1) - limEsqPoca(j-inicio+1))/pixelsArameBase(j-inicio+1);
  CentroArameTopo(j-inicio+1) = (posArameTopo(j-inicio+1)*ladoEsqArame(2)+ladoEsqArame(1) + posArameTopo(j-inicio+1)*ladoDirArame(2)+ladoDirArame(1))/2;
  CentroArameBase(j-inicio+1) = (posArameBase(j-inicio+1)*ladoEsqArame(2)+ladoEsqArame(1) + posArameBase(j-inicio+1)*ladoDirArame(2)+ladoDirArame(1))/2;
  
  
  
  
%   % impressão de imagem corrigida
%   figure;image(I2);colormap(gray(256))
%   title(j)
%   hold on;
%   %bordas laterais
%   plot(ones(1,tamanho2(1))*limEsqPoca(j-inicio+1),1:1:tamanho2(1),'--y',ones(1,tamanho2(1))*limDirPoca(j-inicio+1),1:1:tamanho2(1),'--y')
%   %lados esquerdo e direito do arame
%   plot([posArameTopo*ladoEsqArame(2)+ladoEsqArame(1) posArameBase*ladoEsqArame(2)+ladoEsqArame(1)],[posArameTopo posArameBase],'r')
%   plot([posArameTopo*ladoDirArame(2)+ladoDirArame(1) posArameBase*ladoDirArame(2)+ladoDirArame(1)],[posArameTopo posArameBase],'r')
%   %topo e base do arame
%   plot(1:1:tamanho2(2),ones(tamanho2(2))*posArameTopo,'b');
%   plot(1:1:tamanho2(2),ones(tamanho2(2))*posArameBase,'b');
%   
 

end


%% Resultados

% AnguloDesvio = atan((CentroArameTopo-CentroArameBase)/(posArameTopo-posArameBase));
% AnguloDesvio = AnguloDesvio*180/pi;
%   
% 
% figure;
% hold on;
% title(strcat('Medidas da poça de soldagem. Imagens ',int2str(inicio),' a ',int2str(fim)))
% plot(LarguraPoca);
% legend('Largura da poça');
% 
% figure;
% hold on;
% title(strcat('Medidas do arame. Imagens ',int2str(inicio),' a ',int2str(fim)))
% plot(CentroArameTopo);
% plot(CentroArameBase);
% legend('Centro do topo do arame','Centro da base do arame')
% 
% % figure;plot([inicioArameTopo,fimArameTopo],posArameTopo);
% %%perfil horizontal
% %figure;plot(somaHor,1:1:tamanho(1),derivadaHor,1:1:tamanho(1)-1);
% 
% %set(gca,'YDir','reverse')

