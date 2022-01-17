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
  
constant  N:integer := 12 ;   -- filter of 2^N*8ns = 40ms --22 sintesis,12 simulación 
type  state_type is ( zero, wait0, one, wait1);  
signal state_reg,state_next: state_type;  
signal q_reg, q_next: unsigned(N-1 downto 0);

begin
   
   process(clk,reset)
   begin
    if reset = '1' then
        state_reg <= zero;
        q_reg <= (others => '0');
    elsif rising_edge(clk) then
        state_reg <= state_next;
        q_reg <= q_next;
    end if;
   end process;
   
  
   
   process(state_reg,q_reg,sw,q_next)
   begin
    state_next <= state_reg;
    q_next <= q_reg;
    db_tick <= '0';
    case state_reg is
        when zero =>
            db_level <= '0';
            if (sw = '1') then
                state_next <= wait1;
                q_next <= (others => '1');
            end if;
        when wait1 =>
            db_level <= '0';
            if(sw = '1') then
                q_next <= q_reg -1;
                if(q_next = 0) then
                    state_next <= one;
                    db_tick <= '1';
                end if;
            else --sw='0'
                state_next <= zero;
                end if;
        when one =>
            db_level <= '1';
            if(sw = '0') then
                state_next <= wait0;
                q_next <= (others => '1');
            end if;
        when wait0 =>
            db_level <= '1';
            if(sw = '0') then
                q_next <= q_reg -1;
                if(q_next = 0) then
                    state_next <= zero;
                end if;
            else --sw=0
                state_next <= one;
            end if;
        end case;                
   end process;
   
end behavioral;