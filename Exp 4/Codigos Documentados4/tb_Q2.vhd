-- ***********************************
--Testbench para o circuito
--Circuito: Funcao booleana:
--S = F.G + A.B.C.D.E'.F'.G + A'.B'.C'.D'.E'.F'.G + A.B'.C.E.F.G' + A'.B.C.D.E'.F.G' + A.B.C.D.E.F'.G' + A.B'.C'.D.E.F'.G'
-- A: Entrada 1
-- B: Entrada 2
-- C: Entrada 3
-- D: Entrada 4
-- E: Entrada 5
-- F: Entrada 6
-- G: Entrada 7
-- S: Saida 

-- ***********************************

-- Entidade
-- testbench2 uma entidade sem pinos de entrada e saida
entity testbench2 is end ;

-- Testbench para Q2.vhd
--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;
use std.textio.all ;

--Arquitetura
architecture tb_Q2 of testbench2 is

    --Declaracao do componente Q2, referente a entidade do arquivo Q2.vhd
    component Q2 is
        port(
            A,B,C,D,E,F,G: in std_logic;                     --Entrada
            S: out std_logic                                 --Saida
        );
    end component;

    --Inputs
    signal A, B, C, D, E, F, G: std_logic;

    --Outputs
    signal S: std_logic;

    begin
        -- Instância do componente a ser testado
        teste: Q2 port map (
            A => A,
            B => B,
            C => C,
            D => D,
            E => E,
            F => F,
            G => G,
            S => S
        );

        --Implementacao do processo de estimulo
        estimulo: process
        begin
            -- Estímulos de entrada
            -- Caso em que o primeiro termo (F.G) é verdadeiro
            A <= '0'; B <= '0'; C <= '0'; D <= '0'; E <= '0'; F <= '1'; G <= '1'; wait for 10 ns;

            -- Caso em que o segundo termo (A.B.C.D.E'.F'.G) é verdadeiro
            A <= '1'; B <= '1'; C <= '1'; D <= '1'; E <= '0'; F <= '0'; G <= '1'; wait for 10 ns;

            -- Caso em que o terceiro termo (A'.B'.C'.D'.E'.F'.G) é verdadeiro
            A <= '0'; B <= '0'; C <= '0'; D <= '0'; E <= '1'; F <= '0'; G <= '1'; wait for 10 ns;

            -- Caso em que o quarto termo (A.B'.C.E.F.G') é verdadeiro
            A <= '1'; B <= '0'; C <= '1'; D <= '0'; E <= '0'; F <= '1'; G <= '0'; wait for 10 ns;

            -- Caso em que o quinto termo (A'.B.C.D.E'.F.G) é verdadeiro
            A <= '0'; B <= '1'; C <= '0'; D <= '1'; E <= '1'; F <= '0'; G <= '1'; wait for 10 ns;

            -- Caso em que o sexto termo (A.B.C.D.E.F'.G') é verdadeiro
            A <= '1'; B <= '1'; C <= '1'; D <= '1'; E <= '1'; F <= '0'; G <= '0'; wait for 10 ns;

            -- Caso em que o sétimo termo (A.B'.C'.D.E.F'.G') é verdadeiro
            A <= '1'; B <= '0'; C <= '0'; D <= '1'; E <= '1'; F <= '0'; G <= '0'; wait for 10 ns;

            --Caso em que a funcao daria zero
            A <= '1'; B <= '1'; C <= '0'; D <= '1'; E <= '1'; F <= '1'; G <= '0'; wait for 10 ns;

            --Outro caso em que a funcao daria zero
            A <= '1'; B <= '1'; C <= '1'; D <= '0'; E <= '1'; F <= '1'; G <= '0'; wait for 10 ns;

            -- Caso em que todas as entradas sao 1
            A <= '1'; B <= '1'; C <= '1'; D <= '1'; E <= '1'; F <= '1'; G <= '1'; wait for 10 ns;

            -- Caso em que todas as entradas sao 0
            A <= '0'; B <= '0'; C <= '0'; D <= '0'; E <= '0'; F <= '0'; G <= '0'; wait for 10 ns;

            wait;
        
        end process estimulo;
end tb_Q2;