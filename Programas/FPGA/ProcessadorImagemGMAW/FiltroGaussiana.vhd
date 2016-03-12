library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.common.all;

entity FiltroGaussiana is
  port (
  in_clock         : in std_logic;
  FVAL             : in std_logic;
  pixel_entrada    : in std_logic_vector(7 downto 0) := (others => '0');
  pixel_filtrado   : out std_logic_vector(7 downto 0) := (others => '0'));
end FiltroGaussiana;


architecture comportamental of FiltroGaussiana is
  signal coluna : natural range (numcols - 1) downto 0 := 0;
  signal linha  : natural range (numlin  - 1) downto 0 := 0;
  signal mascara_gaussiana : matriz33;
  signal janela_p_filtro   : matriz33;
  
  signal buffer_filtro : vetor_filtro;
  signal p1 : std_logic_vector(15 downto 0)  := (others => '0');
  signal p2 : std_logic_vector(15 downto 0)  := (others => '0');
  signal p3 : std_logic_vector(15 downto 0)  := (others => '0');
  signal p4 : std_logic_vector(15 downto 0)  := (others => '0');
  signal p5 : std_logic_vector(15 downto 0)  := (others => '0');
  signal p6 : std_logic_vector(15 downto 0)  := (others => '0');
  signal p7 : std_logic_vector(15 downto 0)  := (others => '0');
  signal p8 : std_logic_vector(15 downto 0)  := (others => '0');
  signal p9 : std_logic_vector(15 downto 0)  := (others => '0');

  component Multiplicador8B16B
  port (
  a : in std_logic_vector(7 downto 0)   := (others => '0');
  b : in std_logic_vector(7 downto 0)   := (others => '0');
  p : out std_logic_vector(15 downto 0) := (others => '0'));
  end component;

begin
  --mascara de gaussiana
    -- 0.0113 0.0838 0.0113
    -- 0.0838 0.6193 0.0838
    -- 0.0113 0.0838 0.0113
  -- mascara multiplicada por 2^8
  mascara_gaussiana(0,0) <= x"03";
  mascara_gaussiana(0,1) <= x"15";
  mascara_gaussiana(0,2) <= x"03";
  mascara_gaussiana(1,0) <= x"15";
  mascara_gaussiana(1,1) <= x"9E";
  mascara_gaussiana(1,2) <= x"15";
  mascara_gaussiana(2,0) <= x"03";
  mascara_gaussiana(2,1) <= x"15";
  mascara_gaussiana(2,2) <= x"03";

process(FVAL,in_clock) begin
  
  if(rising_edge(in_clock)) then
    buffer_filtro((2 * numcols + 1) downto 1) <= buffer_filtro((2 * numcols) downto 0);
    buffer_filtro(0) <= pixel_entrada;

    if(FVAL = '1') then
      coluna <= 0;
      linha <= 0;
      -- no primeiro pixel, copiar para bordas

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
        end if;
      else
        -- cálculo normal

        coluna <= coluna + 1;
      end if;
    end if;
  end if;

end process;

-- arrumar janela nas bordas
  -- NAO ESTOU PEGANDO A ULTIMA LINHA E A ULTIMA COLUNA, nao sei se compensa
