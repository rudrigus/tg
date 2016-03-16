library ieee;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;

package Common is
  constant numcols   : integer := 60;
  constant numlin    : integer := 60;
  --constant tamanho_imagem : integer := numcols * numlin;
  constant qtd_imagens : natural := 4;

  -- usado para regressao:linear
  -- olhar rea-Efficient Linear Regression Architecture for Real-Time Signal Processing on FPGAs
  -- equacoes 9 e 10
  --constant qtdPontosArame  : natural := 20;
  --constant constRegressao1 : float   := 0.0015;
  --constant constRegressao2 : float   := 0.0143;
  --constant constRegressao3 : float   := 0.1857;
  
  --constant qtdPontosArame  : natural := 16;
  --constant constRegressao1 : float   := 0.0029;
  --constant constRegressao2 : float   := 0.0221;
  --constant constRegressao3 : float   := 0.2279;

  constant qtdPontosArame  : natural := 16;
  constant constRegressao1 : integer   := 194616; -- = 0,0029 * 2^26
  constant constRegressao2 : integer   := 185388; -- = 0,0221 * 2^23
  constant constRegressao3 : integer   := 238970; -- = 0,2279 * 2^20



  type vetorHor  is array(0 to numlin - 1 ) of integer;
  type vetorVert is array(0 to numcols - 1) of integer;
  type coeficientesReta is array(0 to 1) of integer;
  

  type MatrizImagem is array (0 to numlin - 1, 0 to numcols - 1) of unsigned(7 downto 0);
  --type LinhaImagem is array (0 to numcols - 1) of natural range numlin downto 0;
  --type ColunaImagem is array (0 to numlin - 1) of natural range numcols downto 0;

  --type lin3 is array (0 to 2) of integer;
  type vetor_filtro is array ((2 * numcols + 1) downto 0) of std_logic_vector(7 downto 0);
  type matriz33 is array (2 downto 0, 2 downto 0) of std_logic_vector(7 downto 0);
end Common;

package body Common is

end Common;
