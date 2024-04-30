--Descricao: Um multiplexador e um dispositivo digital que seleciona uma de varias fontes de dados e a direciona para um unico canal de saida.

-- ***********************************
-- Circuito: Multiplexador
-- D0 Entrada 1
-- D1 Entrada 2
-- D2 Entrada 3
-- D3 Entrada 4
-- Seletor S (S0 e S1) Entrada de selecao
-- Y Saida 1

-- ***********************************


--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;

--Entidade
entity Multiplexador is
   port ( 
      D0,D1,D2,D3: in std_logic;      --Entrada de 4 bits
      S0,S1: in std_logic;            --Seletor de 2 bits
      Y: out std_logic               --Saida
   );
end Multiplexador;


--Arquitetura
architecture arqmultiplexador of Multiplexador is
begin

   process (D0,D1,D2,D3,S0,S1)
   begin

      if (S0 = '0' and S1 = '0') then
         Y <= D0;
      elsif (S0 = '0' and S1 = '1') then
         Y <= D1;
      elsif (S0 = '1' and S1 = '0') then
         Y <= D2;
      else
         Y <= D3;
      end if;
         
   end process;
end arqmultiplexador;
