clc
%clear
close all

% cd d:/trabaio/TG
cd ~/UNB/TG
I = imread('./Imagens/Teste/ImagemTeste5.jpg');
I = rgb2gray(I);


% retirar informacoes desnecessarias para o calculo da matriz de
% transformacao
a = cast(I>100,'uint8');
J = I.*a;

% filtro de gaussiana
H = fspecial('gaussian',3);
J = imfilter(J,H,'replicate');


imshow(I)
hold on
CantosImagem = corner(J,'Harris',4,'QualityLevel',.01,'SensitivityFactor',0.02);
plot(CantosImagem(:,1),CantosImagem(:,2),'rx')

%%Ordenar elementos de CantosImagem
[A,B] = sort(CantosImagem(:,1),'descend');
temp=zeros(4,2);
temp(:,1)=A;
for i=1:1:4
    temp(i,2)= CantosImagem(B(i),2);
end
CantosImagem = temp;

x = CantosImagem(:,1);
y = CantosImagem(:,2);
plot([x;x(1)],[y;y(1)],'r')

%imprimir quadrado, em azul
plot([150 150 550 550 150], [100 500 500 100 100],'b')
% plot([150 150 350 350 150], [300 500 500 300 300],'b')

%coordenadas "reais" dos ponto contidos em CantosImagem
X=[2000; 2000; 500; 500];
Y=[3000; 1500; 1500; 3000];

%Calculo da transformada
B = [ x y ones(size(X)) zeros(4,3)        -x.*X -y.*X ...
      zeros(4,3)        x y ones(size(X)) -x.*Y -y.*Y ];
B = reshape (B', 8 , 8 )';
D = [ X , Y ];
D = reshape (D', 8 , 1 );
l = inv(B) * D;
A = reshape([l(1:6)' 0 0 1 ],3,3)';
C = [l(7:8)' 1];
%while 1 ,
% [x1,y1]=ginput(1); 
% [x2,y2]=ginput(1);
% for u=0:.1:1,
%   x = u*x1+(1-u)*x2;
%   y = u*y1+(1-u)*y2;
%   plot(x,y,'xr'); t=A*[x;y;1]/(C*[x;y;1]);plot(t(1),t(2),'ob') 
%   end
%end


% matriz de transformacao: A
A = reshape([l(1:8)' 1 ],3,3)';
tform = maketform('projective',A');

% Imagem corrigida
hold off
I2 = imtransform(I,tform,'XYScale',1);
figure;
imshow(I2);

