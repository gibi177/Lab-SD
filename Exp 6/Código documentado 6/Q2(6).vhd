-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Aluno: Felipe Lopes Gibin Duarte
-- Matrícula: 231025207
-- Data: 07/05/2024

-- Descrição: Implementação de um registrador de deslocamento bidirecional de 4 bits gatilhado na borda de subida

-- ****************************************** 
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

--Entidade
entity Q2 is
    port (
        RST,LOAD,CLK,DIR,L,R: in std_logic;
        D: in std_logic_vector(3 downto 0);
        Q: out std_logic_vector(3 downto 0)
    );
end Q2;

--ArQ_atualuitetura
architecture arq of Q2 is

--Sinais auxiliares
signal Q_atual: std_logic_vector(3 downto 0) := "1111";       --Evitar erro de q indefinido no comeco

begin

    process(CLK)
    begin
        if rising_edge(CLK) then 
            if RST = '1' then                         --Reset
                Q_atual <= "0000";
            elsif LOAD = '1' then                     --Load
                Q_atual <= D;
            elsif DIR = '0' then                      --Shift left
                Q_atual <= Q_atual(2 downto 0) & L;
            elsif DIR = '1' then                      --Shift right
                Q_atual <= R & Q_atual(3 downto 1);
            end if;
        end if;
    end process;
    Q <= Q_atual;
end arq;
            