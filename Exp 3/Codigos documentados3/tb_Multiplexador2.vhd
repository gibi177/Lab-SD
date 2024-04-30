-- *****************************
-- Testbench para simulacao funcional do
-- Circuito: Multiplexador
-- D0 Entrada 1
-- D1 Entrada 2
-- D2 Entrada 3
-- D3 Entrada 4
-- Seletor S (S0 e S1) Entrada de selecao
-- Y Saida 1

-- *****************************

-- Entidade
-- testbench1 uma entidade sem pinos de entrada e saida
entity testbench1 is end ;

-- Testbench para Multiplexador2.vhd
-- Validacao assincrona

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;
use std.textio.all ;


--Arquitetura
architecture tb_Multiplexador2 of testbench1 is

--Declaracao do componente Multiplexador, referente a entidade do arquivo Multiplexador2.vhd

component Multiplexador2
   port ( 
      D: in std_logic_vector (7 downto 0);                    --Entrada de 8 bits
      S: in std_logic_vector (2 downto 0);                    --Seletor de 3 bits
      Y: out std_logic                                       --Saida
   );
end component;

--Inputs
signal D : std_logic_vector(7 downto 0) := "00000000";
signal S : std_logic_vector(2 downto 0) := "000";
 
--Outputs
signal Y : std_logic;

begin
   teste: Multiplexador2 port map (D => D, S => S, Y => Y);

   --Implementacao do processo de estimulo
   estimulo : process
   begin

       --Entradas D
       --Cada valor de S vai selecionar um bit de D, cada bit de D e uma entrada diferente
       D <= "10101010";

       --Definindo S
       S <= "000";
       wait for 10 ns;   
    
       S <= "001";
       wait for 10 ns;  
    
       S <= "010";
       wait for 10 ns;  
    
       S <= "011";
       wait for 10 ns;
 
       S <= "100";
       wait for 10 ns;  
        
       S <= "101";
       wait for 10 ns;   
      
       S <= "110";
       wait for 10 ns;  
       
       S <= "111";
       wait for 10 ns;

       --Finaliza a simulacao
       wait;

   end process estimulo;
end tb_Multiplexador2;





