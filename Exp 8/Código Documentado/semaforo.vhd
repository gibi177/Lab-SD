-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Aluno: Felipe Lopes Gibin Duarte
-- Matrícula: 231025207
-- Data: 11/06/2024

-- Descrição: Implementação de um semáforo utilizando uma máquina de estados

-- ******************************************************
-- Circuito: Semáforo
-- CLK           Entrada 1
-- ligadesliga   Entrada 2
-- sensorA       Entrada 3
-- sensorB       Entrada 4
-- cont_dezena   Entrada 5
-- cont_unidade  Entrada 6
-- semaforoA     Saida 1
-- semaforoB     Saida 2
-- ******************************************************

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;

--Entidade
entity semaforo is 
    port (
        CLK, ligadesliga, sensorA, sensorB: in std_logic;
        cont_dezena, cont_unidade: out std_logic_vector(3 downto 0);
        semaforoA, semaforoB : out std_logic_vector(2 downto 0)
    );
end semaforo;

--Arquitetura
architecture arq of semaforo is

    --Componente maqestados, referente à entidade do arquivo maqestados.vhd
    component maqestados is
        port (
            CLK, ligadesliga, sensorA, sensorB, T5, T6, T20, T60 :in std_logic;
            semaforoA, semaforoB :out std_logic_vector(2 downto 0);
            resetcounter :out std_logic
        );
    end component;

    --Componente temporizador, referente à entidade do arquivo temporizador.vhd
    component temporizador is
        port (
            RST, CLK: in std_logic;
            T5, T6, T20, T60 : out std_logic;
            cont_dezena, cont_unidade : out std_logic_vector(3 downto 0)
        );
    end component;

    --Sinais auxiliares
    signal T5, T6, T20, T60: std_logic;
    signal resetcounter: std_logic;

begin

    -- Instancia do temporizador
    U1: temporizador
        port map (
            RST => resetcounter,
            CLK => CLK,
            T5 => T5,
            T6 => T6,
            T20 => T20,
            T60 => T60,
            cont_dezena => cont_dezena,
            cont_unidade => cont_unidade
        );

    -- Instância do componente maqestados
    U2: maqestados
        port map (
            CLK => CLK,
            ligadesliga => ligadesliga,
            sensorA => sensorA,
            sensorB => sensorB,
            T5 => T5,
            T6 => T6,
            T20 => T20,
            T60 => T60,
            semaforoA => semaforoA,
            semaforoB => semaforoB,
            resetcounter => resetcounter
        );
end arq;
