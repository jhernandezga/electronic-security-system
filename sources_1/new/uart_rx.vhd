-- receptor para el módulo UART
-- Baudrate 9600;
-- Sampling ticks 32;
-- reloj 50MHz;
-- data bits 8;
-- stop bit ticks 32;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_rx is
	generic (
		bit_stop: integer := 32; -- # stop bit ticks
		nbits: integer := 8--number of data bits
	);
	port (
		clk, reset: in	std_logic;
		rx: in	std_logic;
		baud_rate: in	std_logic;
		rx_done_tick: out std_logic;
		d_out: out	std_logic_vector (nbits-1 downto 0)
	);
end uart_rx;


architecture Behavioral of uart_rx is
	type state_type is (idle, start, data, stop);
	signal state_reg, state_next: state_type;
	signal s_reg, s_next: unsigned(4 downto 0);  --maximum bit_stop-1, bit_stop = 32  log2(32-1)= 5          
	signal n_reg, n_next: unsigned(2 downto 0);  -- maximum nbits-1
	signal b_reg, b_next: std_logic_vector(nbits-1 downto 0);	--out bits-register
begin
	-- registro
	process (clk,reset)
	begin
		if (reset = '1') then
			state_reg <= idle;
			s_reg <= (others =>'0');
			n_reg <= (others =>'0');
			b_reg <= (others =>'0');
		elsif (clk'event and clk='1') then
			state_reg <= state_next;
			s_reg <= s_next;
			n_reg <= n_next;
			b_reg <= b_next;
		end if;
	end process;

	-- Logica FSM
	process (state_reg, s_reg, n_reg, b_reg, baud_rate, rx)
	begin
		state_next <= state_reg;
		s_next <= s_reg;
		n_next <= n_reg;
		b_next <= b_reg;
		rx_done_tick <= '0';
		case state_reg is
			when idle =>
				if rx = '0' then
					state_next <= start;
					s_next <= (others => '0');
				end if;
			when start =>
				if (baud_rate = '1') then
					if s_reg = integer((bit_stop/2))-1 then --podria ser 7 o 15
						state_next <= data;
						s_next <= (others => '0');
						n_next <= (others => '0');
					else
						s_next <= s_reg + 1;
					end if;
				end if;
			when data =>
				if (baud_rate = '1') then
					if s_reg = bit_stop-1 then 
						s_next <= (others => '0');
						b_next <= rx & b_reg(7 downto 1);
						if n_reg = (nbits - 1) then
							state_next <= stop;
						else
							n_next <= n_reg + 1;
						end if;
					else
						s_next <= s_reg + 1;
					end if;
				end if;
			when stop =>
				if (baud_rate = '1') then
					if s_reg = (bit_stop - 1) then
						state_next <= idle;
						rx_done_tick <= '1';
					else
						s_next <= s_reg + 1;
					end if;
				end if;
		end case;
	end process;
	
	-- llegada de bits
	d_out <= b_reg;
end Behavioral;
	