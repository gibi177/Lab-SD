-- Descrição: Implementacao de um somador de palavras de 4 bits utilizando o operador '+' da biblioteca arith

-- ****************************************** 
--  Circuito: Somador de palavras de 4 bits:
-- A Entrada 1
-- B Entrada 2
-- S Saida
-- ******************************************

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_arith.all;

--Entidade
entity Q2 is
    port(
        A: in std_logic_vector(3 downto 0);
        B: in std_logic_vector(3 downto 0);
        S: out std_logic_vector(4 downto 0)
    );
end Q2;

--Arquitetura
architecture arq of Q2 is

    begin
        S <= unsigned('0' & A) + unsigned('0' & B);

end arq;

