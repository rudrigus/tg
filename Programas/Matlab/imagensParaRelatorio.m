%%Exemplo de processamento de imagem

clear;
clc;
close all;

%% Config iniciais
% diretorios imagens
cd ~/UNB/TG
% Diretorio_leitura = './Imagens/Capturas/1000 fps/Resultados Filtro Adaptativo/';
Diretorio_leitura = './Imagens/Resultados 2 DVd Guilherme/';

fatorBrilhoMaximo = .2 * 255;
% inicio = 440;
% fim    = 442;
inicio = 4719;
% fim    = 2100;
fim    = 4743;

% parametros
diametroArame = 1;
% Medidas reais do arame: h=10,25mm r=0,5mm (d=1mm)
% X=[100; 100; 0; 0];
% Y=[1025; 0; 0; 1025];
X=[250; 250; 150; 150];
Y=[1185; 160; 160; 1185];


%% Imagem base para calibracao
ImagemBase = './Imagens/Resultados 2 DVd Guilherme/Img4000.bmp';
I = imread(ImagemBase);
tamanho = size(I);
[ImagemTratada,posArameTopo,posArameBase,limEsqPoca,limDirPoca,ladoEsqArame,ladoDirArame,pixelsArameBase,~] = processamentoRelatorio(I,tamanho,1,4000);


%% Correcao de valores com distorcao de perspectiva
% O que estamos buscando aqui é a matriz de transformação gerada a partir da imagem.
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

