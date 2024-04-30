-- *****************************
-- Testbench para simulacao funcional do
-- Circuito: Decodificador
-- A: vetor de entrada de 4 bits
-- Y: vetor de saida de 16 bits

-- *****************************

-- Entidade
-- testbench2 uma entidade sem pinos de entrada e saida
entity testbench2 is end ;

-- Testbench para Decodificador.vhd
-- Validacao assincrona

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;
use std.textio.all ;


--Arquitetura
architecture tb_Decodificador of testbench2 is
--Declaracao do componente Decodificador, referente a entidade do arquivo Decodificador.vhd

component Decodificador
   port ( 
      A: in std_logic_vector (3 downto 0);                     --Entrada de 4 bits
      Y: out std_logic_vector (15 downto 0)                    --Saida de 16 bits
   );
end component;

--Inputs
signal A : std_logic_vector(3 downto 0) := "0000";

--Outputs
signal Y : std_logic_vector(15 downto 0) := "0000000000000000";

begin
   teste: Decodificador port map (A => A, Y => Y);

   --Implementacao do processo de estimulo
   estimulo : process
   begin
   
      --Definindo A
      A <= "0000";
      wait for 10 ns;   
    
      A <= "0001";
      wait for 10 ns;  
    
      A <= "0010";
      wait for 10 ns;  
    
      A <= "0011";
      wait for 10 ns;
 
      A <= "0100";
      wait for 10 ns;  
        
      A <= "0101";
      wait for 10 ns;   
      
      A <= "0110";
      wait for 10 ns;  
       
      A <= "0111";
      wait for 10 ns;

      A <= "1000";
      wait for 10 ns;  
        
      A <= "1001";
      wait for 10 ns;   
      
      A <= "1010";
      wait for 10 ns;  
       
      A <= "1011";
      wait for 10 ns;

      A <= "1100";
      wait for 10 ns;  
        
      A <= "1101";
      wait for 10 ns;   
      
      A <= "1110";
      wait for 10 ns;  
       
      A <= "1111";
      wait for 10 ns;

      --Finaliza a simulacao
      wait;

   end process estimulo;
end tb_Decodificador;



