-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "11/18/2015 21:55:21"
                                                            
-- Vhdl Test Bench template for design  :  ProcessadorImagemGMAW
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.common.all;
use work.imagensteste.all;

ENTITY ProcessadorImagemGMAW_TB IS
END ProcessadorImagemGMAW_TB;
ARCHITECTURE ProcessadorImagemGMAW_arch OF ProcessadorImagemGMAW_TB IS
-- constants                                                 

-- signals
CONSTANT LinePause : integer := 5;
CONSTANT IntegrationCPRE : integer := 107;
SIGNAL ENDSIM : STD_LOGIC := '0';
SIGNAL temp : STD_LOGIC := '0';
SIGNAL clk_count : natural := 0;
SIGNAL brilho_maximo : UNSIGNED(24 DOWNTO 0);
SIGNAL threshold1    : std_logic_vector(7 downto 0);
SIGNAL meioVert      : unsigned(7 downto 0);
SIGNAL meioImagem    : unsigned(7 downto 0);
SIGNAL in_clock : STD_LOGIC;
SIGNAL FVAL_teste : STD_LOGIC;
SIGNAL LVAL_teste : STD_LOGIC;
SIGNAL RX : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
SIGNAL pixel_entrada : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
SIGNAL bloco_atual : natural range qtd_imagens downto 0 := 0;
SIGNAL linha : integer range 0 to numcols - 1 := 0;
SIGNAL coluna : integer range 0 to numlin - 1 := 0;
SIGNAL reset : STD_LOGIC;
SIGNAL start_stop :  STD_LOGIC;
SIGNAL contador12b : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL qtd_imagens : UNSIGNED(1 DOWNTO 0) := "11";
SIGNAL frequencia_camera : real := 85.000E6;
SIGNAL periodo : real := 12.000E-8;

SIGNAL after_line : integer range 0 to LinePause := 0;
--SIGNAL inicio_imagem : STD_LOGIC := '0';
SIGNAL inicio_imagem : integer range 0 to IntegrationCPRE := 0;


COMPONENT ProcessadorImagemGMAW
  PORT (
  in_clock      : in std_logic;                                       -- clock gerado pela camera
  FVAL_teste    : in std_logic;                                       -- para simulacao
  LVAL_teste    : in std_logic;                                       -- para simulacao
  RX            : in std_logic_vector(3 downto 0);                    -- canais de dados
  brilho_maximo : in unsigned(24 downto 0) := to_unsigned(720000,25);
  threshold1    : in std_logic_vector(7 downto 0);
  meioVert      : in unsigned(7 downto 0);
  meioImagem    : in unsigned(7 downto 0);
  pixel_entrada : in std_logic_vector(7 downto 0) := "00000000";      -- para simulacao
  limEsqPoca    : out natural range numcols downto 0;
  limDirPoca    : out natural range numcols downto 0);  
END COMPONENT;


-- Procedure for clock generation
  procedure clk_gen(signal clk : out std_logic; constant FREQ : real) is
    constant PERIOD    : time := 1 sec / FREQ;        -- Full period
    constant HIGH_TIME : time := PERIOD / 2;          -- High time
    constant LOW_TIME  : time := PERIOD - HIGH_TIME;  -- Low time; always >= HIGH_TIME
  begin
    -- Check the arguments
    assert (HIGH_TIME /= 0 fs) report "clk_plain: High time is zero; time resolution to large for frequency" severity FAILURE;
    -- Generate a clock cycle
    loop
      if (ENDSIM = '0') then
        clk <= '1';
        wait for HIGH_TIME;
        clk <= '0';
        wait for LOW_TIME;
      else
        wait;
      end if;
    end loop;
  end procedure;



BEGIN
  -- Clock generation with concurrent procedure call
  clk_gen(in_clock, frequencia_camera);  -- 166.667 MHz clock
  -- Time resolution show
  assert FALSE report "Time resolution: " & time'image(time'succ(0 fs)) severity NOTE;



  i1 : ProcessadorImagemGMAW
  PORT MAP (
-- list connections between master ports and signals
  brilho_maximo => brilho_maximo,
  threshold1 => threshold1,
  meioVert => meioVert,
  meioImagem => meioImagem,
  in_clock => in_clock,
  RX => RX,
  FVAL_teste => FVAL_teste,
  LVAL_teste => LVAL_teste,
  pixel_entrada => pixel_entrada
  );

