--Descricao: Um multiplexador e um dispositivo digital que seleciona uma de varias fontes de dados, a depender do valor da entrada de selecao, e a direciona para um unico canal de saida.

-- ***********************************
-- Circuito: Multiplexador
-- D0 Entrada 1
-- D1 Entrada 2
-- D2 Entrada 3
-- D3 Entrada 4
-- D4 Entrada 5
-- D5 Entrada 6
-- D6 Entrada 7
-- D7 Entrada 8
-- Seletor S (S0, S1, S2, S3, S4, S5, S6, S7) Entrada de selecao
-- Y Saida 1

-- ***********************************


--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;

--Entidade
entity Multiplexador2 is 
   port(
      D: in std_logic_vector (7 downto 0);                      --Entrada de 8 bits
      S: in std_logic_vector (2 downto 0);                      --Seletor de 3 bits
      Y: out std_logic                                          --Saida
   );
end Multiplexador2;

--Arquitetura
architecture arqmultiplexador2 of Multiplexador2 is
begin

   Y <= D(0) when (S = "000") else
        D(1) when (S = "001") else
        D(2) when (S = "010") else
        D(3) when (S = "011") else
        D(4) when (S = "100") else
        D(5) when (S = "101") else
        D(6) when (S = "110") else
        D(7);  -- Quando tudo e 1

end arqmultiplexador2;
