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
-- Generated on "12/01/2015 11:44:04"
                                                            
-- Vhdl Test Bench template for design  :  ProcessadorImagemGMAW
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY ProcessadorImagemGMAW_vhd_tst IS
END ProcessadorImagemGMAW_vhd_tst;
ARCHITECTURE ProcessadorImagemGMAW_arch OF ProcessadorImagemGMAW_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL brilho_maximo : STD_LOGIC_VECTOR(24 DOWNTO 0);
SIGNAL in_clock : STD_LOGIC;
SIGNAL in_janela : STD_LOGIC;
SIGNAL pixel_entrada : STD_LOGIC_VECTOR(7 DOWNTO 0);
COMPONENT ProcessadorImagemGMAW
	PORT (
	brilho_maximo : IN STD_LOGIC_VECTOR(24 DOWNTO 0);
	in_clock : IN STD_LOGIC;
	in_janela : IN STD_LOGIC;
	pixel_entrada : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : ProcessadorImagemGMAW
	PORT MAP (
-- list connections between master ports and signals
	brilho_maximo => brilho_maximo,
	in_clock => in_clock,
	in_janela => in_janela,
	pixel_entrada => pixel_entrada
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END ProcessadorImagemGMAW_arch;
