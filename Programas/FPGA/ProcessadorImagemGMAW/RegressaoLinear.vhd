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
  --intervalo     : in natural range numlin downto 0;
  --signal inicioArame  : in array (0 to qtdPontosArame) of natural range numcols downto 0;
  --signal fimArame     : in array (0 to qtdPontosArame) of natural range numcols downto 0;
  observacoes   : in vetorVert := (others => 0);
  R             : out coeficientesReta);
end RegressaoLinear;

architecture comportamental of RegressaoLinear is
--signal i             : natural;-- range numlin downto 0 := 0;
signal i             : natural := 0;
signal j             : natural range qtdPontosArame downto 0 := 0;
--signal intervalo     : natural := 0;
signal intervalo     : natural := 0;
signal fim           : natural range numlin downto 0 := 0;
signal mult1         : unsigned(31 downto 0) := (others => '0');
signal mult2         : unsigned(31 downto 0) := (others => '0');
signal mult3         : unsigned(31 downto 0) := (others => '0');
signal mult4         : unsigned(31 downto 0) := (others => '0');
signal somatorio_di  : natural := 0;
signal somatorio_idi : natural := 0;

signal teste1 : natural;
signal teste2 : natural;
signal teste3 : natural;
signal teste4 : natural;
signal teste5 : natural;
signal teste6 : natural;
signal teste7 : natural;
signal teste8 : natural;
signal teste9 : natural;
signal teste10 : natural;
signal teste11 : natural;
signal teste12 : natural;
signal teste13 : natural;
signal teste14 : natural;
signal teste15 : natural;
signal teste16 : natural;
signal teste17 : natural;
signal teste18 : natural;
signal teste19 : natural;
signal teste20 : natural;
signal teste21 : natural;
signal teste22 : natural;
signal teste23 : natural;
signal teste24 : natural;
signal teste25 : natural;
signal teste26 : natural;
signal teste27 : natural;
signal teste28 : natural;
signal teste29 : natural;
signal teste30 : natural;
signal teste31 : natural;
signal teste32 : natural;

begin

  --process(FVAL) begin
  --end process;
  
  process(in_clock,FVAL) begin
    if(falling_edge(FVAL)) then
      -- fazer um shift de 4 para a direita depois de multiplicar intervalo: para aumentar a precisao
      intervalo <= (posArameBase - posArameTopo - afastamento - afastamento);
      --intervalo <= real((posArameBase - posArameTopo - afastamento - afastamento) / qtdPontosArame);
      --intervalo <= 1;
      i <= posArameTopo + afastamento;
      fim <= posArameBase - afastamento;
      --if(rising_edge(calcular)) then
      --end if;
    --if(calcular='1') then
      for j in 0 to qtdPontosArame loop
      --while (j <= qtdPontosArame) and (i <= fim + afastamento) loop
        exit when j > qtdPontosArame;
        --exit when integer(i) > fim;
        --somatorio_idi  <= somatorio_idi + (i * observacoes(integer(i)));
        --somatorio_di <= somatorio_di + observacoes(integer(i));
        --i <= i + intervalo;
      end loop;
    --end if;

 teste1 <= (i) ;
 teste2 <= (i + to_integer("0000" & to_unsigned(intervalo,     32)(31 downto 4)));
 teste3 <= (i + to_integer("0000" & to_unsigned(intervalo * 2, 32)(31 downto 4)));
 teste4 <= (i + to_integer("0000" & to_unsigned(intervalo * 3, 32)(31 downto 4)));
 teste5 <= (i + to_integer("0000" & to_unsigned(intervalo * 4, 32)(31 downto 4)));
 teste6 <= (i + to_integer("0000" & to_unsigned(intervalo * 5, 32)(31 downto 4)));
 teste7 <= (i + to_integer("0000" & to_unsigned(intervalo * 6, 32)(31 downto 4)));
 teste8 <= (i + to_integer("0000" & to_unsigned(intervalo * 7, 32)(31 downto 4)));
 teste9 <= (i + to_integer("0000" & to_unsigned(intervalo * 8, 32)(31 downto 4)));
