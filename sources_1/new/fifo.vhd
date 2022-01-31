----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2021 10:53:07
-- Design Name: 
-- Module Name: fifo - Behavioral
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


--Un FIFO ( primero en entrar, primero en salir ) es un b�fer UART que obliga a que cada byte d� su comunicaci�n en serie
                                               -- se transmita en el orden en que se recibe
entity fifo is
    generic( NBITS:integer := 8; 
             W:integer := 4 --Number of address bits
             );
    port (
          clk, reset:in std_logic;
          read, write: in std_logic;        --dar orden de leer o escribir
          write_data: in std_logic_vector (7 downto 0);    --dato le�do (tama�o de 8 bits)
          empty, full: out std_logic;
          read_data: out std_logic_vector (7 downto 0)    --dato escrito (tama�o de 8 bits)
     );
end fifo;

architecture Behavioral of fifo is

     type reg_file_type is array (2**W-1 downto 0) of std_logic_vector (NBITS-1 downto 0);  --creo que hace define un arreglo de 8 bits pero ni idea  **es una exponencial
     signal array_reg: reg_file_type;
     signal write_ptr_reg, write_ptr_next, write_ptr_sucesivos: std_logic_vector (W-1 downto 0);    --hace referencia a los registros ptr, en estos la notaci�n est� invertida
     signal read_ptr_reg, read_ptr_next, read_ptr_sucesivos: std_logic_vector (W-1 downto 0);       --creo que ambos se usan para la ubicaci�n de los bits 
     signal full_reg, empty_reg, full_next, empty_next: std_logic;   --para saber si el registro actual o siguiente est�n llenos o vac�os 
     signal write_read_op: std_logic_vector (1 downto 0);    -- define si opera la escritura o la lectura o ambos
     signal write_enable: std_logic;     --habilita la escritura

begin
     --registros: registrar cada bit
     
     --escribir solo cuando hay espacio  
       write_enable<=write and (not full_reg);    --se habilita la escritura si se da la orden y hay espacio
       
    --asignaci�n de los valores de los bits sucesivos 
       write_ptr_sucesivos <= std_logic_vector(unsigned(write_ptr_reg)+1);  -- std_logic_vector(a+1), convierte a "a+1" en un std_logic_vector, por lo cual convertiremos al valor write_ptr_reg+1 a un std_logic_vector, es decir, simplemente le sumamos 1 a write_ptr_reg, para as� obtener la siguiente posici�n.
       read_ptr_sucesivos <= std_logic_vector(unsigned(read_ptr_reg)+1);

 -- l�gica de los bits
       write_read_op <= write & read;-- El operador & se utiliza para concatenar (unir) matrices o unir elementos nuevos a una matriz

--l�gica de control  
       
       process (write_ptr_reg, write_ptr_sucesivos, read_ptr_reg, read_ptr_sucesivos, write_read_op, empty_reg, full_reg)
       begin
           write_ptr_next <=write_ptr_reg;
           read_ptr_next <= read_ptr_reg;        --al dato siguiente se le asigna el anterior, as�, en caso de no haber evento de clock, el sistema no "ejecuta"
           full_next <=full_reg;
           empty_next <=empty_reg;
       case write_read_op is
           when "00" => -- no hace nada 
           when "01" => -- ejecuta la lectura (write=0 y read=1)
               if (empty_reg = '0') then  --primer cambio efectuado sobre el original 
                   read_ptr_next <= read_ptr_sucesivos;
                   full_next <= '0';          --si el registro no est� vac�o, se pasar� a la siguiente posici�n en lectura, y se marcar� al siguiente registro como vac�o
                   if (read_ptr_sucesivos=write_ptr_reg) then
                       empty_next <= '1';    --si la posici�n siguiente de lectura es igual a la posici�n de escritura el siguiente registo estar� vac�o
                   end if;
               end if;
          when "10" => --ejecuta escritura (write=1 y read=0)
              if (full_reg ='0') then --segundo cambio efectuado sobre el original 
                  write_ptr_next <= write_ptr_sucesivos;
                  empty_next <= '0';      -- si el registro no est� lleno, entonces se pasar� a la siguiente posici�n de escritura y se marcar� el registro como NO lleno.
                  if (write_ptr_sucesivos = read_ptr_reg) then 
                      full_next <='1';   --si la posici�n siguiente de escritura es la misma posici�n de lectura se marcar� el siguiente registro como lleno
                  end if;
              end if;
          when others => --(ser�a el caso 11, esto es, ejecutar lectura y escritura)
              write_ptr_next <= write_ptr_sucesivos;
              read_ptr_next <= read_ptr_sucesivos;
         end case;
     end process;
       
       --registro para leer y escribir los bits 
       process (clk, reset)
       begin
           if (reset='1') then
               write_ptr_reg <= (others =>'0');
               read_ptr_reg <= (others =>'0');   -- cuando reset='1' se reinicia todo
               full_reg <= '0';
               empty_reg <= '1';
           elsif (clk'event and clk='1') then
               write_ptr_reg <= write_ptr_next;
               read_ptr_reg <= read_ptr_next;   --cada vez que se cumpla el evento del clock, se le asignar� la siguiente posici�n a cada dato
               full_reg <= full_next;
               empty_reg <= empty_next;
           end if;
       end process;
       
     process (clk, reset)
     begin
         if (reset='1') then
             array_reg<=(others=>(others =>'0'));  --asigna 0 al arreglo de bits cuando reset=1
         elsif (clk'event and clk='1') then
             if (write_enable='1') then
                 array_reg(to_integer(unsigned(write_ptr_reg)))<= write_data;          --cada vez que haya un evento de clock='1' y write_enable sea 1 se le asigna a la marrtiz array_reg el dato write_data en su posici�n write_ptr_reg, as� se llena la matriz empezando por su posici�n 0 hasta la posici�n 15               --to_integer(a): vuelve a "a" un entero, unsigned(a): vuelve a "a" un n�mero sin signo, por lo cual cuando clock='1' y write_enable='1' (esto implica que la escritura este habilitada, haremos que la posici�n en el arreglo de array_reg sea write_prt_reg sin signo y en formato de entero, a esta posici�n le asignaremos el valor escrito, esto es, write_reg;
             end if;
         end if;
     end process;
         
       --puerto de lectura 
       read_data<=array_reg(to_integer(unsigned(read_ptr_reg))); --el dato le�do provendr� del arreglo en la posici�n dada por read_ptr_reg;
              
     
     --salida 
     full<=full_reg;   --indicar� si el registro qued� lleno o vac�o 
     empty<=empty_reg;
              
              
              
              --en s�ntesis, solo lee el dato hasta que se habilita la escriutra del mismo, posterior a eso la lectura se usa para indicar si esta lleno o no el registro
end Behavioral;
