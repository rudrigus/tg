library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.common.all;

entity Multiplicador8B16B is
  port (
  a : in std_logic_vector(7 downto 0)   := (others => '0');
  b : in std_logic_vector(7 downto 0)   := (others => '0');
  p : out std_logic_vector(15 downto 0) := (others => '0'));
  end Multiplicador8B16B;


architecture comportamental of Multiplicador8B16B is
begin
  p <= a * b;

end comportamental;