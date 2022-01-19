----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/16/2022 09:16:45 PM
-- Design Name: 
-- Module Name: fsm - Behavioral
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

entity fsm is
 generic(attempts: integer := 4);
  Port (clk: in std_logic;
        rst: in std_logic;
        in_char: in std_logic_vector(7 downto 0);
        flag_char: in std_logic;
        line1: out std_logic_vector(127 downto 0);
        line2: out std_logic_vector(127 downto 0);
        start_bt: in std_logic;
        password: in std_logic_vector(31 downto 0));
end fsm;

architecture Behavioral of fsm is
signal en,right_pass,wrong_pass: std_logic;
signal line1_buff,line2_buff: std_logic_vector(127 downto 0);

signal count_attempts: integer range 0 to 5 := 0;


type states_k is (start,typing,open_d,w_msg,alert_protocol);
signal state_reg,state_next: states_k;

begin

pass_man: entity work.pass(Behavioral)
port map(clk => clk, rst => rst,password => password,in_data =>in_char,
flagIn => flag_char,right_pass => right_pass,wrong_pass => wrong_pass,en => en); 

en <= '1';


--reg
process(clk)
begin
if rst = '1' then
    state_reg <= start;
elsif rising_edge(clk) and en = '1' then
    state_reg <= state_next;
    line1 <= line1_buff;
    line2 <= line2_buff;
end if;
end process;

--next state logic

process(state_reg,start_bt,flag_char,right_pass,wrong_pass)
begin

case state_reg is

when start =>
    line1_buff <= x"4269656E76656E696440202020202020";
    line2_buff <= x"70726573696F6E652027737461727427";
    if start_bt = '1' then
        line2_buff <= x"2020202020202020202020202020203E";
        state_next <= typing;
    end if;
when typing =>
    line1_buff <= x"496E6772657365206C6120636C617665";
    if flag_char ='1' and  right_pass /= '1' and  wrong_pass /= '1' then
        line2_buff <= line2_buff(119 downto 0) & in_char; 
    end if;
    if right_pass = '1' then
        state_next <= open_d;
    elsif wrong_pass = '1' then
        count_attempts <= count_attempts +1;
        if count_attempts < attempts then
            state_next <= w_msg;
        else
            state_next <= alert_protocol;
        end if;         
        
    end if;
    
when w_msg =>
    line1_buff <= x"636C61766520696E636F727265637461";
     line2_buff <= x"2020202020202020202020202020203E";
    if flag_char = '1' then
        state_next <= typing;
    end if;
when open_d =>
    line1_buff <= x"436C61766520636F7272656374612020";
    line2_buff <= x"61627269656E646F2E2E2E2020202020";
    
when alert_protocol => 
    line1_buff <= x"416C6572746121212020202020202020";
    line2_buff <= x"446573626C6F7175656F20424C544820"; 
    
end case;

end process;

end Behavioral;
