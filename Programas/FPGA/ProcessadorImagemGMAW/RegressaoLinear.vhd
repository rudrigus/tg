--Regressao Linear baseada no trabalho Area-Efficient Linear Regression Architecture for Real-Time
--Signal Processing on FPGAs

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.common.all;

entity RegressaoLinear is 
  port(
  meioHor       : in unsigned(7 downto 0);
  afastamento   : in natural range numlin downto 0 := 0;
  in_clock      : in std_logic;
  FVAL          : in std_logic;
  posArameTopo  : in natural range numlin downto 0;
  posArameBase  : in natural range numlin downto 0;
  intervalo     : in natural range numlin downto 0;
  --signal inicioArame  : in array (0 to qtdPontosArame) of natural range numcols downto 0;
  --signal fimArame     : in array (0 to qtdPontosArame) of natural range numcols downto 0;
  observacoes   : in vetorVert := (others => 0);
  R             : out coeficientesReta);
end RegressaoLinear;

architecture comportamental of RegressaoLinear is
signal i             : natural;-- range numlin downto 0 := 0;
signal j             : natural range qtdPontosArame downto 0 := 0;
--signal intervalo     : natural := 0;
signal fim           : natural range numlin downto 0 := 0;
signal mult1         : unsigned(31 downto 0) := (others => '0');
signal mult2         : unsigned(31 downto 0) := (others => '0');
signal mult3         : unsigned(31 downto 0) := (others => '0');
signal mult4         : unsigned(31 downto 0) := (others => '0');
signal somatorio_di  : natural := 0;
signal somatorio_idi : natural := 0;

begin

  --intervalo <= (posArameBase - posArameTopo - afastamento - afastamento) srl 4;
  process(in_clock,FVAL) begin
    if(falling_edge(FVAL)) then
    fim <= posArameBase - afastamento;
      i <= posArameTopo + afastamento;
      for j in 0 to qtdPontosArame loop
      --while (j <= qtdPontosArame) and (i <= fim + afastamento) loop
        exit when i > fim;
        exit when j > qtdPontosArame;
        somatorio_di  <= somatorio_di + (i * observacoes(i));
        somatorio_idi <= somatorio_idi + i;
        i <= i + intervalo;
      end loop;
    end if;
  end process;

  mult1 <= to_unsigned(constRegressao1 * somatorio_idi, 32);
  mult2 <= to_unsigned(constRegressao2 * somatorio_di, 32);
  mult3 <= to_unsigned(constRegressao3 * somatorio_di, 32);
  mult4 <= to_unsigned(constRegressao2 * somatorio_idi, 32);
  -- R(0) <= to_integer("00000000000000000000000000" & (to_unsigned(mult1,10)(31 downto 22))) - to_integer("00000000000000000000000" & (to_unsigned(mult2,13)(31 downto 19)));
  --R(1) <= to_integer("00000000000000000000" & to_unsigned(mult3,16)(31 downto 16)) - to_integer("00000000000000000000000" & to_unsigned(mult4,13)(31 downto 19));
  R(0) <= to_integer("00000000000000000000000000" & (mult1(31 downto 22))) - to_integer("00000000000000000000000" & (mult2(31 downto 19)));
  R(1) <= to_integer("00000000000000000000" & mult3(31 downto 16)) - to_integer("00000000000000000000000" & mult4(31 downto 19));

end comportamental;