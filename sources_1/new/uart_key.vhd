----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/30/2022 04:03:51 PM
-- Design Name: 
-- Module Name: uart_coupling - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_key is
 generic(UART_KEY: std_logic_vector(7 downto 0) := x"30");
 Port (clk: in std_logic;
       empty_uart: in std_logic;
       clear: out std_logic;
       get_data_uart: in std_logic_vector(7 downto 0);
       right_key: out std_logic
        );
end uart_key;

architecture Behavioral of uart_key is

begin

process(clk)
begin

if rising_edge(clk) then
right_key <= '0';
clear <= '0';
if empty_uart /= '1' then
    if get_data_uart = UART_KEY then
       right_key <= '1';
       clear <= '1';
     else 
        clear <= '1';  
    end if;
end if;
end if;
end process;

end Behavioral;
