library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.common.all;


entity BordasPoca is
  port(
  meioHor       : in unsigned(7 downto 0);
  in_clock      : in std_logic;
  --FVAL          : in std_logic;
  --LVAL          : in std_logic;
  --processar     : in std_logic;
  coluna        : in natural range (numcols - 1) downto 0 := 0;
  linha         : in natural range (numlin - 1) downto 0 := 0;
  pixel_entrada : in std_logic_vector(7 downto 0) := (others => '0');
  q             : in std_logic_vector(7 downto 0);
  limEsqPoca    : out natural range numcols downto 0;
  limDirPoca    : out natural range numcols downto 0);
end BordasPoca;

architecture comportamental of BordasPoca is
--signal coluna : natural range (numcols - 1) downto 0 := 0;
--signal linha  : natural range (numlin  - 1) downto 0 := 0;
--signal somaColuna        : natural;
--signal somaColunaAntiga  : natural;
signal somaVert           : vetorVert := (others => 0);
signal derivadaVert       : vetorVert := (others => 0);
signal max_derivada       : integer := -1000000;
signal min_derivada       : integer := 1000000;

begin

-- algoritmo parecido com o TopoBase.vhd, mas calcula só na última linha

process(linha,coluna,in_clock) begin
  
  if(rising_edge(in_clock)) then
    
    if(linha=1 and coluna=1) then
    -- começo de uma imagem. para evitar surpresas, resetar valores aqui
      --coluna <= 0;
      --linha <= 0;
      max_derivada <= -1000000;
      min_derivada <= 1000000;
    else
      --if (coluna = numcols - 1) then
      -- fim de uma linha
        --coluna <= 0;

        if (linha = numlin -1) then
        -- fim de uma imagem
          --linha <= 0;
          max_derivada <= -1000000;
          min_derivada <= 1000000;
        --else
        -- proxima linha
          --linha <= linha + 1;

        end if;
      --else
        -- vetores sao formados enquanto a leitura ocorre
        somaVert(coluna) <= somaVert(coluna) + to_integer(unsigned(pixel_entrada)) - to_integer(unsigned(q));

        -- fazer os calculos na ultima linha
        if (linha = numlin - 2) then
          -- calculo das derivadas dos perfis verticais
          if(coluna > 0) then
            derivadaVert(coluna) <= somaVert(coluna) - somaVert(coluna -1);
          else
            derivadaVert(coluna) <= 0;
          end if;

          -- definicao do maximo e minimo das derivadas e bordas
          if (coluna < meioHor) then
            if (derivadaVert(coluna) > max_derivada) then
              max_derivada <= derivadaVert(coluna);
              --if(coluna>2) then
                limEsqPoca <= coluna;
              --end if;
            end if;
          else
            if (derivadaVert(coluna) < min_derivada) then
              min_derivada <= derivadaVert(coluna);
              limDirPoca <= coluna;
            end if;
          end if; 

        end if;

      end if;
    --end if;  
  end if;

end process;




end comportamental;
