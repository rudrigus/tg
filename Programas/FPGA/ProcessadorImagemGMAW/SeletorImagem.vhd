library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.common.all;

entity SeletorImagem is
  port (
  brilho_maximo : in unsigned(24 downto 0) := (others => '0');
  in_clock      : in std_logic;
  pixel_entrada : in std_logic_vector(7 downto 0) := (others => '0');
  processar     : in std_logic;
  coluna        : in natural range (numcols - 1) downto 0 := 0;
  linha         : in natural range (numlin - 1) downto 0 := 0;
  bloco_atual      : buffer unsigned(1 downto 0) := "00";
  endereco_leitura : buffer unsigned(15 downto 0) := (others => '0');
  endereco_escrita : buffer unsigned(15 downto 0) := (others => '0'));
end SeletorImagem;


architecture comportamental of SeletorImagem is
  signal soma_imagem : natural := 0;

begin
process(coluna,linha,in_clock) begin
  
  if(rising_edge(in_clock)) then
    if(linha = 0 and coluna = 0) then
      soma_imagem <= 0;
    else
      if (linha = numlin-2 and coluna = numcols - 2) then
        -- arrumar enderecos de leitura e escrita
        endereco_escrita <= to_unsigned(to_integer(bloco_atual) + 2,2) & "00000000000000";
        endereco_leitura <= to_unsigned(to_integer(bloco_atual) + 1,2) & "00000000000000";
        if (soma_imagem < brilho_maximo) then
          -- passa para próximo bloco apenas se a imagem tem brilho menor que máximo
          bloco_atual <= bloco_atual + "01";
        end if;
      else
        if(processar='1') then
          soma_imagem <= soma_imagem + to_integer(unsigned(pixel_entrada));
          endereco_escrita <= endereco_escrita + 1;
          endereco_leitura <= endereco_leitura + 1;
        end if;
      end if;
    end if;  
  end if;

end process;

end comportamental;