-- **************
-- Testbench para simulacao funcional do
-- Circuito: Somador completo
-- A Entrada 1
-- B Entrada 2
-- Cin Entrada 3
-- S Saida 1
-- Cout Saida 2

-- ***********************************

-- ENTITY ( Entidade )
-- testbench1 uma entidade sem pinos de entrada e saida
entity testbench1 is end ;

-- Testbench para SomadorCompleto.vhd
-- Validacao assincrona

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;
use std . textio . all ;


--Arquitetura
architecture tb_SomadorCompleto of testbench1 is

--Declaracao do componente SomadorCompleto, referente a entidade do arquivo SomadorCompleto.vhd

component SomadorCompleto
   port ( 
      A,B,Cin: in STD_LOGIC;
      S,Cout: out STD_LOGIC
   );
end component;

--Sinais de entrada
signal A_tb, B_tb, Cin_tb : std_logic;

--Sinais de saida
signal S, Cout : std_logic;

begin
teste: SomadorCompleto port map (A => A_tb, B => B_tb, Cin => Cin_tb, S => S, Cout => Cout);

--Implementacao do processo de estimulo
estimulo : process
begin

-- Estimulos de entrada
   A_tb <= '0';
   B_tb <= '0';
   Cin_tb <= '0';
   wait for 10 ns;

   A_tb <= '0';
   B_tb <= '0';
   Cin_tb <= '1';
   wait for 10 ns;

   A_tb <= '0';
   B_tb <= '1';
   Cin_tb <= '0';
   wait for 10 ns;

   A_tb <= '0';
   B_tb <= '1';
   Cin_tb <= '1';
   wait for 10 ns;

   A_tb <= '1';
   B_tb <= '0';
   Cin_tb <= '0';
   wait for 10 ns;

   A_tb <= '1';
   B_tb <= '0';
   Cin_tb <= '1';
   wait for 10 ns;

   A_tb <= '1';
   B_tb <= '1';
   Cin_tb <= '0';
   wait for 10 ns;

   A_tb <= '1';
   B_tb <= '1';
   Cin_tb <= '1';
   wait for 10 ns;

   --Finaliza a simulacao
   wait;

end process estimulo;
end tb_SomadorCompleto;


