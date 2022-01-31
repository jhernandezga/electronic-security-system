----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/08/2021 04:39:01 PM
-- Design Name: 
-- Module Name: baud_gen - Behavioral
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
entity baud_gen is
     generic( M: integer := 407;   --it counts until M and generates a tick
              MBITS: integer := 9  --number of bits to get M, MBITS = Log2(M)
              );
     port (clk, reset: in std_logic;
           baud_ticks: out std_logic );
end baud_gen;

architecture Behavioral of baud_gen is

signal r_reg, r_next: unsigned( MBITS-1 downto 0);  

begin

--register 
    process (clk, reset)
    begin
        if (reset='1') then
           r_reg <=(others=>'0');
        elsif (clk'event and clk='1') then
           r_reg<=r_next;
        end if;
    end process;
    
    --logic
    r_next <= (others=> '0') when r_reg = (M-1) else r_reg + 1;   --overflow r_next after counting M clock signals    
    --out  
    
    baud_ticks <='1' when r_reg = (M-1) else '0'; -- it generates a tick of one-clock signal when it has counted M  clock signals
    

end Behavioral;


