-- *****************************
-- Testbench para simulacao funcional do
-- Circuito: Funcao x e y a partir de multiplexador
-- A Entrada 1
-- B Entrada 2
-- C Entrada 3
-- X Saida funcao 1
-- Y Saida funcao 2

-- *****************************

-- Entidade
-- testbench1 uma entidade sem pinos de entrada e saida
entity testbench1 is end ;

-- Testbench para Q1.vhd
--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;
use std.textio.all ;

--Arquitetura
architecture tb_Q1 of testbench1 is

    --Declaracao do componente Q1, referente a entidade do arquivo Q1.vhd

    component Q1
        port(
            A, B, C: in std_logic;
            X, Y: out std_logic
        );
    end component;

    --Inputs
    signal A : std_logic;
    signal B : std_logic;
    signal C : std_logic;
    
    --Outputs
    signal X : std_logic;
    signal Y : std_logic;

    begin
        teste: Q1 port map (A => A, B => B, C => C, X => X, Y => Y);

        --Implementacao do processo de estimulo
        estimulo : process
        begin
            --Definindo as entradas
            A <= '0';
            B <= '0';
            C <= '0';

            --Trocando A e B, que funcionam como seletores
            A <= '0'; B <= '0'; 
            wait for 10 ns;

            A <= '0'; B <= '1'; 
            wait for 10 ns;

            A <= '1'; B <= '0'; 
            wait for 10 ns;

            A <= '1'; B <= '1'; 
            wait for 10 ns;

   end process estimulo;
end tb_Q1;
