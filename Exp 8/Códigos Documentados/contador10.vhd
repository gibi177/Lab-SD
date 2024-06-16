-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Aluno: Felipe Lopes Gibin Duarte
-- Matrícula: 231025207
-- Data: 11/06/2024

-- Descrição: Implementação de um contador mod 10, com RST e LOAD sincronos

-- ****************************************** 
-- Circuito: Contador mod 10
-- EN  Entrada 1 (EN ativo em baixo)
-- CLK Entrada 2 (Clock)
-- RST Entrada 3 (Reset)
-- RCI Entrada 4 (ripple carry in ativo baixo)
-- LOAD Entrada 5
-- D   Entrada 6 (seleciona estado)
-- Q (Saida 1)
-- RCO (Saida 2 ativo baixo, e zero quando Q=1001)
-- ******************************************

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;

--Entidade
entity contador10 is
    port (
        EN,CLK,RST,RCI,LOAD : in std_logic;
        D: in std_logic_vector(3 downto 0);
        Q: out std_logic_vector(3 downto 0);
        RCO: out std_logic
    );
end contador10;

--Arquitetura
architecture arq of contador10 is

    --Estados possiveis usando tipo state   
    type state is (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9);

    --Sinais auxiliares
    signal current_state: state;
    signal next_state: state;
    signal load_state: state;

begin
    with D select
        load_state <= S0 when "0000",
                        S1 when "0001",
                        S2 when "0010",
                        S3 when "0011",
                        S4 when "0100",
                        S5 when "0101",
                        S6 when "0110",
                        S7 when "0111",
                        S8 when "1000",
                        S9 when "1001",
                        S0 when others;

    --Processo síncrono da maq de estados
    process (CLK)
    begin
        if rising_edge(CLK) then 
            current_state <= next_state;
        end if;
    end process;

    --Processo combinacional da maq de estados
    process (current_state, RST, EN, RCI, LOAD, load_state)
    begin
        case current_state is
            when S0 =>
                Q <= "0000";
                RCO <= '1'; -- E zero so em 1001 (9)
                if (RST = '1') then next_state <= S0;
                elsif (LOAD = '1') then next_state <= load_state;
                elsif ((EN = '0') and (RCI = '0')) then next_state <= S1;
                else next_state <= S0;
                end if;

            when S1 =>
                Q <= "0001";
                RCO <= '1';
                if (RST = '1') then next_state <= S0;
                elsif (LOAD = '1') then next_state <= load_state;
                elsif ((EN = '0') and (RCI = '0')) then next_state <= S2;
                else next_state <= S1;
                end if;

            when S2 =>
                Q <= "0010";
                RCO <= '1';
                if (RST = '1') then next_state <= S0;
                elsif (LOAD = '1') then next_state <= load_state;
                elsif ((EN = '0') and (RCI = '0')) then next_state <= S3;
                else next_state <= S2;
                end if;

            when S3 =>
                Q <= "0011";
                RCO <= '1';
                if (RST = '1') then next_state <= S0;
                elsif (LOAD = '1') then next_state <= load_state;
                elsif ((EN = '0') and (RCI = '0')) then next_state <= S4;
                else next_state <= S3;
                end if;

            when S4 =>
                Q <= "0100";
                RCO <= '1';
                if (RST = '1') then next_state <= S0;
                elsif (LOAD = '1') then next_state <= load_state;
                elsif ((EN = '0') and (RCI = '0')) then next_state <= S5;
                else next_state <= S4;
                end if;

            when S5 =>
                Q <= "0101";
                RCO <= '1';
                if (RST = '1') then next_state <= S0;
                elsif (LOAD = '1') then next_state <= load_state;
                elsif ((EN = '0') and (RCI = '0')) then next_state <= S6;
                else next_state <= S5;
                end if;

            when S6 =>
                Q <= "0110";
                RCO <= '1';
                if (RST = '1') then next_state <= S0;
                elsif (LOAD = '1') then next_state <= load_state;
                elsif ((EN = '0') and (RCI = '0')) then next_state <= S7;
                else next_state <= S6;
                end if;

            when S7 =>
                Q <= "0111";
                RCO <= '1';
                if (RST = '1') then next_state <= S0;
                elsif (LOAD = '1') then next_state <= load_state;
                elsif ((EN = '0') and (RCI = '0')) then next_state <= S8;
                else next_state <= S7;
                end if;

            when S8 =>
                Q <= "1000";
                RCO <= '1';
                if (RST = '1') then next_state <= S0;
                elsif (LOAD = '1') then next_state <= load_state;
                elsif ((EN = '0') and (RCI = '0')) then next_state <= S9;
                else next_state <= S8;
                end if;

            when S9 =>
                Q <= "1001";
                RCO <= '0';
                if (RST = '1') then next_state <= S0;
                elsif (LOAD = '1') then next_state <= load_state;
                elsif ((EN = '0') and (RCI = '0')) then next_state <= S0;
                else next_state <= S9;
                end if;

            when others => --caso caia em um estado nao especificado
                Q <= "0000"; 
                RCO <= '1';
                if (RST = '1') then next_state <= S0;
                elsif (LOAD = '1') then next_state <= load_state;
                elsif ((EN = '0') and (RCI = '0')) then next_state <= S1;
                else next_state <= S0;
                end if; 

        end case;
    end process;
end arq;