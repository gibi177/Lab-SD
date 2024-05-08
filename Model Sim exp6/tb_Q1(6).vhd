-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Aluno: Felipe Lopes Gibin Duarte
-- Matrícula: 231025207
-- Data: 07/05/2024

-- ******************************************
-- Testbench para a simulacao do 
--  Circuito: flip-flop JK gatilhado na borda de subida
-- PR  Entrada 1 (preset)
-- CLR Entrada 2 (clear)
-- CLK Entrada 3 (clock)
-- J   Entrada 4
-- K   Entrada 5
-- Q   Saida
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
        PR,CLR,CLK,J,K: in std_logic;
        Q: out std_logic
        );
    end component;

    -- Sinais auxiliares de entrada e saida
    signal PR : std_logic;
    signal CLR : std_logic;
    signal CLK : std_logic := '0';
    signal JK : std_logic_vector(1 downto 0);
    signal Q : std_logic;

begin

    -- Instancia do componente Q1
    dut: Q1 port map (
        PR => PR,
        CLR => CLR,
        CLK => CLK,
        J => JK(1),
        K => JK(0),
        Q => Q
    );

    --Criando o clock 
    CLK <= not CLK after 5ns;

    --Processo de estimulo
    estimulo: process

    begin 
        --Valores iniciais
        PR <= '0';
        CLR <= '0';
        JK <= "00";
        wait for 10ns;

        --Testando o Preset
        PR <= '1'; wait for 10ns;
        PR <= '0'; wait for 10ns;

        --Testando o Clear
        CLR <= '1'; wait for 10ns;            --PR e zero para que CLR funcione normal
        CLR <= '0'; wait for 10ns;

        --Testando JK
        JK <= "10"; wait for 10ns;            --Set (Q=1)
        JK <= "00"; wait for 10ns;            --Hold (Q=1)
        JK <= "01"; wait for 10ns;            --Reset (Q=0)
        JK <= "00"; wait for 10ns;            --Hold (Q=0)
        JK <= "10"; wait for 10ns;            --Set (Q=1)
        JK <= "11"; wait for 10ns;            --Inverte (Q=0)
        JK <= "01"; wait for 10ns;            --Reset (Q=0)
        JK <= "11"; wait for 10ns;            --Inverte (Q=1)

        wait;
    end process;
end testbench;