-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Aluno: Felipe Lopes Gibin Duarte
-- Matrícula: 231025207
-- Data: 11/06/2024

-- Descrição: Implementação de um indicador de tempo decorrido: se passaram 5 segundos (T5), 6 segundos (T6), 20 segundos (T20) ou 60 segundos (T60)

-- ****************************************** 
-- Circuito: Verificador de tempo decorrido
-- cont_dezena     Entrada 1
-- cont_unidade    Entrada 2
-- T5              Saida 1
-- T6              Saida 2
-- T20             Saida 3
-- T60             Saida 4
-- ******************************************

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;

--Entidade
entity timeflags is
    port (
        cont_dezena, cont_unidade :in std_logic_vector(3 downto 0);
        T5, T6, T20, T60 :out std_logic
    );
end timeflags;

architecture arq of timeflags is

    --Sinais auxiliares
    signal auxiliar: std_logic_vector(7 downto 0);   

begin

    auxiliar <= cont_dezena & cont_unidade;  --Junta dezena e unidade para ficar mais facil de escrever em hexadecimal

    T5 <= '1' when auxiliar >= x"05" else 
          '0';
    T6 <= '1' when auxiliar >= x"06" else 
          '0';
    T20 <= '1' when auxiliar >= x"20" else 
           '0';
    T60 <= '1' when auxiliar >= x"60" else 
           '0';
end arq;