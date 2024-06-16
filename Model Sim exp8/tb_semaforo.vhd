-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Aluno: Felipe Lopes Gibin Duarte
-- Matrícula: 231025207
-- Data: 11/06/2024

-- Descrição: Implementação de um semáforo utilizando uma máquina de estados

-- ****************************************** 
-- Testbench para a simulação do
-- Circuito: Semáforo
-- CLK           Entrada 1
-- ligadesliga   Entrada 2
-- sensorA       Entrada 3
-- sensorB       Entrada 4
-- cont_dezena   Entrada 5
-- cont_unidade  Entrada 6
-- semaforoA     Saida 1
-- semaforoB     Saida 2
-- ******************************************

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;
use std.textio.all;

--Entidade
entity tb_semaforo is
end entity;

--Arquitetura
architecture arq of tb_semaforo is

    --Declaracao do componente semaforo, referente a entidade do arquivo semaforo.vhd
    component semaforo is
        port (
            CLK, ligadesliga, sensorA, sensorB: in std_logic;
            cont_dezena, cont_unidade: out std_logic_vector(3 downto 0);
            semaforoA, semaforoB : out std_logic_vector(2 downto 0)
        );
    end component;

    --Sinais auxiliares
    signal CLK: std_logic := '1';
    signal ligadesliga, sensorA, sensorB: std_logic;
    signal cont_dezena, cont_unidade: std_logic_vector(3 downto 0);
    signal semaforoA, semaforoB: std_logic_vector(2 downto 0);

begin
    -- Instancia do componente semaforo
    dut: semaforo port map (
        CLK => CLK,
        ligadesliga => ligadesliga,
        sensorA => sensorA,
        sensorB => sensorB,
        cont_dezena => cont_dezena,
        cont_unidade => cont_unidade,
        semaforoA => semaforoA,
        semaforoB => semaforoB
    );

    --Criando o clock 
    CLK <= not CLK after 0.5 sec; --clock de 1 Hz

    --Processo de estimulo
    estimulo: process

    begin
        -- Inicializa inputs
        ligadesliga <= '1';
        sensorA <= '1'; sensorB <= '1';

        --A_GREEN por 20 segundos
        wait for 20 sec;
        sensorA <= '0';  --muda pro a yellow

        --A_YELLOW por 6 segundos
        wait for 6 sec;

        --BOTH_RED1 por 5 segundos
        wait for 5 sec;

        --B_GREEN por 20 segundos
        wait for 24 sec;
        sensorA <= '1';
        sensorB <= '0';  --muda pro b yellow

        --B_YELLOW por 6 segundos
        wait for 6 sec;

        --BOTH_RED1 por 2 segundos
        wait for 2 sec;
        ligadesliga <= '0';  --muda pra intermitent

        wait for 2 sec;
        ligadesliga <= '1';  --muda pra a green
        wait for 2 sec;
    
    end process;
end arq;
