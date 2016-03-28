library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.common.all;
use work.imagensteste.all;
--use work.imagensteste.all;

entity ProcessadorImagemGMAW is
  port (
  in_clock      : in std_logic;                                       -- clock gerado pela camera
  FVAL_teste    : in std_logic;                                       -- para simulacao
  LVAL_teste    : in std_logic;                                       -- para simulacao
  --RX            : in std_logic_vector(3 downto 0);                    -- canais de dados
  brilho_maximo : in unsigned(24 downto 0) := to_unsigned(720000,25);
  meioVert      : in unsigned(7 downto 0);
  meioHor       : in unsigned(7 downto 0);
  afastamento   : in natural range numlin downto 0 := 0;
  pixel_entrada : in std_logic_vector(7 downto 0) := "00000000");      -- para simulacao
end ProcessadorImagemGMAW;


architecture comportamental of ProcessadorImagemGMAW is
signal strobe           : std_logic;
signal processar        : std_logic;
--signal clock_7          : std_logic;
signal FVAL             : std_logic;
signal LVAL             : std_logic;
signal coluna           : natural range (numcols - 1) downto 0 := 0;
signal linha            : natural range (numlin - 1) downto 0 := 0;
signal colunafiltro     : natural range (numcols - 1) downto 0 := 0;
signal linhafiltro      : natural range (numlin - 1) downto 0 := 0;
signal dados_palavra    : STD_LOGIC_VECTOR (27 DOWNTO 0); -- Dados desserializados
signal pixel_desserial  : std_logic_vector(7 downto 0); -- para substituir o pixel_entrada quando funcionar com a camera
signal bloco_atual      : unsigned(1 downto 0) := "00";
signal endereco_escrita : unsigned(15 downto 0) := "0000000000000000";
signal endereco_leitura : unsigned(15 downto 0) := "0000000000000000";
--signal ativar_escrita : std_logic  := '0';
signal q                : std_logic_vector(7 downto 0);
signal pixel_filtrado0  : std_logic_vector(7 downto 0);
signal pixel_filtrado1  : std_logic_vector(7 downto 0);
signal pixel_filtrado2  : std_logic_vector(7 downto 0);
signal pixel_filtrado3  : std_logic_vector(7 downto 0);
signal limEsqPoca       : natural range numcols downto 0;
signal limDirPoca       : natural range numcols downto 0;


--signal inicioArame  : array (0 to qtdPontosArame) of natural range numcols downto 0;
--signal fimArame     : array (0 to qtdPontosArame) of natural range numcols downto 0;
signal inicioArame  : vetorVert := (others => 0);
signal fimArame     : vetorVert := (others => 0);
signal posArameTopo : natural range numlin downto 0 :=0 ;
signal posArameBase : natural range numlin downto 0;

signal intervalo    : natural range numlin downto 0;

signal ladoEsqArame : coeficientesReta;
signal ladoDirArame : coeficientesReta;


--component ReceptorDados IS
--  PORT
--  (
--    in_clock : in std_logic;                                       -- clock gerado pela camera
--    RX       : in std_logic_vector(3 downto 0);                    -- canais de dados seriais
--    FVAL     : out std_logic;
--    LVAL     : out std_logic;
--    pixel    : out std_logic_vector(7 downto 0) := "00000000"
--  );
--END component;

component Controlador
  port(
  in_clock         : in std_logic;
  FVAL             : in std_logic;
  LVAL             : in std_logic;
  processar        : out std_logic := '0';
  coluna           : buffer natural range (numcols - 1) downto 0 := 0;
  linha            : buffer natural range (numlin - 1) downto 0 := 0;
  colunaFiltro     : buffer natural range (numcols - 1) downto 0 := 0;
  linhaFiltro      : buffer natural range (numlin - 1) downto 0 := 0);
end component;

component FiltroGaussiana is
  port (
  in_clock         : in std_logic;
  FVAL             : in std_logic;
  LVAL             : in std_logic;
  coluna           : in natural range (numcols - 1) downto 0 := 0;
  linha            : in natural range (numlin - 1) downto 0 := 0;
  pixel_entrada    : in std_logic_vector(7 downto 0) := (others => '0');
  pixel_filtrado   : out std_logic_vector(7 downto 0) := (others => '0'));
end component;


component ImagensRAM
  PORT(
    clock   : IN STD_LOGIC  := '1';
    data    : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    rdaddress   : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    wraddress   : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    wren    : IN STD_LOGIC  := '0';
    q   : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END component;

component SeletorImagem
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
end component;

component MedidasArame
  port(
  meioVert         : in unsigned(7 downto 0);
  meioHor          : in unsigned(7 downto 0);
  in_clock         : in std_logic;
  coluna           : in natural range (numcols - 1) downto 0 := 0;
  linha            : in natural range (numlin - 1) downto 0 := 0;
  pixel_entrada    : in std_logic_vector(7 downto 0) := "00000000";
  q                : in std_logic_vector(7 downto 0);
  inicioArame   : buffer vetorVert;
  fimArame      : buffer vetorVert;
  posArameTopo  : out natural range numlin downto 0;
  posArameBase  : out natural range numlin downto 0);
end component;

component BordasPoca
  port(
  meioHor       : in unsigned(7 downto 0);
  in_clock      : in std_logic;
  coluna        : in natural range (numcols - 1) downto 0 := 0;
  linha         : in natural range (numlin - 1) downto 0 := 0;
  pixel_entrada : in std_logic_vector(7 downto 0) := "00000000";
  q             : in std_logic_vector(7 downto 0);
  limEsqPoca    : out natural range numcols downto 0;
  limDirPoca    : out natural range numcols downto 0);
end component;

component RegressaoLinear
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
end component;

begin
  strobe <= in_clock;
  --receptor : ReceptorDados port map(in_clock, RX, FVAL, LVAL, pixel_desserial);
  
  -- threshold1
  pixel_filtrado0 <= "00000000" when pixel_entrada < threshold1 else
                  pixel_entrada;
  pixel_filtrado2 <= "00000000" when pixel_filtrado1 < threshold2 else
                     pixel_filtrado1;
  pixel_filtrado3 <= threshold3 when pixel_filtrado2 > threshold3 else
                  pixel_filtrado2;
  

  ram : ImagensRAM port map(strobe, pixel_filtrado0, std_logic_vector(endereco_leitura), std_logic_vector(endereco_escrita), strobe, q); -- Entrada está sempre indo para a memoria
  controlador1 : Controlador port map(strobe, FVAL_teste, LVAL_teste, processar, coluna, linha, colunaFiltro, linhaFiltro);
  filtro_gaussiana: FiltroGaussiana port map(strobe, FVAL_teste, LVAL_teste, coluna, linha, pixel_filtrado0, pixel_filtrado1);
  seletor_imagem : SeletorImagem port map(brilho_maximo, strobe, pixel_filtrado1, processar, coluna, linha, bloco_atual, endereco_escrita, endereco_leitura);
  bordas_poca : BordasPoca port map(meioHor, strobe, colunaFiltro, linhaFiltro, pixel_filtrado3, q, limEsqPoca, limDirPoca);
  medidas_arame : MedidasArame port map(meioVert, meioHor, strobe, colunaFiltro, linhaFiltro, pixel_filtrado2, q, inicioArame, fimArame, posArameTopo, posArameBase);
  
  regressao_linear1 : RegressaoLinear port map(meioHor, afastamento, strobe, FVAL_teste, posArameTopo, posArameBase, inicioArame, ladoEsqArame);

end comportamental;