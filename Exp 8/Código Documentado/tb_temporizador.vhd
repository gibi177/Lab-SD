-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Aluno: Felipe Lopes Gibin Duarte
-- Matrícula: 231025207
-- Data: 11/06/2024

-- Descrição: Implementação de um sistema de temporização do controle de semaforos

-- ****************************************** 
-- Testbench para a simulação do
-- Circuito: Sistema de temporização
-- RST             Entrada 1
-- CLK             Entrada 2
-- T5              Saida 1
-- T6              Saida 2
-- T20             Saida 3
-- T60             Saida 4
-- cont_dezena     Saida 5
-- cont_unidade    Saida 6
-- ******************************************

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;
use std.textio.all;

--Entidade
entity tb_temporizador is
end entity;
    
--Arquitetura
architecture testbench of tb_temporizador is

    --Declaracao do componente temporizador, referente a entidade do arquivo temporizador.vhd
    component temporizador is
        port (
            RST, CLK: in std_logic;
            T5, T6, T20, T60 : out std_logic;
            cont_dezena, cont_unidade : out std_logic_vector(3 downto 0)
        );
    end component;

    --Sinais auxiliares
    signal RST: std_logic := '0';
    signal CLK: std_logic := '0';
    signal T5, T6, T20, T60: std_logic;
    signal cont_dezena, cont_unidade: std_logic_vector(3 downto 0);

begin
    -- Instancia do componente temporizador
    dut: temporizador port map (
        RST => RST,
        CLK => CLK,
        T5 => T5,
        T6 => T6,
        T20 => T20,
        T60 => T60,
        cont_dezena => cont_dezena,
        cont_unidade => cont_unidade
    );

    --Criando o clock 
    CLK <= not CLK after 0.5 sec; --clock de 1 Hz

    --Processo de estimulo
    estimulo: process

    begin

        --Conta ate 60
        wait for 60 sec;

        --Reset
        RST <= '1';
        wait for 1 sec;
        RST <= '0';

        wait;
    end process;
end testbench;
