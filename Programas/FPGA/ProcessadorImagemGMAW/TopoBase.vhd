library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.common.all;


entity TopoBase is
  port(
  meioVert      : in unsigned(7 downto 0);
  in_clock      : in std_logic;
  in_janela     : in std_logic;
  pixel_entrada : in std_logic_vector(7 downto 0) := "00000000";
  bloco_atual   : in unsigned(1 downto 0);
  endereco_leitura : inout unsigned(13 downto 0) := (others => '0');
  q                : in std_logic_vector(7 downto 0);
  posArameTopo  : out natural range numlin downto 0;
  posArameBase  : out natural range numlin downto 0);
end TopoBase;

architecture comportamental of TopoBase is
signal coluna : natural range (numcols - 1) downto 0 := 0;
signal linha  : natural range (numlin  - 1) downto 0 := 0;
signal somaLinha        : integer;
--signal somaLinhaAntiga  : natural;
signal somaHor          : vetorHor := (others => 0);
signal derivadaHor      : vetorHor := (others => 0);
signal max_derivada     : integer := -1000000;
signal min_derivada     : integer := 1000000;
signal bloco_uns : unsigned(13 downto 0) := (others => '0');
signal bloco_int : integer := 0;



--component ImagensRAM
--  PORT(
--    clock   : IN STD_LOGIC  := '1';
--    data    : IN STD_LOGIC_VECTOR (7 downto 0);
--    rdaddress   : IN STD_LOGIC_VECTOR (13 downto 0);
--    wraddress   : IN STD_LOGIC_VECTOR (13 downto 0);
--    wren    : IN STD_LOGIC  := '0';
--    q   : OUT STD_LOGIC_VECTOR (7 downto 0));
--END component;


begin

--ram : ImagensRAM port map(in_clock, "00000000", std_logic_vector(endereco_leitura), "00000000000000", '0', q);


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
      --endereco_leitura <= to_unsigned(bloco_antigo * tamanho_imagem, 14);
      endereco_leitura <= (bloco_atual - "10") & "000000000000";
      coluna <= 0;
      linha <= 0;
      max_derivada <= -1000000;
      min_derivada <= 1000000;
      somaLinha <= 0;
      --somaLinhaAntiga <= 0;
    else
      if (coluna = numcols - 1) then
      -- fim de uma linha
        coluna <= 0;
        somaLinha <= 0;
        --somaLinhaAntiga <= 0;
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
--somaHor(linha) <= somaHor(linha) + somaLinha - somaLinhaAntiga;
          somaHor(linha) <= somaLinha;
          
          -- calculo das derivadas dos perfis horizontais
          if(linha > 0) then
            derivadaHor(linha) <= somaLinha - somaHor(linha -1);
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

        -- vetores sao formados enquanto a leitura ocorre
        somaLinha <= somaLinha + to_integer(unsigned(pixel_entrada)) - to_integer(unsigned(q));
        --somaLinhaAntiga <= somaLinhaAntiga + to_integer(unsigned(q));
      end if;

    end if;  
  end if;

end process;




end comportamental;
