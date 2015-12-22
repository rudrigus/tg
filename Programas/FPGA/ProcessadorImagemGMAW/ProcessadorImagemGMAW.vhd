library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.common.all;

entity ProcessadorImagemGMAW is
  port (
  in_clock      : in std_logic;
  --in_linha      : in std_logic;
  in_janela     : in std_logic;
  brilho_maximo : in unsigned(24 downto 0) := to_unsigned(720000,25);
  meioVert      : in unsigned(7 downto 0) := to_unsigned(30,8);
  meio_imagem   : in unsigned(7 downto 0) := to_unsigned(31,8);
  pixel_entrada : in std_logic_vector(7 downto 0) := "00000000";
  limEsqPoca    : out natural range numcols downto 0;
  limDirPoca    : out natural range numcols downto 0);
end ProcessadorImagemGMAW;


architecture comportamental of ProcessadorImagemGMAW is
signal bloco_atual      : natural range qtd_imagens downto 0 := 0;
signal endereco_escrita : unsigned(13 downto 0) := "00000000000000";
signal endereco_leitura : unsigned(13 downto 0) := "00000000000000";
--signal ativar_escrita : std_logic  := '0';
signal q                : std_logic_vector(7 downto 0);
signal data             : std_logic_vector(7 downto 0);

signal posArameTopo : natural range numlin downto 0;
signal posArameBase : natural range numlin downto 0;


component ImagensRAM
  PORT(
    clock   : IN STD_LOGIC  := '1';
    data    : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    rdaddress   : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
    wraddress   : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
    wren    : IN STD_LOGIC  := '0';
    q   : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END component;

component SeletorImagem
  port(
  brilho_maximo : in unsigned(24 downto 0); 
  in_clock      : in std_logic;
  in_janela     : in std_logic;
  pixel_entrada : in std_logic_vector(7 downto 0) := "00000000";
  bloco_atual   : inout natural range qtd_imagens downto 0;
  endereco_escrita : inout unsigned(13 downto 0) := (others => '0'));
end component;

component TopoBase
  port(
  meioVert      : in unsigned(7 downto 0);
  in_clock      : in std_logic;
  in_janela     : in std_logic;
  pixel_entrada : in std_logic_vector(7 downto 0) := "00000000";
  bloco_atual   : in natural range qtd_imagens downto 0;
  q                : in std_logic_vector(7 downto 0);
  endereco_leitura : inout unsigned(13 downto 0);
  posArameTopo  : out natural range numlin downto 0;
  posArameBase  : out natural range numlin downto 0);
end component;

component Bordas
  port(
  meio_imagem   : in unsigned(7 downto 0);
  in_clock      : in std_logic;
  in_janela     : in std_logic;
  pixel_entrada : in std_logic_vector(7 downto 0) := "00000000";
  bloco_atual   : in natural range qtd_imagens downto 0;
  limEsqPoca    : out natural range numcols downto 0;
  limDirPoca    : out natural range numcols downto 0);
end component;

begin
  -- Entrada está sempre indo para a memoria
  ram : ImagensRAM port map(in_clock, pixel_entrada, std_logic_vector(endereco_leitura), std_logic_vector(endereco_escrita), in_clock, q);
  bloco_receptor: SeletorImagem port map(brilho_maximo, in_clock, in_janela, pixel_entrada, bloco_atual, endereco_escrita);
  bloco_topo_base: TopoBase port map(meioVert, in_clock, in_janela, pixel_entrada, bloco_atual, q, endereco_leitura, posArameTopo, posArameBase);
  --bloco_bordas: Bordas port map(meio_imagem, in_clock, in_janela, pixel_entrada, bloco_atual, limEsqPoca, limDirPoca);



end comportamental;