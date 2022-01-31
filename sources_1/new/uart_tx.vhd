----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2021 21:31:46
-- Design Name: 
-- Module Name: uart_tx - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_tx is
    generic (
        bit_stop: integer :=32; --bit de parada
        nbits: integer := 8   --number of data bits
        );
    port (
        clk, reset: in std_logic;
        tx_start: in std_logic;
        baud_rate: in std_logic;
        d_in: in std_logic_vector (nbits-1 downto 0);
        tx_done_tick: out std_logic;
        tx: out std_logic
        );
        
end uart_tx;

architecture Behavioral of uart_tx is

    type state_type is (idle, start, data, stop);      --idle es el estado inicial (inactivo en español), start, data, y stop también son estados
    signal state_reg, state_next: state_type;   
    signal s_reg, s_next: unsigned(4 downto 0);  --max bit_stop-1
    signal n_reg, n_next: unsigned(2 downto 0);  --max nbits--1
    signal b_reg, b_next: std_logic_vector(nbits-1 downto 0);
    signal tx_reg, tx_next: std_logic;
    
begin

--  registro
	process (clk,reset)
	begin
		if (reset = '1') then
			state_reg <= idle;
			s_reg <= (others =>'0');
			n_reg <= (others =>'0');
			b_reg <= (others =>'0');
			tx_reg <= '1';
		elsif (clk'event and clk='1') then
			state_reg <= state_next;
			s_reg <= s_next;
			n_reg <= n_next;
			b_reg <= b_next;
			tx_reg <= tx_next;
		end if;
	end process;
	
	
	-- Lógica 
	process (state_reg, s_reg, n_reg, b_reg, baud_rate, tx_reg,tx_start,d_in)
	begin
		state_next <= state_reg;
		s_next <= s_reg;
		n_next <= n_reg;         
		b_next <= b_reg;
		tx_next <= tx_reg;
		tx_done_tick <= '0';
		case state_reg is
			when idle =>               
				tx_next <= '1';
				if tx_start = '1' then
					state_next <= start;
					s_next <= (others => '0');
					b_next <= d_in;
				end if;
			when start =>
				tx_next <= '0';
				if (baud_rate = '1') then
					if s_reg = bit_stop-1 then 
						state_next <= data;
						s_next <= (others => '0');
						n_next <= (others => '0');
					else
						s_next <= s_reg + 1;
					end if;
				end if;
			when data =>
				tx_next <= b_reg(0);
				if (baud_rate = '1') then
					if s_reg = bit_stop-1 then -- rev 31 0 15
						s_next <= (others => '0');
						b_next <= '0' & b_reg(nbits-1 downto 1);
						if n_reg = (nbits-1) then
							state_next <= stop;
						else
							n_next <= n_reg + 1;
						end if;
					else
						s_next <= s_reg + 1;
					end if;
				end if;
			when stop =>
				tx_next <= '1';
				if (baud_rate = '1') then
					if s_reg = (bit_stop - 1) then
						state_next <= idle;
						tx_done_tick <= '1';
					else
						s_next <= s_reg + 1;
					end if;
				end if;
		end case;
	end process;
	
	-- salida de bits
	tx <= tx_reg;
	
end Behavioral;
