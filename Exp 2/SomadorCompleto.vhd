--Descricao: Um somador completo e um componente que faz a adicao de 3 inputs binarios.

-- ***********************************
-- Circuito:Somador completo
-- A Entrada 1
-- B Entrada 2
-- Cin Entrada 3
-- S Saida 1
-- Cout Saida 2

-- ***********************************

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;

--Entidade
entity SomadorCompleto is
   port ( 
      A,B,Cin: in STD_LOGIC;
      S,Cout: out STD_LOGIC
   );
end SomadorCompleto;

--Arquitetura
architecture arqsomador of SomadorCompleto is
begin
   S <= A XOR B XOR Cin;
   Cout <= (A AND B) OR (A AND Cin) OR (B AND Cin);
end arqsomador
