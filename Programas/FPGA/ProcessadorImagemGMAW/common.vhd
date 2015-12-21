library ieee;
use ieee.numeric_std.all;

package Common is
  constant numcols : integer := 60;
  constant numlin : integer := 60;
  type LinhaImagem is array (0 to numcols - 1) of unsigned(7 downto 0);
  type MatrizImagem is array (0 to numlin - 1, 0 to numcols - 1) of unsigned(7 downto 0);
  
  type vetorHor  is array(0 to numlin - 1 ) of integer;
  type vetorVert is array(0 to numcols - 1) of integer;


  type lin3 is array (0 to 2) of integer;
  type mat33 is array (0 to 2) of lin3;
end Common;

package body Common is

end Common;