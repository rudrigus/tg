-- Contador em VHDL

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CONTADOR is
port  ( 
  CLK         : in std_logic;
  reset       : in std_logic;
  start_stop  : in std_logic;
  binario12bits : buffer std_logic_vector(11 downto 0) := "000000000000");
end CONTADOR;

architecture CONTA of CONTADOR is

-- signal COUNT : unsigned(11 downto 0):= (others=>'0');
-- Para um clock de 25 MHz / 2^24 -> periodo de 671 mseg
signal DIVISOR : std_logic_vector(23 downto 0);
signal INT_CLK : std_logic;

begin

DIV_CLK: process (CLK)
begin
 if (CLK'event and CLK = '1') then
   DIVISOR <= DIVISOR + 1;
 end if;
end process DIV_CLK;

-- INT_CLK <= DIVISOR(23);
INT_CLK <= CLK;



R_COUNT: process(INT_CLK)
begin
  if reset = '1' then
    binario12bits <= "000000000000";
  elsif start_stop = '1' then
    if (INT_CLK'event and INT_CLK = '1') then
      binario12bits <= binario12bits + 1;
    end if;
  end if;
end process R_COUNT;

end CONTA;
