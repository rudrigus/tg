clear;
clc;
close all;

%% Config iniciais
% diretorios imagens
cd ~/UNB/TG
Diretorio_leitura = './Imagens/Capturas/1000 fps/Resultados Filtro Adaptativo/';
fatorBrilhoMaximo = .3 * 255;
inicio = 440;
fim    = 442;




%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Processamento das imagens
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Media de imagens para reduzir ruidos

ImTemp = imread(strcat(Diretorio_leitura,'Img',int2str(inicio),'.bmp'));
tamanho = size(ImTemp);
brilhoMaximo = fatorBrilhoMaximo * tamanho(1) * tamanho(2);

imagensSelecionadas = zeros(fim - inicio + 1,1);

for j = inicio:1:fim
  %% Selecionar imagens
  Is = imread(strcat(Diretorio_leitura,'Img',int2str(j),'.bmp'));
  if sum(sum(Is)) > brilhoMaximo
    imagensSelecionadas(j-inicio+1) = 0;
  else
    imagensSelecionadas(j-inicio+1) = 1;
  end
end



%% Resultados

indices = inicio + find(imagensSelecionadas)-1;
figure;
hold on;
% plot(inicio:1:fim, ones(fim - inicio + 1, 1),'-k');
plot(inicio:1:fim, imagensSelecionadas,'.b','LineWidth',1);
axis([inicio fim .8 1.2]);
set(gca,'YTick',[]);
for i=1:1:size(indices)
  plot([indices(i) indices(i)],[-1 1],'--k');
end

legend('Imagens Selecionadas');

