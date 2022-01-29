----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/20/2022 10:37:12 AM
-- Design Name: 
-- Module Name: top_sys_tb - Behavioral
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

entity top_sys_tb is
--  Port ( );
end top_sys_tb;

architecture Behavioral of top_sys_tb is

signal clk,rst: std_logic;
signal columns:  std_logic_vector(3 downto 0);
signal rows:  std_logic_vector(3 downto 0);
signal lcd_e  : std_logic;
signal lcd_rs : std_logic;
signal lcd_rw : std_logic;
signal lcd_db : std_logic_vector(7 downto 4);
signal start: std_logic;
signal s: std_logic_vector(3 downto 0);

constant T: time := 8 ns;

begin


UTT: entity work.top_sys(Behavioral)

port map(clk => clk,rst => rst, columns => columns, rows => rows, lcd_e => lcd_e, lcd_rs => lcd_rs,lcd_rw => lcd_rw, lcd_db => lcd_db,
            start => start, s => s);

clkR: process
begin
clk <= '0';
wait for T/2;
clk <= '1';
wait for T/2;
end process;


process
begin
rst <= '1';
wait for T;
rst <= '0';
wait for 2*T;
start <= '0';
wait for 20 ms;
start <= '1';
wait for 5 ms;
start <= '0'; 
columns <= "1000";
wait for 70 ms;
columns <= "0000";
wait for 50 ms;
columns <= "0100";
wait for 70 ms;
columns <= "0000";
wait for 50 ms;
columns <= "0010";
wait for 70 ms;
columns <= "0000";
wait for 50 ms;
columns <= "0001";
wait for 70 ms;
columns <= "0000";
wait for 50 ms;
columns <= "1000";
wait for 150 ms;
end process;



end Behavioral;
