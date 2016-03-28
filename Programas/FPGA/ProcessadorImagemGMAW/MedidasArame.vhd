library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.common.all;


entity MedidasArame is
  port(
  meioVert      : in unsigned(7 downto 0);
  meioHor       : in unsigned(7 downto 0);
  in_clock      : in std_logic;
  pixel_entrada : in std_logic_vector(7 downto 0) := "00000000";
  coluna        : in natural range (numcols - 1) downto 0 := 0;
  linha         : in natural range (numlin - 1) downto 0 := 0;
  q             : in std_logic_vector(7 downto 0);
  inicioArame   : buffer vetorVert := (others => 0);
  fimArame      : buffer vetorVert := (others => 0);
  posArameTopo  : out natural range numlin downto 0 := 0;
  posArameBase  : out natural range numlin downto 0 := 0);
end MedidasArame;

architecture comportamental of MedidasArame is
signal somaHor            : vetorHor := (others => 0);
signal derivadaHor        : vetorHor := (others => 0);
signal max_derivada       : integer := -1000000;
signal max_derivada2      : integer := -1000000;

-- inicioArame e fimArame sao calculados a cada imagem. Portanto, eh necessario 3 vetores para fazer a media movel.
--signal inicioArame        : vetorVert := (others => 0);
signal inicioArame0       : vetorVert := (others => 0);
signal inicioArame1       : vetorVert := (others => 0);
signal inicioArame2       : vetorVert := (others => 0);
signal inicioArame3       : vetorVert := (others => 0);
--signal fimArame           : vetorVert := (others => 0);
signal fimArame0          : vetorVert := (others => 0);
signal fimArame1          : vetorVert := (others => 0);
signal fimArame2          : vetorVert := (others => 0);
signal fimArame3          : vetorVert := (others => 0);
signal max_derivada_arame : integer := -1000000;
signal min_derivada_arame : integer := 1000000;
signal pixel_antigo       : unsigned(7 downto 0) := (others => '0');
signal derivada           : integer := 0;

begin
process(coluna,linha,in_clock) begin
  if(rising_edge(in_clock)) then
    
    if(coluna=1 and linha=1) then
    -- começo de uma imagem. resetar valores aqui
      max_derivada <= -1000000;
      max_derivada2 <= -1000000;
      max_derivada_arame <= -1000000;
      min_derivada_arame <= 1000000;

      
    else
        --endereco_leitura <= endereco_leitura + 1;
      if (coluna = numcols - 2) then
      -- fim de uma linha

        if (linha = numlin - 2) then
        -- fim de uma imagem
          max_derivada <= -1000000;
          max_derivada2 <= -1000000;
        else
        -- proxima linha
          max_derivada_arame <= -1000000;
          min_derivada_arame <= 1000000;

          inicioArame3(linha) <= inicioArame2(linha);
          inicioArame2(linha) <= inicioArame1(linha);
          inicioArame1(linha) <= inicioArame0(linha);
          inicioArame(linha) <= inicioArame(linha) + inicioArame0(linha) - inicioArame3(linha);
          fimArame3(linha) <= fimArame2(linha);
          fimArame2(linha) <= fimArame1(linha);
          fimArame1(linha) <= fimArame0(linha);
          fimArame(linha) <= fimArame(linha) + fimArame0(linha) - fimArame3(linha);

          -- calculo das derivadas dos perfis horizontais
          if(linha > 1) then
            derivadaHor(linha-1) <= somaHor(linha-1) - somaHor(linha -2);
          end if;

          -- definicao do maximo e minimo das derivadas e topo e base do arame
          if (linha < meioVert) then
            if (derivadaHor(linha) > max_derivada) then
              max_derivada <= derivadaHor(linha);
              posArameTopo <= linha;
            end if;
          else
            if (derivadaHor(linha) > max_derivada2) then
              max_derivada2 <= derivadaHor(linha);
              posArameBase <= linha;
            end if;
          end if;

        end if;
      else
        -- definicao das laterais do arame
        derivada <= to_integer(unsigned(pixel_entrada)) - to_integer(unsigned(pixel_antigo));
        if (coluna < meioHor) then
          if (derivada < min_derivada_arame) then
            min_derivada_arame <= derivada;
            inicioArame0(linha) <= coluna;
          end if;
        else
          if (derivada > max_derivada_arame) then
            max_derivada_arame <= derivada;
            fimArame0(linha) <= coluna;
          end if;      
        end if;

        -- vetores sao formados enquanto a leitura ocorre
        somaHor(linha) <= somaHor(linha) + to_integer(unsigned(pixel_entrada)) - to_integer(unsigned(q));
        pixel_antigo <= unsigned(pixel_entrada);
      end if;

    end if;  
  end if;

end process;

end comportamental;