brilho_maximo <= to_unsigned(720000,25) after 0 ns;
threshold1    <= "00001010" after 0 ns;
meioVert      <= to_unsigned(30,8) after 0 ns;
meioImagem    <= to_unsigned(31,8) after 0 ns;

-- usando um line pause de 5 ciclos
-- e tempos de integration + CPRE de 100 ciclos
FVAL_teste <= '1' after 10 * (1 sec / frequencia_camera),   -- imagem 0
             --'0' after 4025 * (1 sec / frequencia_camera),
             '0' after 3955 * (1 sec / frequencia_camera),
             '1' after 4055 * (1 sec / frequencia_camera),  -- imagem 1
             '0' after 8000 * (1 sec / frequencia_camera),
             '1' after 8100 * (1 sec / frequencia_camera),  -- imagem 2
             '0' after 12075 * (1 sec / frequencia_camera),
             '1' after 12175 * (1 sec / frequencia_camera), -- imagem 3
             '0' after 16090 * (1 sec / frequencia_camera);

bloco_atual <= 0 after 10 * (1 sec / frequencia_camera),
               1 after 4015 * (1 sec / frequencia_camera),
               2 after 8030 * (1 sec / frequencia_camera),
               3 after 12045 * (1 sec / frequencia_camera);

IN_process: process (in_clock) begin
  if(rising_edge(in_clock)) then
    clk_count <= clk_count + 1;

    -- avanca as imagens
    case bloco_atual is
      when 0 => pixel_entrada <= STD_LOGIC_VECTOR(imagem_teste0(linha, coluna));
      when 1 => pixel_entrada <= STD_LOGIC_VECTOR(imagem_teste1(linha, coluna));
      when 2 => pixel_entrada <= STD_LOGIC_VECTOR(imagem_teste2(linha, coluna));
      when 3 => pixel_entrada <= STD_LOGIC_VECTOR(imagem_teste3(linha, coluna));
      when others => pixel_entrada <= STD_LOGIC_VECTOR(imagem_teste0(linha, coluna));
    end case;

    -- marcacao de linhas, colunas e parada na simulacao
  --  if (coluna = numcols - 1) then
  --    LVAL_teste <= '0';
  --    if (after_line /= LinePause-1) and (after_imagem = 0) then
  --      after_line <= after_line + 1;
  --    else
  --      if (linha = numlin -1) then
  --        if (after_imagem /= IntegrationCPRE-1) then
  --          after_imagem <= after_imagem + 1;
  --        else 
  --          after_imagem <= 0;
  --          linha <= 0;
  --          --fim_imagem <= '1';
  --        end if;
  --      else
  --        coluna <= 0;
  --        after_line <= 0;
  --        LVAL_teste <= '1';
  --        linha <= linha + 1;
  --      end if;    
  --    end if;
  --  else
  --    if (after_line = 0) then
  --      coluna <= coluna + 1;
  --    end if;
  --  end if;

  --  if (clk_count = 4 * (numlin * numcols)) then
  --    ENDSIM <= '1';
  --  end if;
  --end if;
  
  -- durante imagem
    clk_count <= clk_count + 1;
    if (FVAL_teste = '1') then
      if (inicio_imagem /= IntegrationCPRE - 1) then
        coluna <= 0;
        linha <= 0;
        after_line <= 0;
        inicio_imagem <= inicio_imagem + 1;
        if (inicio_imagem < IntegrationCPRE - 2) then
          LVAL_teste <= '0';
        else
          LVAL_teste <= '1';
        end if;
      else
        if (coluna = numcols - 1) then
          LVAL_teste <= '0';
          if (after_line /= LinePause-1) then
            after_line <= after_line + 1;
          else
            after_line <= 0;
            coluna <= 0;
            if (linha /= numlin -1) then
              LVAL_teste <= '1';
              linha <= linha + 1;
            else
              linha <= 0;
            end if;
          end if;
        else
          if (after_line = 0) then
            coluna <= coluna + 1;
          end if;
        end if;
      end if;
    else
      LVAL_teste <= '0';
      inicio_imagem <= 0;
    end if;



    
  end if;



--when -label end_of_simulation {end_of_sim == '1'} {echo "End of simulation" ; stop ;}
end process;


END ProcessadorImagemGMAW_arch;