teste10 <= (i + to_integer("0000" & to_unsigned(intervalo * 9, 32)(31 downto 4)));
teste11 <= (i + to_integer("0000" & to_unsigned(intervalo * 10,32)(31 downto 4)));
teste12 <= (i + to_integer("0000" & to_unsigned(intervalo * 11,32)(31 downto 4)));
teste13 <= (i + to_integer("0000" & to_unsigned(intervalo * 12,32)(31 downto 4)));
teste14 <= (i + to_integer("0000" & to_unsigned(intervalo * 13,32)(31 downto 4)));
teste15 <= (i + to_integer("0000" & to_unsigned(intervalo * 14,32)(31 downto 4)));
teste16 <= (i + to_integer("0000" & to_unsigned(intervalo * 15,32)(31 downto 4)));


      somatorio_idi  <=       observacoes(i) +
                        (     observacoes(i + to_integer("0000" & to_unsigned(intervalo,     32)(31 downto 4)))) +
                        (2 * (observacoes(i + to_integer("0000" & to_unsigned(intervalo * 2, 32)(31 downto 4))))) +
                        (3 * (observacoes(i + to_integer("0000" & to_unsigned(intervalo * 3, 32)(31 downto 4))))) +
                        (4 * (observacoes(i + to_integer("0000" & to_unsigned(intervalo * 4, 32)(31 downto 4))))) +
                        (5 * (observacoes(i + to_integer("0000" & to_unsigned(intervalo * 5, 32)(31 downto 4))))) +
                        (6 * (observacoes(i + to_integer("0000" & to_unsigned(intervalo * 6, 32)(31 downto 4))))) +
                        (7 * (observacoes(i + to_integer("0000" & to_unsigned(intervalo * 7, 32)(31 downto 4))))) +
                        (8 * (observacoes(i + to_integer("0000" & to_unsigned(intervalo * 8, 32)(31 downto 4))))) +
                        (9 * (observacoes(i + to_integer("0000" & to_unsigned(intervalo * 9, 32)(31 downto 4))))) +
                        (10 *(observacoes(i + to_integer("0000" & to_unsigned(intervalo * 10,32)(31 downto 4))))) +
                        (11 *(observacoes(i + to_integer("0000" & to_unsigned(intervalo * 11,32)(31 downto 4))))) +
                        (12 *(observacoes(i + to_integer("0000" & to_unsigned(intervalo * 12,32)(31 downto 4))))) +
                        (13 *(observacoes(i + to_integer("0000" & to_unsigned(intervalo * 13,32)(31 downto 4))))) +
                        (14 *(observacoes(i + to_integer("0000" & to_unsigned(intervalo * 14,32)(31 downto 4))))) +
                        (15 *(observacoes(i + to_integer("0000" & to_unsigned(intervalo * 15,32)(31 downto 4)))));
      somatorio_di  <= observacoes(i) +
                       observacoes(i + to_integer("0000" & to_unsigned(intervalo,     32)(31 downto 4))) +
                       observacoes(i + to_integer("0000" & to_unsigned(intervalo * 2, 32)(31 downto 4))) +
                       observacoes(i + to_integer("0000" & to_unsigned(intervalo * 3, 32)(31 downto 4))) +
                       observacoes(i + to_integer("0000" & to_unsigned(intervalo * 4, 32)(31 downto 4))) +
                       observacoes(i + to_integer("0000" & to_unsigned(intervalo * 5, 32)(31 downto 4))) +
                       observacoes(i + to_integer("0000" & to_unsigned(intervalo * 6, 32)(31 downto 4))) +
                       observacoes(i + to_integer("0000" & to_unsigned(intervalo * 7, 32)(31 downto 4))) +
                       observacoes(i + to_integer("0000" & to_unsigned(intervalo * 8, 32)(31 downto 4))) +
                       observacoes(i + to_integer("0000" & to_unsigned(intervalo * 9, 32)(31 downto 4))) +
                       observacoes(i + to_integer("0000" & to_unsigned(intervalo * 10,32)(31 downto 4))) +
                       observacoes(i + to_integer("0000" & to_unsigned(intervalo * 11,32)(31 downto 4))) +
                       observacoes(i + to_integer("0000" & to_unsigned(intervalo * 12,32)(31 downto 4))) +
                       observacoes(i + to_integer("0000" & to_unsigned(intervalo * 13,32)(31 downto 4))) +
                       observacoes(i + to_integer("0000" & to_unsigned(intervalo * 14,32)(31 downto 4))) +
                       observacoes(i + to_integer("0000" & to_unsigned(intervalo * 15,32)(31 downto 4)));
    end if;

  end process;



  mult1 <= to_unsigned(constRegressao1 * somatorio_idi, 32);
  mult2 <= to_unsigned(constRegressao2 * somatorio_di,  32);
  mult3 <= to_unsigned(constRegressao3 * somatorio_di,  32);
  mult4 <= to_unsigned(constRegressao2 * somatorio_idi, 32);
  -- R(0) <= to_integer("00000000000000000000000000" & (to_unsigned(mult1,10)(31 downto 22))) - to_integer("00000000000000000000000" & (to_unsigned(mult2,13)(31 downto 19)));
  --R(1) <= to_integer("00000000000000000000" & to_unsigned(mult3,16)(31 downto 16)) - to_integer("00000000000000000000000" & to_unsigned(mult4,13)(31 downto 19));
  R(0) <= to_integer("00000000000000000000000000" & (mult1(31 downto 22))) - to_integer("00000000000000000000000" & (mult2(31 downto 19)));
  R(1) <= to_integer("00000000000000000000" & mult3(31 downto 16)) - to_integer("00000000000000000000000" & mult4(31 downto 19));

end comportamental;