% matriz de transformada A
A = reshape([l(1:8)' 1 ],3,3)'
tform = maketform('projective',A');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Processamento das imagens
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

quantidadeImagens = 3; 
ImTemp = imread(strcat(Diretorio_leitura,'Img',int2str(inicio),'.bmp'));
tamanho = size(ImTemp);
brilhoMaximo = fatorBrilhoMaximo * tamanho(1) * tamanho(2);
Im = zeros(tamanho(1),tamanho(2),quantidadeImagens);
% LarguraPoca = zeros(fim-inicio+1,1);
limEsqPoca = zeros(fim-inicio+1,1);
limDirPoca = zeros(fim-inicio+1,1);
pixelsArameBase = zeros(fim-inicio+1,1);
posArameTopo = zeros(fim-inicio+1,1);
posArameBase = zeros(fim-inicio+1,1);
CentroArameTopo = zeros(fim-inicio+1,1);
CentroArameBase = zeros(fim-inicio+1,1);
falhas = zeros(fim-inicio+1,1);
imagensSelecionadas = zeros(fim-inicio+1,1);
% AnguloDesvio = zeros(fim-inicio+1,1);

qtdImagensBoas = 0;
%% sequencia de imagens
for j = inicio:1:fim
%   colcluido = (j - inicio) / (fim - inicio)*100
  %% Selecionar imagens
  Is = imread(strcat(Diretorio_leitura,'Img',int2str(j),'.bmp'));
  if sum(sum(Is)) > brilhoMaximo || sum(sum(Is)) < 0.8*brilhoMaximo
    if j > inicio+1
      posArameTopo(j-inicio+1) = posArameTopo(j-inicio);
      posArameBase(j-inicio+1) = posArameBase(j-inicio);
      CentroArameTopo(j-inicio+1) = CentroArameTopo(j-inicio);
      CentroArameBase(j-inicio+1) = CentroArameBase(j-inicio);
      limEsqPoca(j-inicio+1) = limEsqPoca(j-inicio);
      limDirPoca(j-inicio+1) = limDirPoca(j-inicio);
      pixelsArameBase(j-inicio+1) = pixelsArameBase(j-inicio);
    end
  else
    imagensSelecionadas(j-inicio+1) = 1;
    qtdImagensBoas = qtdImagensBoas + 1;
    % colocar imagem com pouco brilho em buffer
    switch qtdImagensBoas
      case 1
        Im(:,:,3) = Is;
        I = Is;
      case 2
        Im(:,:,2) = Im(:,:,3);
        Im(:,:,3) = Is;
        I = Im(:,:,2) + Im(:,:,3)/2;
      otherwise
        Im(:,:,1:2) = Im(:,:,2:3);
        Im(:,:,3) = Is;
        I = mean(Im,3);
    end
    
    
    
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
    I2 = imtransform(I,tform,'XYScale',1);
    % image(I2);colormap(gray(256))
    tamanho2 = size(I2);


    % Obtencao de calculos na imagem corrigida
%     if qtdImagensBoas > 2
%       j
%       topo = posArameTopo(j-inicio)
      [I2,posArameTopo(j-inicio+1),posArameBase(j-inicio+1),limEsqPoca(j-inicio+1),limDirPoca(j-inicio+1),ladoEsqArame,ladoDirArame,pixelsArameBase(j-inicio+1),falhas(j-inicio+1)] = processamentoRelatorio(I2,tamanho2,1,j);
      CentroArameTopo(j-inicio+1) = ((posArameTopo(j-inicio+1)*ladoEsqArame(2)+ladoEsqArame(1) + posArameTopo(j-inicio+1)*ladoDirArame(2)+ladoDirArame(1))/2)/pixelsArameBase(j-inicio+1);
      CentroArameBase(j-inicio+1) = ((posArameBase(j-inicio+1)*ladoEsqArame(2)+ladoEsqArame(1) + posArameBase(j-inicio+1)*ladoDirArame(2)+ladoDirArame(1))/2)/pixelsArameBase(j-inicio+1);
%     end

  end
end
LarguraPoca = diametroArame * (limDirPoca - limEsqPoca) ./ pixelsArameBase;
AlturaArame = (posArameBase-posArameTopo) ./ pixelsArameBase;

%% Resultados

AnguloDesvio = atan((CentroArameTopo-CentroArameBase)/(posArameTopo-posArameBase));
AnguloDesvio = AnguloDesvio*180/pi;
  

figure;
hold on;
% title(strcat('Medidas da poça de soldagem. Imagens ',int2str(inicio),' a ',int2str(fim)))
p1=plot(inicio:1:fim,diametroArame * limEsqPoca ./ pixelsArameBase);
p2=plot(inicio:1:fim,diametroArame * limDirPoca ./ pixelsArameBase);
legend([p1,p2],'Lado esquerdo da poça','Lado direito da poça');

% figure;
% hold on;
% % title(strcat('Medidas da poça de soldagem. Imagens ',int2str(inicio),' a ',int2str(fim)))
% p3=plot(inicio:1:fim,LarguraPoca);
% legend('Largura da poça');

figure;
hold on;
% title(strcat('Medidas da altura do eletrodo. Imagens ',int2str(inicio),' a ',int2str(fim)))
p4=plot(inicio:1:fim,AlturaArame);
legend('Altura do eletrodo');

figure;
hold on; 
% title(strcat('Medidas do arame. Imagens ',int2str(inicio),' a ',int2str(fim)))
p5=plot(inicio:1:fim,CentroArameTopo);
p6=plot(inicio:1:fim,CentroArameBase);
legend('Centro do topo do arame','Centro da base do arame')
% 
% 
figure;
hold on; 
p1=plot(inicio:1:fim,diametroArame * limEsqPoca ./ pixelsArameBase);
p2=plot(inicio:1:fim,diametroArame * limDirPoca ./ pixelsArameBase);
p5=plot(inicio:1:fim,CentroArameTopo);
p6=plot(inicio:1:fim,CentroArameBase);
legend([p1,p2,p5,p6],'Lado esquerdo da poça','Lado direito da poça','Centro do topo do arame','Centro da base do arame');

% % falhas
% indices = inicio + find(falhas)-1;
% figure;
% hold on;
% plot(inicio:1:fim, falhas,'xb','LineWidth',1);
% axis([inicio fim .8 1.2]);
% set(gca,'YTick',[]);
% plot(inicio:1:fim, ones(fim - inicio + 1, 1),'-k');
% for i=1:1:size(indices)
%   plot([indices(i) indices(i)],[-1 1],'--k');
% end

% imagens selecionadas
indices = inicio -1 + find(imagensSelecionadas(1:1000));
figure;
hold on;
% plot(inicio:1:fim, ones(fim - inicio + 1, 1),'-k');
plot(inicio:1:inicio+999, imagensSelecionadas(1:1000),'.k','LineWidth',.5);
axis([inicio inicio+999 .8 1.2]);
set(gca,'YTick',[]);
% for i=1:1:size(indices)
%   plot([indices(i) indices(i)],[-1 1],'--k');
% end

legend('Imagens Selecionadas');

