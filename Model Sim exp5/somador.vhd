-- Descrição: Implementacao de um somador completo com 3 entradas e 2 saidas, utilizando funcoes logicas

-- ****************************************** 
--  Circuito: Somador Completo:
-- A Entrada 1
-- B Entrada 2
-- Cin Entrada 3
-- Cout Saida 1
-- S Saida 2
-- ******************************************

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;

--Entidade
entity somador is
    port(
        A,B,Cin: in std_logic;
        S,Cout: out std_logic
    );
end somador;

--Arquitetura
architecture arq of somador is 

begin
    
    S <= A xor B xor Cin;
    Cout <= (A and B) or (A and Cin) or (B and Cin);

end arq;