process(in_clock)
begin
  if (linha = 0) or (coluna = 0) then
    janela_p_filtro <= (others => ("00000000","00000000","00000000"));
  elsif (linha = 1) then
    if (coluna = 1) then
      janela_p_filtro(0, 0) <= buffer_filtro(numcols);
      janela_p_filtro(0, 1) <= buffer_filtro(numcols);
      janela_p_filtro(0, 2) <= buffer_filtro(numcols - 1);
      janela_p_filtro(1, 0) <= buffer_filtro(numcols);
      janela_p_filtro(1, 1) <= buffer_filtro(numcols);
      janela_p_filtro(1, 2) <= buffer_filtro(numcols - 1);
      janela_p_filtro(2, 0) <= buffer_filtro(0);
      janela_p_filtro(2, 1) <= buffer_filtro(0);
      janela_p_filtro(2, 2) <= pixel_entrada;
    else
      janela_p_filtro(0, 0) <= buffer_filtro(numcols + 1);
      janela_p_filtro(0, 1) <= buffer_filtro(numcols);
      janela_p_filtro(0, 2) <= buffer_filtro(numcols - 1);
      janela_p_filtro(1, 0) <= buffer_filtro(numcols + 1);
      janela_p_filtro(1, 1) <= buffer_filtro(numcols);
      janela_p_filtro(1, 2) <= buffer_filtro(numcols - 1);
      janela_p_filtro(2, 0) <= buffer_filtro(1);
      janela_p_filtro(2, 1) <= buffer_filtro(0);
      janela_p_filtro(2, 2) <= pixel_entrada;
    end if;
  else
    if (coluna = 1) then
      janela_p_filtro(0, 0) <= buffer_filtro(2 * numcols);
      janela_p_filtro(0, 1) <= buffer_filtro(2 * numcols);
      janela_p_filtro(0, 2) <= buffer_filtro(2 * numcols - 1);
      janela_p_filtro(1, 0) <= buffer_filtro(numcols);
      janela_p_filtro(1, 1) <= buffer_filtro(numcols);
      janela_p_filtro(1, 2) <= buffer_filtro(numcols - 1);
      janela_p_filtro(2, 0) <= buffer_filtro(0);
      janela_p_filtro(2, 1) <= buffer_filtro(0);
      janela_p_filtro(2, 2) <= pixel_entrada;
    else
      janela_p_filtro(0, 0) <= buffer_filtro(2 * numcols + 1);
      janela_p_filtro(0, 1) <= buffer_filtro(2 * numcols);
      janela_p_filtro(0, 2) <= buffer_filtro(2 * numcols - 1);
      janela_p_filtro(1, 0) <= buffer_filtro(numcols + 1);
      janela_p_filtro(1, 1) <= buffer_filtro(numcols);
      janela_p_filtro(1, 2) <= buffer_filtro(numcols - 1);
      janela_p_filtro(2, 0) <= buffer_filtro(1);
      janela_p_filtro(2, 1) <= buffer_filtro(0);
      janela_p_filtro(2, 2) <= pixel_entrada;
    end if;

  end if;
end process;

--somar dividindo por 2^8
process(in_clock)
begin
  if (rising_edge(in_clock)) then
    pixel_filtrado <= p1(15 downto 8) + p2(15 downto 8) + p3(15 downto 8) + 
                      p4(15 downto 8) + p5(15 downto 8) + p6(15 downto 8) + 
                      p7(15 downto 8) + p8(15 downto 8) + p9(15 downto 8);
  end if ;
end process;

m1 : Multiplicador8B16B port map(mascara_gaussiana(0,0), janela_p_filtro(0,0), p1);
m2 : Multiplicador8B16B port map(mascara_gaussiana(0,1), janela_p_filtro(0,1), p2);
m3 : Multiplicador8B16B port map(mascara_gaussiana(0,2), janela_p_filtro(0,2), p3);
m4 : Multiplicador8B16B port map(mascara_gaussiana(1,0), janela_p_filtro(1,0), p4);
m5 : Multiplicador8B16B port map(mascara_gaussiana(1,1), janela_p_filtro(1,1), p5);
m6 : Multiplicador8B16B port map(mascara_gaussiana(1,2), janela_p_filtro(1,2), p6);
m7 : Multiplicador8B16B port map(mascara_gaussiana(2,0), janela_p_filtro(2,0), p7);
m8 : Multiplicador8B16B port map(mascara_gaussiana(2,1), janela_p_filtro(2,1), p8);
m9 : Multiplicador8B16B port map(mascara_gaussiana(2,2), janela_p_filtro(2,2), p9);

end comportamental;