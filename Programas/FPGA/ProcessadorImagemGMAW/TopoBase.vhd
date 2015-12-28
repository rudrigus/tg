library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.common.all;


entity TopoBase is
  port(
  meioVert      : in unsigned(7 downto 0);
  meioImagem    : in unsigned(7 downto 0);
  in_clock      : in std_logic;
  in_janela     : in std_logic;
  dado_escrita  : in std_logic_vector(7 downto 0) := "00000000";
  bloco_atual   : in unsigned(1 downto 0);
  endereco_leitura : inout unsigned(13 downto 0) := (others => '0');
  q                : in std_logic_vector(7 downto 0);
  posArameTopo  : out natural range numlin downto 0;
  posArameBase  : out natural range numlin downto 0);
end TopoBase;

architecture comportamental of TopoBase is
signal coluna : natural range (numcols - 1) downto 0 := 0;
signal linha  : natural range (numlin  - 1) downto 0 := 0;
--signal somaLinha        : integer := 0;
signal somaHor            : vetorHor := (others => 0);
signal derivadaHor        : vetorHor := (others => 0);
signal max_derivada       : integer := -1000000;
signal min_derivada       : integer := 1000000;

signal inicioArame        : vetorVert := (others => 0);
signal inicioArame0       : vetorVert := (others => 0);
signal inicioArame1       : vetorVert := (others => 0);
signal inicioArame2       : vetorVert := (others => 0);
signal inicioArame3       : vetorVert := (others => 0);
signal fimArame           : vetorVert := (others => 0);
signal fimArame0          : vetorVert := (others => 0);
signal fimArame1          : vetorVert := (others => 0);
signal fimArame2          : vetorVert := (others => 0);
signal fimArame3          : vetorVert := (others => 0);
signal max_derivada_arame : integer := -1000000;
signal min_derivada_arame : integer := 1000000;
signal pixel_antigo       : unsigned(7 downto 0) := (others => '0');
signal derivada           : integer := 0;

begin

-- pegar valores das 3 imagens carregadas e calcular (só estou lendo uma imagem, isso vai dar dor de cabeça)
  -- preciso pegar tambem do (bloco_atual -1) e do (bloco_atual -2)
  -- fazer um for() aqui e tirar a média? ou talvez usar memórias separadas?
-- OU -> usar pixel de entrada direto da leitura
  -- guardar os vetores somaHor e derivadaHor, para então subtrair do vetor os valores antigos de (bloco_atual -3)
  -- se der certo dá para usar tranquilamente quantas imagens eu quiser, pelo menos no cálculo de topo e base

process(in_janela,in_clock)
begin
  if(rising_edge(in_clock)) then
    
    if(in_janela = '1') then
    -- começo de uma imagem. para evitar surpresas, resetar valores aqui
      -- Adiantar endereço de memória pois sempre há o atraso de um ciclo para leitura e um para a subtração em soma_linha
      endereco_leitura <= (bloco_atual - "10") & ("000000000000" + "000000000010");
      coluna <= 0;
      linha <= 0;
      max_derivada <= -1000000;
      min_derivada <= 1000000;
      max_derivada_arame <= -1000000;
      min_derivada_arame <= 1000000;

      
    else
      if (coluna = numcols - 1) then
      -- fim de uma linha
        coluna <= 0;
        endereco_leitura <= endereco_leitura + 1;

        if (linha = numlin -1) then
        -- fim de uma imagem
          linha <= 0;
          endereco_leitura <= (bloco_atual - "10") & "000000000000";
          
          max_derivada <= -1000000;
          min_derivada <= 1000000;
        else
        -- proxima linha
          linha <= linha + 1;
          
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
          if(linha > 0) then
            derivadaHor(linha) <= somaHor(linha) - somaHor(linha -1);
          else
            derivadaHor(linha) <= 0;
          end if;

          -- definicao do maximo e minimo das derivadas e topo e base do arame
          if (linha < meioVert) then
            if (derivadaHor(linha) > max_derivada) then
              max_derivada <= derivadaHor(linha);
              posArameTopo <= linha;
            end if;
          else
            if (derivadaHor(linha) < min_derivada) then
              min_derivada <= derivadaHor(linha);
              posArameBase <= linha;
            end if;
          end if; 

        end if;
      else
      -- ler mais um pixel na linha
        endereco_leitura <= endereco_leitura + 1;
        coluna <= coluna + 1;

        -- definicao das laterais do arame
        derivada <= to_integer(unsigned(dado_escrita)) - to_integer(unsigned(pixel_antigo));
        if (coluna < meioImagem) then
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
        somaHor(linha) <= somaHor(linha) + to_integer(unsigned(dado_escrita)) - to_integer(unsigned(q));
        pixel_antigo <= unsigned(dado_escrita);
      end if;

    end if;  
  end if;

end process;

end comportamental;
