----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2022 02:06:29 PM
-- Design Name: 
-- Module Name: keypad_top - Behavioral
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
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity keypad_top is
  generic(FREQ_CLK: integer := 125000000);
  Port (clk : in std_logic;
        rst: in std_logic;
        flagNewChar: out std_logic;
        key_out: out std_logic_vector(7 downto 0);
        columns: in std_logic_vector(3 downto 0);
        rows: out std_logic_vector(3 downto 0) );
end keypad_top;

architecture Behavioral of keypad_top is

signal flag: std_logic := '0';


begin

keypad1: entity work.KEYPAD(Behavioral)
generic map(FREQ_CLK => FREQ_CLK)
port map(clk => clk,COLUMNAS => columns, FILAS => rows,IND => flag,BOTON_PRES => key_out);

deb: entity work.debounce_circuit(Behavioral)
port map(clk => clk, reset => rst, sw => flag, db_level => open, db_tick => flagNewChar);

end Behavioral;
