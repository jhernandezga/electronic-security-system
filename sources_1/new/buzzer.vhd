----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/29/2022 09:31:33 PM
-- Design Name: 
-- Module Name: buzzer - Behavioral
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
use     ieee.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity buzzer is
  generic(
  F_CLOCK: integer := 125000000;
  F_START: integer := 2000;
  F_STOP: integer :=  4400;
  MBITS: integer:= 18
  );
  Port (clk: in std_logic;
        enable: in std_logic;
        wave: out std_logic );
end buzzer;

architecture Behavioral of buzzer is

signal count_limit: integer := (F_CLOCK)/(F_START);

signal dd,qq: unsigned(MBITS-1 downto 0) := (others => '0');
signal ovf :   std_logic := '0';

begin

mux_add: dd <= qq + 1 when ovf = '0' else (others => '0'); 
comp_ovf: ovf <= '1' when qq = (count_limit -1) else '0'; --125M --x"7735940"
comp_en: wave <= '0' when qq <= ((count_limit-1)/2) else '1';  --125M-1 --x"773593F"

--register 

reg: process(clk)
begin
  if rising_edge(clk) then
    if enable = '1' then
        qq <= dd;
    else
        qq <= TO_UNSIGNED(((count_limit-1)/2),MBITS);  
    end if;
  else
    qq <= qq;
  end if;
end process;

end Behavioral;

