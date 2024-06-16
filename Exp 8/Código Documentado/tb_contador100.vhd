-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Aluno: Felipe Lopes Gibin Duarte
-- Matrícula: 231025207
-- Data: 11/06/2024

-- Descrição: Implementação de um contador mod 100, usando 2 contadores mod 10

-- ****************************************** 
-- Testbench para a simulação do
-- Circuito: Contador mod 100
-- EN  Entrada 1 (EN ativo em baixo)
-- CLK Entrada 2 (Clock)
-- RST Entrada 3 (RST)
-- LOAD Entrada 4
-- dezload Entrada 5 ()
-- uniload Entrada 6
-- cont_dezena Saida 1
-- cont_unidade Saida 2
-- ******************************************

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;
use std.textio.all;

--Entidade
entity tb_contador100 is
end entity;

--Arquitetura
architecture testbench of tb_contador100 is

    --Declaracao do componente contador100, referente a entidade do arquivo contador100.vhd
    component contador100 is
        port (
            EN,CLK,RST,LOAD : in std_logic;
            dezload, uniload :in std_logic_vector(3 downto 0);
            cont_dezena, cont_unidade: out std_logic_vector(3 downto 0)
        );
    end component;

    --Sinais auxiliares
    signal CLK  :std_logic := '1';
    signal RST, EN, LOAD :std_logic;
    signal dezload, uniload :std_logic_vector(3 downto 0);
    signal cont_dezena, cont_unidade :std_logic_vector(3 downto 0);

begin
    -- Instancia do componente contador100
    dut: contador100 port map (
        EN => EN,
        CLK => CLK,
        RST => RST,
        LOAD => LOAD,
        dezload => dezload,
        uniload => uniload,
        cont_dezena => cont_dezena,
        cont_unidade => cont_unidade
    );

    --Criando o clock 
    CLK <= not CLK after 0.5 sec; --clock de 1 Hz

    --Processo de estimulo
    estimulo: process

    begin
        -- Inicializa inputs
        EN <= '0';  -- (ativo em baixo)
        RST <= '0';  -- (ativo em alto)
        LOAD <= '0'; -- Load (ativo em alto)
        dezload <= "0000";
        uniload <= "0000";

        --espera 100 subidas do clock
        wait for 100 sec;

        --testa load
        LOAD <= '1';
        dezload <= "0011";
        uniload <= "0001";
        wait for 1 sec;
        LOAD <= '0';
        wait for 2 sec;

        RST <= '1';
        wait for 1 sec;
        RST <= '0';
        wait for 2 sec;
          
    end process;
end testbench; 
