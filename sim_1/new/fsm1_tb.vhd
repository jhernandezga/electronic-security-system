----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2022 10:57:49 PM
-- Design Name: 
-- Module Name: fsm1_tb - Behavioral
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

entity fsm1_tb is
--  Port ( );
end fsm1_tb;

architecture Behavioral of fsm1_tb is

signal clk,rst,start_bt,flag_char: std_logic := '0';
signal password: std_logic_vector(31 downto 0) := x"30303030";
signal in_char: std_logic_vector(7 downto 0);
signal line1,line2: std_logic_vector(127 downto 0);

constant T: time := 8 ns;

begin

UUT: entity work.fsm(Behavioral)
port map(clk => clk, rst => rst, start_bt => start_bt, flag_char => flag_char, password => password,
        in_char => in_char, line1 => line1, line2 =>line2);
--clk
process
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
wait for 5*T;
start_bt <= '1';

for k in 0 to 4 loop
in_char <= x"31";
wait for 4*T;
flag_char <= '1';
wait for T;
flag_char <= '0';
end loop;

wait for 20*T;
for k in 0 to 4 loop
wait for 4*T;
in_char <= x"30";
flag_char <= '1';
wait for T;
flag_char <= '0';
end loop;
wait for 30*T;
rst <= '1';
wait for 50*T;
end process;




end Behavioral;
