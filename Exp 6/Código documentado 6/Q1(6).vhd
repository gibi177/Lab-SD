-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Aluno: Felipe Lopes Gibin Duarte
-- Matrícula: 231025207
-- Data: 07/05/2024

-- Descrição: Implementação de um flip-flop JK gatilhado na borda de subida

-- ****************************************** 
-- Circuito: Flip-Flop JK:
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

--Entidade
entity Q1 is
    port(
        PR,CLR,CLK,J,K: in std_logic;
        Q: out std_logic
    );
end Q1;

--Arquitetura
architecture arq of Q1 is

--Sinais auxiliares
signal JK: std_logic_vector(1 downto 0);
signal Q_atual: std_logic := '0';             --Inicializa com 0 para evitar algum tipo de indefinicao

begin
    JK <= J & K;

    process (PR, CLR, CLK)
    begin

        if PR ='1' then 
            Q_atual <= '1';
        elsif CLR = '1' then 
            Q_atual <= '0';
        elsif rising_edge(CLK) then 
            if JK = "00" then                         --Hold
                Q_atual <= Q_atual; end if;
            if JK = "10" then                         --Set
                Q_atual <= '1'; end if;
            if JK = "01" then                         --Reset
                Q_atual <= '0'; end if;
            if JK = "11" then                         --Inverte
                Q_atual <= not Q_atual; end if;
        end if;
    
    end process;

    Q <= Q_atual;

end arq;