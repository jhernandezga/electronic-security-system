----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2022 08:08:21 PM
-- Design Name: 
-- Module Name: pass - Behavioral
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

entity pass is
  generic(N_CHAR: integer := 4);
  Port (clk: in std_logic;
        rst: in std_logic;
        en: in std_logic;
        password: in std_logic_vector(31 downto 0);
        in_data: in std_logic_vector(7 downto 0);
        right_pass,wrong_pass: out std_logic;
        flagIn: in std_logic );
end pass;

architecture Behavioral of pass is

type states_k is (start,concatenation,del);

signal count: integer range 0 to N_CHAR := 0;
signal key_in: std_logic_vector(7 downto 0);
signal state_reg,state_next: states_k;
signal out_buffer: std_logic_vector(8*N_CHAR-1 downto 0) := (others => '0');


begin

--reg
process(clk)
begin
if rst = '1' then
    state_reg <= start;
elsif rising_edge(clk) and en = '1' then
    state_reg <= state_next;
end if;
end process;

process(state_reg,flagIn)
begin
right_pass <= '0';
wrong_pass <= '0';
case state_reg is
    when start =>
        out_buffer <= (others => '0');
        if flagIn = '1' then
            state_next <= concatenation;
        end if; 
    when concatenation =>
         if flagIn = '1' then
            count <= count + 1;
            if count < N_CHAR then
                out_buffer <= in_data & out_buffer(8*N_CHAR-1 downto 8);
            else 
                count <= 0;
                state_next <= del;
            end if;
        end if;
                    
   when del =>
        if out_buffer = password then
            right_pass <= '1';
        else
            wrong_pass <= '1';
        end if;
        state_next <= start;
 end case;       
end process;

end Behavioral;
