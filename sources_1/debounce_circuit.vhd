----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2021 12:02:20 AM
-- Design Name: 
-- Module Name: debounce_circuit - Behavioral
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

entity debounce_circuit is
  Port (clk, reset,sw: in std_logic;
        db_tick,db_level: out std_logic );
end debounce_circuit;

architecture Behavioral of debounce_circuit is
  
type  state_type is ( no_funcionando, funcionando);  
signal state_reg,state_next: state_type;  
signal q_reg, q_next: integer:=0;

begin
   
   process(clk,reset)
   begin
    if reset = '1' then
        q_reg <= 0;
        --db_tick<='0';
    elsif rising_edge(clk) then
        q_reg <= q_next;
    end if;
   end process;
   
  process(sw)
   begin
    if rising_edge(sw) then
        state_reg <= funcionando;
    end if;
        if falling_edge (sw) then
        state_reg<=no_funcionando;
    end if;
   end process;
   
   process(clk)
   begin
    case state_reg is
        when no_funcionando =>
            db_tick<= '0';
            q_next<=0;
        when funcionando =>
            q_next <= q_next+1;
            if (q_next=0) then
            db_tick<='1';
            elsif(q_next/=0) then
                db_tick<= '0';
            end if;
        end case;                
   end process;
   
end behavioral;