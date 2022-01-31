----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2021 04:19:13 PM
-- Design Name: 
-- Module Name: UART - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use     ieee.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



-- M

entity uart is
	generic(
		DBIT: integer := 8;     -- # data bits
		SB_TICK: integer := 32; -- # ticks de parada
										-- 32/48/64 para 11/1.5/2 bits
		DVSR: integer := 407;   -- divisor de ticks
										-- = clk/(32*baudrate)
		DVSR_BIT: integer := 9; -- # bits de DVSR
		FIFO_W: integer := 4    -- # bits de direccion del fifo
										-- # palabras en FIFO = 2^FIFO_W
	);
	port(
		clk, reset: in std_logic;
		rd_uart, wr_uart: in std_logic; -- Para el FIFO
		rx: in std_logic;
		w_data: in std_logic_vector(DBIT-1 downto 0);
		tx_full, rx_empty: out std_logic;
		r_data: out std_logic_vector(DBIT-1 downto 0);
		tx: out std_logic
	);
end uart;

 architecture str_Behavioral of uart is
	signal tick: std_logic;
	signal rx_done_tick: std_logic;
	signal tx_fifo_out: std_logic_vector(DBIT-1 downto 0);
	signal rx_data_out: std_logic_vector(DBIT-1 downto 0);
	signal tx_empty, tx_fifo_not_empty: std_logic;
	signal tx_done_tick: std_logic;

begin
	baud_gen_unit: entity work.baud_gen(Behavioral)
		generic map(M=>DVSR, MBITS=>DVSR_BIT)
		port map(clk=>clk, reset=>reset,baud_ticks=>tick);
	
	uart_rx_unit: entity work.uart_rx(Behavioral)
		generic map(NBITS=>DBIT, bit_stop=>SB_TICK)
		port map(clk=>clk, reset=>reset, rx=>rx,
				baud_rate=>tick, rx_done_tick=>rx_done_tick,
				d_out=>rx_data_out);
	fifo_rx_unit: entity work.fifo(Behavioral)
		generic map(NBITS=>DBIT, W=>FIFO_W)
		port map(clk=>clk, reset=>reset, read=>rd_uart,
				write=>rx_done_tick, write_data=>rx_data_out,
				empty=>rx_empty, full=>open, read_data=>r_data);
				
	fifo_tx_unit: entity work.fifo(Behavioral)
		generic map(NBITS=>DBIT, W=>FIFO_W)
		port map(clk=>clk, reset=>reset, read=>tx_done_tick,
				write=>wr_uart, write_data=>w_data,
				empty=>tx_empty, full=>tx_full, read_data=>tx_fifo_out);
				
	uart_tx_unit: entity work.uart_tx(Behavioral)
		generic map(NBITS=>DBIT, BIT_STOP=>SB_TICK)
		port map(clk=>clk, reset=>reset, tx_start=>tx_fifo_not_empty,
				baud_rate => tick, d_in=>tx_fifo_out,
				tx_done_tick=>tx_done_tick, tx=>tx);
	tx_fifo_not_empty <= not tx_empty;
end str_Behavioral;