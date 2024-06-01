-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Aluno: Felipe Lopes Gibin Duarte
-- Matrícula: 231025207
-- Data: 29/05/2024

-- Descrição: Implementação de uma máquina de estados do tipo Moore

-- ****************************************** 
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

--Entidade
entity Q1 is
    port (
        A: in std_logic_vector(1 downto 0);
        CLK: in std_logic;
        RST: in std_logic;
        R: out std_logic;
        T25: out std_logic;
        T50: out std_logic
    );
end Q1;

--Arquitetura
architecture arq of Q1 is

    --Estados possiveis usando tipo state   
    type state is (INIT, S025, TR025, S050, TR050, S075, TR075, S100, S125);

    --Sinais auxiliares
    signal current_state: state := INIT;
    signal next_state: state;
    
begin

    --Processo síncrono da maq de estados
    process (CLK, RST)
    begin
        if RST = '1' then
            current_state <= INIT;
        elsif rising_edge(CLK) then 
            current_state <= next_state;
        end if;
    end process;

    --Processo combinacional da maq de estados
    process (current_state, A)
    begin

        case current_state is 
            when INIT =>
                case A is 
                    when "00" => next_state <= INIT;
                    when "01" => next_state <= S025;
                    when "10" => next_state <= S050;
                    when others => next_state <= INIT;
                end case;
                R <= '0'; T25 <= '0'; T50 <= '0';
            
            when S025 =>
                case A is 
                    when "00" => next_state <= S025;
                    when "01" => next_state <= S050;
                    when "10" => next_state <= S075;
                    when others => next_state <= TR025;
                end case;
                R <= '0'; T25 <= '0'; T50 <= '0';

            when TR025 =>
                case A is 
                    when "00" => next_state <= INIT;
                    when "01" => next_state <= S025;
                    when "10" => next_state <= S050;
                    when others => next_state <= INIT;
                end case;
                R <= '0'; T25 <= '1'; T50 <= '0'; 
            
            when S050 =>
                case A is 
                    when "00" => next_state <= S050;
                    when "01" => next_state <= S075;
                    when "10" => next_state <= S100;
                    when others => next_state <= TR050;
                end case;
                R <= '0'; T25 <= '0'; T50 <= '0';
            
            when TR050 =>
                case A is 
                    when "00" => next_state <= INIT;
                    when "01" => next_state <= S025;
                    when "10" => next_state <= S050;
                    when others => next_state <= INIT;
                end case;
                R <= '0'; T25 <= '0'; T50 <= '1';
        
            when S075 =>
                case A is 
                    when "00" => next_state <= S075;
                    when "01" => next_state <= S100;
                    when "10" => next_state <= S125;
                    when others => next_state <= TR075;
                end case;
                R <= '0'; T25 <= '0'; T50 <= '0';
            
            when TR075 =>
                case A is 
                    when "00" => next_state <= INIT;
                    when "01" => next_state <= S025;
                    when "10" => next_state <= S050;
                    when others => next_state <= INIT;
                end case;
                R <= '0'; T25 <= '1'; T50 <= '1';
            
            when S100 =>
                case A is 
                    when "00" => next_state <= INIT;
                    when "01" => next_state <= S025;
                    when "10" => next_state <= S050;
                    when others => next_state <= INIT;
                end case;
                R <= '1'; T25 <= '0'; T50 <= '0';

            when S125 =>
                case A is 
                    when "00" => next_state <= INIT;
                    when "01" => next_state <= S025;
                    when "10" => next_state <= S050;
                    when others => next_state <= INIT;
                end case;
                R <= '1'; T25 <= '1'; T50 <= '0';
        
        end case;
    end process;
end arq;