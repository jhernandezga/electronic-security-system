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

entity sys_tb1 is
--  Port ( );
end sys_tb1;

architecture Behavioral of sys_tb1 is

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
wait for T;
start <= '1';
wait for T;
start <= '0'; 




--fila de 1 a A

--número 1
columns<="1000";
wait for 1250*T;

columns<="0000";
wait for 3750*T;

--número 2
columns<="0100";
wait for 1250*T;

columns<="0000";
wait for 3750*T;

--número 3
columns<="0010";
wait for 1250*T;

columns<="0000";
wait for 3750*T;


--letra A
columns<="0001";
wait for 1250*T;

columns<="0000";
wait for 3750*T;


columns<="0010";
wait for 1250*T;

columns<="0000";
wait for 3750*T;






--fila de 4 a B

--número 4
columns<="0000";
wait for 1250*T;

columns<="1000";
wait for 1250*T;

columns<="0000";
wait for 2500*T;


--número 5  

columns<="0000";
wait for 1250*T;

columns<="0100";
wait for 1250*T;

columns<="0000";
wait for 2500*T;


--número 6  
columns<="0000";
wait for 1250*T;

columns<="0010";
wait for 1250*T;

columns<="0000";
wait for 2500*T;



--letra B  

columns<="0000";
wait for 1250*T;

columns<="0001";
wait for 1250*T;

columns<="0000";
wait for 2500*T;


columns<="0000";
wait for 1250*T;

columns<="0010";
wait for 1250*T;

columns<="0000";
wait for 2500*T;





--fila de * a D

--símbolo *  

columns<="0000";
wait for 3750*T;

columns<="0100";
wait for 1250*T;


--número 0  

columns<="0000";
wait for 3750*T;

columns<="0100";
wait for 1250*T;

--símbolo #   

columns<="0000";
wait for 3750*T;

columns<="0100";
wait for 1250*T;

--letra D  

columns<="0000";
wait for 3750*T;

columns<="0100";
wait for 1250*T;

--letra D  

columns<="0000";
wait for 3750*T;

columns<="0010";
wait for 1250*T;











--fila de 7 a C

--número 7  

columns<="0000";
wait for 2500*T;

columns<="1000";
wait for 1250*T;

columns<="0000";
wait for 1250*T;


--número 8  

columns<="0000";
wait for 2500*T;

columns<="0100";
wait for 1250*T;

columns<="0000";
wait for 1250*T;

--número 9   


columns<="0000";
wait for 2500*T;

columns<="0010";
wait for 1250*T;

columns<="0000";
wait for 1250*T;

--letra C  

columns<="0000";
wait for 2500*T;

columns<="0001";
wait for 1250*T;

columns<="0000";
wait for 1250*T;


columns<="0000";
wait for 2500*T;

columns<="0010";
wait for 1250*T;

columns<="0000";
wait for 1250*T;

















--primera repeticion 


--fila de 1 a A

--número 1
columns<="1000";
wait for 1250*T;

columns<="0000";
wait for 3750*T;

--número 2
columns<="0100";
wait for 1250*T;

columns<="0000";
wait for 3750*T;

--número 3
columns<="0010";
wait for 1250*T;

columns<="0000";
wait for 3750*T;


--letra A
columns<="0001";
wait for 1250*T;

columns<="0000";
wait for 3750*T;






--fila de 4 a B

--número 4
columns<="0000";
wait for 1250*T;

columns<="1000";
wait for 1250*T;

columns<="0000";
wait for 2500*T;


--número 5  

columns<="0000";
wait for 1250*T;

columns<="0100";
wait for 1250*T;

columns<="0000";
wait for 2500*T;


--número 6  
columns<="0000";
wait for 1250*T;

columns<="0010";
wait for 1250*T;

columns<="0000";
wait for 2500*T;



--letra B  

columns<="0000";
wait for 1250*T;

columns<="0001";
wait for 1250*T;

columns<="0000";
wait for 2500*T;










--fila de 7 a C

--número 7  

columns<="0000";
wait for 2500*T;

columns<="1000";
wait for 1250*T;

columns<="0000";
wait for 1250*T;


--número 8  

columns<="0000";
wait for 2500*T;

columns<="0100";
wait for 1250*T;

columns<="0000";
wait for 1250*T;

--número 9   


columns<="0000";
wait for 2500*T;

columns<="0010";
wait for 1250*T;

columns<="0000";
wait for 1250*T;

--letra C  

columns<="0000";
wait for 2500*T;

columns<="0001";
wait for 1250*T;

columns<="0000";
wait for 1250*T;








--fila de * a D

--símbolo *  

columns<="0000";
wait for 3750*T;

columns<="0100";
wait for 1250*T;


--número 0  

columns<="0000";
wait for 3750*T;

columns<="0100";
wait for 1250*T;

--símbolo #   

columns<="0000";
wait for 3750*T;

columns<="0100";
wait for 1250*T;

--letra D  

columns<="0000";
wait for 3750*T;

columns<="0100";
wait for 1250*T;

rst <= '1';
wait for 3*T;
rst <= '0';


end process;



end Behavioral;
