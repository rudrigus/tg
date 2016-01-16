library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.common.all;
--use work.imagensteste.all;

entity ReceptorDados is
  port (
  in_clock : in std_logic;                                       -- clock gerado pela camera
  RX       : in std_logic_vector(3 downto 0);                    -- canais de dados seriais
  FVAL     : out std_logic;
  LVAL     : out std_logic;
  pixel    : out std_logic_vector(7 downto 0) := "00000000"
  );
end ReceptorDados;


architecture comportamental of ReceptorDados is
signal strobe           : std_logic;
signal clock_7          : std_logic;
signal dados_palavra    : STD_LOGIC_VECTOR (27 DOWNTO 0); -- Dados desserializados

component pll IS
  PORT
  (
    inclk0    : IN STD_LOGIC  := '0';
    c0        : OUT STD_LOGIC ;
    c1        : OUT STD_LOGIC
  );
END component;

component deserializer is
  port (
    rx_in        : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    rx_inclock   : IN STD_LOGIC ;
    rx_readclock : IN STD_LOGIC ;
    rx_syncclock : IN STD_LOGIC ;
    rx_out       : OUT STD_LOGIC_VECTOR (27 DOWNTO 0));
end component;

begin

  phase_lock: pll port map(in_clock, strobe, clock_7);
  deserializador: deserializer port map(RX, strobe, clock_7, clock_7, dados_palavra);
  
  FVAL  <= dados_palavra(15);
  LVAL  <= dados_palavra(16);
  pixel <= dados_palavra(27 downto 26) & dados_palavra(6 downto 1);


end comportamental;