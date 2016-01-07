library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.common.all;


entity Bordas is
  port(
  meioImagem    : in unsigned(7 downto 0);
  in_clock      : in std_logic;
  in_janela     : in std_logic;
  pixel_entrada : in std_logic_vector(7 downto 0) := (others => '0');
  q             : in std_logic_vector(7 downto 0);
  limEsqPoca    : out natural range numcols downto 0;
  limDirPoca    : out natural range numcols downto 0);
end Bordas;

architecture comportamental of Bordas is
signal coluna : natural range (numcols - 1) downto 0 := 0;
signal linha  : natural range (numlin  - 1) downto 0 := 0;
--signal somaColuna        : natural;
--signal somaColunaAntiga  : natural;
signal somaVert           : vetorVert := (others => 0);
signal derivadaVert       : vetorVert := (others => 0);
signal max_derivada       : integer := -1000000;
signal min_derivada       : integer := 1000000;
signal max_derivada_arame : integer := -1000000;
signal min_derivada_arame : integer := 1000000;

begin

-- algoritmo parecido com o TopoBase.vhd, mas calcula só na última linha

process(in_janela,in_clock)
begin
  
  if(rising_edge(in_clock)) then
    
    if(in_janela = '1') then
    -- começo de uma imagem. para evitar surpresas, resetar valores aqui
      coluna <= 0;
      linha <= 0;
      max_derivada <= -1000000;
      min_derivada <= 1000000;
    else
      if (coluna = numcols - 1) then
      -- fim de uma linha
        coluna <= 0;

        if (linha = numlin -1) then
        -- fim de uma imagem
          linha <= 0;
          max_derivada <= -1000000;
          min_derivada <= 1000000;
          max_derivada_arame <= -1000000;
          min_derivada_arame <= 1000000;
        else
        -- proxima linha
          linha <= linha + 1;

        end if;
      else
      -- ler mais um pixel
        coluna <= coluna + 1;

        -- vetores sao formados enquanto a leitura ocorre
        somaVert(coluna) <= somaVert(coluna) + to_integer(unsigned(pixel_entrada)) - to_integer(unsigned(q));

        -- fazer os calculos na ultima linha
        if (linha = numlin - 1) then
          -- calculo das derivadas dos perfis verticais
          if(coluna > 0) then
            derivadaVert(coluna) <= somaVert(coluna) - somaVert(coluna -1);
          else
            derivadaVert(coluna) <= 0;
          end if;

          -- definicao do maximo e minimo das derivadas e bordas
          if (coluna < meioImagem) then
            if (derivadaVert(coluna) > max_derivada) then
              max_derivada <= derivadaVert(coluna);
              limEsqPoca <= coluna;
            end if;
            if (derivadaVert(coluna) < min_derivada_arame) then
              min_derivada_arame <= derivadaVert(coluna);
              limEsqPoca <= coluna;
            end if;


          else
            if (derivadaVert(coluna) < min_derivada) then
              min_derivada <= derivadaVert(coluna);
              limDirPoca <= coluna - 1;
            end if;
          end if; 

        end if;

      end if;
    end if;  
  end if;

end process;




end comportamental;
