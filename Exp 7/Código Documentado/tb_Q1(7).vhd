-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Aluno: Felipe Lopes Gibin Duarte
-- Matrícula: 231025207
-- Data: 29/05/2024

-- Descrição: Implementação de uma máquina de estados do tipo Moore

-- ****************************************** 
-- Testbench para a simulação do 
-- Circuito: Maq de estados
-- A   Entrada 1 (Entrada da maq)
-- CLK Entrada 2 (Clock)
-- RST Entrada 3 (Reset)
-- R   Saida 1 (Refri)
-- T25 Saida 2 (Troco $0.25)
-- T50 Saida 3 (Troco $0.50)
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
        port (
        A: in std_logic_vector(1 downto 0);
        CLK: in std_logic;
        RST: in std_logic;
        R: out std_logic;
        T25: out std_logic;
        T50: out std_logic
        );
    end component;

    -- Sinais auxiliares de entrada e saida
    signal CLK : std_logic := '0';
    signal RST: std_logic := '0';
    signal A: std_logic_vector(1 downto 0);
    signal R: std_logic;
    signal T25: std_logic;
    signal T50: std_logic;

begin

    -- Instancia do componente Q1
    dut: Q1 port map (
        RST => RST,
        CLK => CLK,
        A => A,
        R => R,
        T25 => T25,
        T50 => T50
    );

    --Criando o clock 
    CLK <= not CLK after 5ns;

    --Processo de estimulo
    estimulo: process

    begin

        --Testa manter estado
        A <= "00"; wait for 10ns;

        --Testa so moedas de 25
        A <= "01"; wait for 10ns; --vai pra S025
        A <= "01"; wait for 10ns; --vai pra S050
        A <= "01"; wait for 10ns; --vai pra S075
        A <= "01"; wait for 10ns; --vai pra S100
        A <= "11"; wait for 10ns; --vai pra INIT/ cancela S100

        --Testa 1 moeda de 25 e 2 de 50
        A <= "01"; wait for 10ns; --vai pra S025
        A <= "10"; wait for 10ns; --vai pra S075
        A <= "10"; wait for 10ns; --vai pra S125
        A <= "11"; wait for 10ns; --vai pra INIT / cancela S125

        --Cancela INIT
        A <= "11"; wait for 10ns; --vai pra INIT

        --Cancela S025
        A <= "01"; wait for 10ns; --vai pra S025
        A <= "11"; wait for 10ns; --vai pra TR025

        --Cancela S050
        A <= "10"; wait for 10ns; --vai pra S050
        A <= "11"; wait for 10ns; --vai pra TR050
        A <= "11"; wait for 10ns; --vai pra INIT
        
        --Testa reset assincrono
        A <= "10"; wait for 10ns; --vai pra TR050
        A <= "01"; wait for 10ns; --vai pra TR025
        A <= "11"; wait for 2.5 ns; --tempo curto, nao vai pra TR075
        RST <= '1'; --vai pra INIT

    end process;
end testbench;


