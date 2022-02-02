----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/17/2022 12:05:06 PM
-- Design Name: 
-- Module Name: top_sys - Behavioral
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

entity top_sys is
  Port (clk,rst: in std_logic;
        columns: in std_logic_vector(3 downto 0);
        rows: out std_logic_vector(3 downto 0);
        lcd_e  : out std_logic;
        lcd_rs : out std_logic;
        lcd_rw : out std_logic;
        lcd_db : out std_logic_vector(7 downto 4);
        start: in std_logic;
        s: out std_logic_vector(3 downto 0);
        wave_alert: out std_logic;
        rx: in std_logic;
        tx: out std_logic;
        fl: out std_logic;
        motor_out: out std_logic_vector(3 downto 0) );
end top_sys;

architecture Behavioral of top_sys is

--keypad Ports
signal flag : std_logic;
signal key_char: std_logic_vector(7 downto 0);

--LCD ports
  -- 125 Mhz  generic Frecuency
constant CLK_FREQ: integer := 125000000;
constant ALERT_FREQ: integer := 2000;
constant CLK_PERIOD_NS : positive := 1000000000/CLK_FREQ; 

signal line1_buffer : std_logic_vector(127 downto 0);
signal line2_buffer : std_logic_vector(127 downto 0);

signal password: std_logic_vector(31 downto 0) := x"30303030";


signal buzzer_enable: std_logic;

signal rd_uart, wr_uart: std_logic;
signal w_data, r_data : std_logic_vector(7 downto 0);
signal rx_empty: std_logic;
signal en_motor: std_logic;
signal direction: std_logic := '1';

component pmod_step_interface
port (
   clk : in std_logic;
   rst: in std_logic;
   direction: in std_logic;
   en:  in std_logic;
   signal_out:  out std_logic_vector(3 downto 0)
);
end component pmod_step_interface;


begin


MOTOR: pmod_step_interface
port map(clk => clk, rst => rst, en => en_motor, signal_out => motor_out, direction => direction);


FSM_A: entity work.fsm(Behavioral)
port map(clk => clk, rst => rst,start_bt => start,flag_char =>flag,in_char => key_char,
        line1 => line1_buffer, line2 => line2_buffer, password => password, buzzer => buzzer_enable,
        rd_uart => rd_uart, wr_uart => wr_uart, empty_uart => rx_empty, get_data_uart => r_data,
        send_data_uart => w_data, en_motor => en_motor );

keypadMat: entity work.keypad_top(Behavioral)
generic map(FREQ_CLK => CLK_FREQ)
port map(clk => clk, rst => rst,columns => columns, rows => rows, flagNewChar => flag,
key_out => key_char, t => fl);

UART1: entity work.uart(str_Behavioral)
generic map( FIFO_W => 1)
port map(clk => clk, reset => rst, rd_uart => rd_uart, wr_uart => wr_uart, w_data => w_data, r_data => r_data,
         rx_empty => rx_empty, rx => rx, tx => tx);

LCD_162 : entity work.lcd16x2_ctrl
generic map ( CLK_PERIOD_NS => CLK_PERIOD_NS)
port map (
      clk          => clk,
      rst          => rst,
      lcd_e        => lcd_e,
      lcd_rs       => lcd_rs,
      lcd_rw       => lcd_rw,
      lcd_db       => lcd_db,
      line1_buffer => line1_buffer,
      line2_buffer => line2_buffer);

BUZZER_ALERT: entity work.buzzer(Behavioral)
generic map(F_CLOCK => CLK_FREQ, F_START => ALERT_FREQ)
port map(clk => clk, enable => buzzer_enable, wave => wave_alert);
      
s(3) <= key_char(3);
s(2) <= key_char(2);
s(1) <= key_char(1);
s(0) <= key_char(0);


end Behavioral;
