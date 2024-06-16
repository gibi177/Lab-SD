-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Aluno: Felipe Lopes Gibin Duarte
-- Matrícula: 231025207
-- Data: 11/06/2024

-- Descrição: Implementação de uma maquina de estados que realiza o controle do semaforo

-- ****************************************** 
-- Circuito: Maquina de estados
-- CLK           Entrada 1
-- ligadesliga   Entrada 2
-- sensorA       Entrada 3
-- sensorB       Entrada 4
-- T5            Entrada 5
-- T6            Entrada 6
-- T20           Entrada 7
-- T60           Entrada 8
-- semaforoA     Saida 1
-- semaforoB     Saida 2
-- resetcounter  Saida 3
-- ******************************************

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;

--Entidade
entity MaqEstados is
    port (
        CLK, ligadesliga, sensorA, sensorB, T5, T6, T20, T60 :in std_logic;
        semaforoA, semaforoB :out std_logic_vector(2 downto 0);
        resetcounter :out std_logic
    );
end MaqEstados;

architecture arq of MaqEstados is

    type state is (A_GREEN, A_YELLOW, BOTH_RED1, B_GREEN, B_YELLOW, BOTH_RED2, INTERMITENT);

    --Sinais auxiliares
    signal current_state: state := A_GREEN;    --começa no norte/sul verde
    signal next_state: state;
    signal semaforoA_lights, semaforoB_lights: std_logic_vector(2 downto 0);

begin

    --Processo síncrono da maq de estados
    process (CLK, ligadesliga)
    begin
        if rising_edge(clk) or rising_edge(ligadesliga) or falling_edge(ligadesliga) then
            current_state <= next_state;
        end if;
    end process;

    --Processo combinacional da maq de estados
    process (ligadesliga, sensorA, sensorB, T5, T6, T20, T60, current_state)
    begin

        --Valores iniciais
        semaforoA_lights <= "000"; -- Desligado
        semaforoB_lights <= "000"; -- Desligado
        resetcounter <= '0';

        case current_state is

            when A_GREEN =>
                semaforoA_lights <= "010"; -- Green
                semaforoB_lights <= "100"; -- Red
                if ligadesliga = '0' then
                    next_state <= INTERMITENT;
                elsif T60 = '1' or (T20 = '1' and sensorB = '1' and sensorA = '0') then
                    next_state <= A_YELLOW;
                    resetcounter <= '1';
                else
                    next_state <= A_GREEN;
                end if;
            
            when A_YELLOW =>
                semaforoA_lights <= "001"; -- Yellow
                semaforoB_lights <= "100"; -- Red
                if ligadesliga = '0' then
                    next_state <= INTERMITENT;
                elsif T6 = '1' then
                    next_state <= BOTH_RED1;
                    resetcounter <= '1';
                else
                    next_state <= A_YELLOW;
                end if;

            when BOTH_RED1 =>
                semaforoA_lights <= "100"; -- red
                semaforoB_lights <= "100"; -- Red
                if ligadesliga = '0' then
                    next_state <= INTERMITENT;
                elsif T5 = '1' then
                    next_state <= B_GREEN;
                    resetcounter <= '1';
                else
                    next_state <= BOTH_RED1;
                end if;
            
            when B_GREEN =>
                semaforoA_lights <= "100"; -- red
                semaforoB_lights <= "010"; -- green
                if ligadesliga = '0' then
                    next_state <= INTERMITENT;
                elsif T60 = '1' or (T20 = '1' and sensorA = '1' and sensorB = '0') then
                    next_state <= B_YELLOW;
                    resetcounter <= '1';
                else
                    next_state <= B_GREEN;
                end if;

            when B_YELLOW =>
                semaforoA_lights <= "100"; -- red
                semaforoB_lights <= "001"; -- yellow
                if ligadesliga = '0' then
                    next_state <= INTERMITENT;
                elsif T6 = '1' then
                    next_state <= BOTH_RED2;
                    resetcounter <= '1';
                else
                    next_state <= B_YELLOW;
                end if;

            when BOTH_RED2 =>
                semaforoA_lights <= "100"; -- red
                semaforoB_lights <= "100"; -- Red
                if ligadesliga = '0' then
                    next_state <= INTERMITENT;
                elsif T5 = '1' then
                    next_state <= A_GREEN;
                    resetcounter <= '1';
                else
                    next_state <= BOTH_RED2;
                end if;

            when INTERMITENT =>
                semaforoA_lights <= "001"; -- Yellow 
                semaforoB_lights <= "001"; -- Yellow 
                if ligadesliga = '1' then
                    next_state <= A_GREEN;
                else
                    next_state <= INTERMITENT;
                end if;

            when others =>                    --caso caia em um estado n definido, vai pra norte/sul verde
                next_state <= A_GREEN;
        end case;
    end process;

    --Liga sinais das luzes dos semaforos as saidas da entidade
    semaforoA <= semaforoA_lights;
    semaforoB <= semaforoB_lights;

end arq;
