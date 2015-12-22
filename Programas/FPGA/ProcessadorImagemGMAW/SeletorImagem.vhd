library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.common.all;

entity SeletorImagem is
  port (
  brilho_maximo : in unsigned(24 downto 0) := (others => '0'); 
  in_clock      : in std_logic;
  in_janela     : in std_logic;
  pixel_entrada : in std_logic_vector(7 downto 0) := "00000000";
  bloco_atual   : inout natural range qtd_imagens downto 0 := 0;
  endereco_escrita : inout unsigned(13 downto 0) := (others => '0'));
  
end SeletorImagem;


architecture comportamental of SeletorImagem is
  signal soma_imagem : unsigned(25 downto 0) := (others => '0');
  signal lega : natural := 0;


  component ImagensRAM
  PORT(
    clock   : IN STD_LOGIC  := '1';
    data    : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    rdaddress   : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
    wraddress   : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
    wren    : IN STD_LOGIC  := '0';
    q   : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
  END component;

begin
--ram : ImagensRAM port map(in_clock, pixel_entrada, "00000000000000", std_logic_vector(endereco_escrita), in_clock, q);

process(in_janela,in_clock)
begin
  
  if(rising_edge(in_clock)) then
    soma_imagem <= soma_imagem + unsigned(pixel_entrada);
    if(in_janela = '1') then
      soma_imagem <= (others => '0');
-- passa para próximo bloco apenas se a imagem tem brilho menor que máximo
      if (soma_imagem < brilho_maximo) then
        bloco_atual <= bloco_atual + 1;
        lega <= lega + 1;
      end if;
      endereco_escrita <= to_unsigned(tamanho_imagem * (bloco_atual + 1), 14);
      --endereco_escrita <= unsigned(std_logic_vector(bloco_atual + 1) & "000000000000");
    else
      endereco_escrita <= endereco_escrita + 1;
    end if;  
  end if;

end process;

end comportamental;