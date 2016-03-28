library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.common.all;

entity Controlador is
  port(
  in_clock         : in std_logic;
  FVAL             : in std_logic;
  LVAL             : in std_logic;
  processar        : out std_logic := '0';
  coluna           : buffer natural range (numcols - 1) downto 0 := 0;
  linha            : buffer natural range (numlin - 1) downto 0 := 0;
  colunaFiltro     : buffer natural range (numcols - 1) downto 0 := 0;
  linhaFiltro      : buffer natural range (numlin - 1) downto 0 := 0);
end Controlador;

architecture comportamental of Controlador is
  signal atraso_coluna : std_logic := '1';


-- logica para definir valores de colunas e linhas usadas no sistema
-- essa logica exclui a primeiras e ultimas linha e coluna depois do filtro
begin
  process(FVAL,in_clock) begin
  
  if(rising_edge(in_clock)) then
    
    if(FVAL = '0') then
    -- começo de uma imagem. resetar valores aqui
      coluna <= 0;
      atraso_coluna <= '1';
      linha <= 0;
    else
      if (coluna = numcols - 1) then
      -- fim de uma linha
        coluna <= 0;
        if (linha = numlin -1) then
        -- fim de uma imagem
          linha <= 0;
        else
        -- proxima linha
          linha <= linha + 1;
          if(linha > 0) then
            linhaFiltro <= linha;
          end if;
        end if;
      else
      -- ler mais um pixel
        if LVAL = '1' then
          if atraso_coluna = '1' then
            atraso_coluna <= '0';
          else
            coluna <= coluna + 1;
          end if;
          if(coluna>0 and linha>0) then
            colunaFiltro <= coluna;
          end if;
        else
          atraso_coluna <= '1';
        end if;
      end if;
    end if;

    if(coluna=0 or linha=0 or coluna=numcols-1 or linha=numlin-1) then
      processar <= '0';
    else
      processar <= '1';
    end if;
  end if;

end process;



end comportamental;