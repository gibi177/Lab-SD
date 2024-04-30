-- Descrição: Implementacao de um somador de palavras de 4 bits utilizando somadores completos

-- ****************************************** 
--  Circuito: Somador de palavras de 4 bits:
-- A Entrada 1
-- B Entrada 2
-- S Saida
-- ******************************************

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;

--Entidade
entity Q1 is
    port(
        A: in std_logic_vector(3 downto 0);
        B: in std_logic_vector(3 downto 0);
        S: out std_logic_vector(4 downto 0)
    );
end Q1;

--Arquitetura
architecture arq of Q1 is  

    --Declaracao do componente somador, referente a architetura do arquivo somador.vhd
    component somador is
        port(
            A,B,Cin: in std_logic;
            S,Cout: out std_logic
        );
    end component;

--Sinal dos carrys
signal carry: std_logic_vector(4 downto 0);

begin 
    --carry in do primeiro somador e zero
    carry(0) <= '0';
    
    --Instancias do componente
    u1: somador port map (A(0), B(0), carry(0), S(0), carry(1));
    u2: somador port map (A(1), B(1), carry(1), S(1), carry(2));
    u3: somador port map (A(2), B(2), carry(2), S(2), carry(3));
    u4: somador port map (A(3), B(3), carry(3), S(3), carry(4));
    
    --Bit mais significativo e o ultimo carry
    S(4) <= carry(4);

end arq;
