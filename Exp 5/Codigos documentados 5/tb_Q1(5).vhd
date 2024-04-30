-- ******************************************
-- Testbench para a simulacao do 
--  Circuito: Somador de palavras de 4 bits:
-- A Entrada 1
-- B Entrada 2
-- S Saida
-- ******************************************

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;
use std.textio.all;

--Entidade
entity tb_Q1 is
end entity;

--Arquitetura
architecture testbench of tb_Q1 is
    
    --Declaracao do componente Q1, referente a entidade do arquivo Q1.vhd
    component Q1 is
        port(
        A: in std_logic_vector(3 downto 0);
        B: in std_logic_vector(3 downto 0);
        S: out std_logic_vector(4 downto 0)
    );
    end component;

    -- Sinais auxiliares de entrada e saida
    signal A : std_logic_vector(3 downto 0);
    signal B : std_logic_vector(3 downto 0);
    signal S : std_logic_vector(4 downto 0);

begin
    -- Instância do circuito somador 
    uut: Q1 port map (
        A => A,
        B => B,
        S => S
    );

    -- Implementacao do processo de estimulo
    estimulo: process
    begin  
        --teste1
        A <= "0001"; B <= "0011";     --1+3=4
        wait for 10 ns;

        --teste2
        A <= "0010"; B <= "0011";     --2+3=5
        wait for 10 ns;

        --teste3
        A <= "0111"; B <= "0011";     --7+3=10
        wait for 10 ns;

        --teste4
        A <= "1000"; B <= "1000";     --8+8=16
        wait for 10 ns;

        --teste5
        A <= "0000"; B <= "0000";     --0+0=0
        wait for 10 ns;

        --teste6
        A <= "1111"; B <= "1111";     --15+15=30
        wait for 10 ns;

        --teste7
        A <= "1010"; B <= "0100";     --10+4=14
        wait for 10 ns;

        --teste8
        A <= "1100"; B <= "0111";     --12+7=19
        wait for 10 ns;

        wait;
    end process;
end architecture testbench;
