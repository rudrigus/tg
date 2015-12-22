library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.common.all;


entity Bordas is
  port(
  meio_imagem   : in unsigned(7 downto 0);
  in_clock      : in std_logic;
  in_janela     : in std_logic;
  pixel_entrada : in std_logic_vector(7 downto 0) := "00000000";
  bloco_atual   : in natural range qtd_imagens downto 0;
  limEsqPoca    : out natural range numcols downto 0;
  limDirPoca    : out natural range numcols downto 0);
end Bordas;

architecture comportamental of Bordas is
signal coluna : natural range (numcols - 1) downto 0 := 0;
signal linha  : natural range (numlin  - 1) downto 0 := 0;
--signal somaColuna        : natural;
--signal somaColunaAntiga  : natural;
signal somaVert          : vetorVert := (others => 0);
signal somaVert2         : vetorVert := (others => 0);
signal derivadaVert      : vetorVert := (others => 0);
signal max_derivada      : integer := -1000000;
signal min_derivada      : integer := 1000000;
signal endereco_leitura  : unsigned(13 downto 0) := to_unsigned(bloco_atual * tamanho_imagem, 14);
signal q                 : std_logic_vector(7 downto 0);

component ImagensRAM
  PORT(
    clock   : IN STD_LOGIC  := '1';
    data    : IN STD_LOGIC_VECTOR (7 downto 0);
    rdaddress   : IN STD_LOGIC_VECTOR (13 downto 0);
    wraddress   : IN STD_LOGIC_VECTOR (13 downto 0);
    wren    : IN STD_LOGIC  := '0';
    q   : OUT STD_LOGIC_VECTOR (7 downto 0));
END component;


begin

ram : ImagensRAM port map(in_clock, "00000000", std_logic_vector(endereco_leitura), "00000000000000", '0', q);


-- algoritmo parecido com o TopoBase.vhd, mas calcula só na última linha
-- arrumar para mais imagens

process(in_janela,in_clock)
begin
  
  if(rising_edge(in_clock)) then
    
    if(in_janela = '1') then
    -- começo de uma imagem. para evitar surpresas, resetar valores aqui
      endereco_leitura <= to_unsigned(bloco_atual * tamanho_imagem, 14);
      coluna <= 0;
      linha <= 0;
      max_derivada <= -1000000;
      min_derivada <= 1000000;
      --somaColuna <= 0;
      --somaColunaAntiga <= 0;
    else
      if (coluna = numcols - 1) then
      -- fim de uma linha
        coluna <= 0;

        if (linha = numlin -1) then
        -- fim de uma imagem
          linha <= 0;
          max_derivada <= -1000000;
          min_derivada <= 1000000;
        else
        -- proxima linha
          linha <= linha + 1;

        end if;
      else
      -- ler mais um pixel
        endereco_leitura <= endereco_leitura + 1;
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
          if (coluna < meio_imagem) then
            if (derivadaVert(coluna) > max_derivada) then
              max_derivada <= derivadaVert(coluna);
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
