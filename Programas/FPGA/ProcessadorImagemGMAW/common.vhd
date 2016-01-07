library ieee;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_1164.all;

package Common is
  constant numcols   : integer := 60;
  constant numlin    : integer := 60;
  --constant qtdPontosArame : natural := 16;
  --constant tamanho_imagem : integer := numcols * numlin;
  constant qtd_imagens : natural := 4;
  type vetorHor  is array(0 to numlin - 1 ) of integer;
  type vetorVert is array(0 to numcols - 1) of integer;
  

  type MatrizImagem is array (0 to numlin - 1, 0 to numcols - 1) of unsigned(7 downto 0);
  --type LinhaImagem is array (0 to numcols - 1) of unsigned(7 downto 0);

  --type lin3 is array (0 to 2) of integer;
  type vetor_filtro is array ((2 * numcols + 1) downto 0) of std_logic_vector(7 downto 0);
  type matriz33 is array (2 downto 0, 2 downto 0) of std_logic_vector(7 downto 0);
end Common;

package body Common is

end Common;
