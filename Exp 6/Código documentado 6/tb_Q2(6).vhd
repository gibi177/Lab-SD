-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Aluno: Felipe Lopes Gibin Duarte
-- Matrícula: 231025207
-- Data: 07/05/2024

-- ******************************************
-- Testbench para a simulacao do 
-- Circuito: Registrador bidirecional
-- RST  Entrada 1 (reset)
-- LOAD Entrada 2 (load)
-- CLK  Entrada 3 (clock)
-- D    Entrada 4
-- DIR  Entrada 5 (direcao)
-- L    Entrada 6 (left)
-- R    Entrada 7 (right)
-- Q    Saida 1
-- ******************************************


--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;
use std.textio.all;

--Entidade
entity tb_Q2 is
end entity;

--Arquitetura
architecture testbench2 of tb_Q2 is
    
    --Declaracao do componente Q1, referente a entidade do arquivo Q2(6).vhd
    component Q2 is
        port (
        RST,LOAD,CLK,DIR,L,R: in std_logic;
        D: in std_logic_vector(3 downto 0);
        Q: out std_logic_vector(3 downto 0)
        );
    end component;

    -- Sinais auxiliares de entrada e saida
    signal RST : std_logic;
    signal LOAD : std_logic;
    signal CLK : std_logic := '0';
    signal DIR : std_logic;
    signal L: std_logic;
    signal R: std_logic;
    signal D : std_logic_vector(3 downto 0);
    signal Q : std_logic_vector(3 downto 0) := "1111";     --Inicializa pra n dar erro

begin

    -- Instancia do componente Q1
    dut: Q2 port map (
        RST => RST,
        LOAD => LOAD,
        CLK => CLK,
        DIR => DIR,
        L => L,
        R => R,
        D => D,
        Q => Q
    );

    --Criando o clock 
    CLK <= not CLK after 5ns;

    --Processo de estimulo
    estimulo: process

    begin 
        --Valores iniciais
        RST <= '0';
        LOAD <= '0';
        DIR <= '0';
        L <= '0';
        R <= '0';
        D <= "1111";
        wait for 20ns;          --Note que vai acontecer shift left 2 vezes

        RST <= '1'; wait for 10ns;
        RST <= '0';

        LOAD <= '1'; wait for 10ns;
        LOAD <= '0';

        DIR <= '0'; 
        L <= '0'; wait for 10ns;
        L <= '1'; wait for 10ns;

        DIR <= '1'; 
        R <= '0'; wait for 10ns;
        R <= '1'; wait for 10ns;
        
        LOAD <= '1'; wait for 10ns;

        wait;
    end process;
end testbench2;
