-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Aluno: Felipe Lopes Gibin Duarte
-- Matrícula: 231025207
-- Data: 11/06/2024

-- Descrição: Implementação de um contador mod 100, usando 2 contadores mod 10

-- ****************************************** 
-- Circuito: Contador mod 100
-- EN  Entrada 1 (EN ativo em baixo)
-- CLK Entrada 2 (Clock)
-- RST Entrada 3 (Reset)
-- LOAD Entrada 4
-- dezload Entrada 5 ()
-- uniload Entrada 6
-- cont_dezena Saida 1
-- cont_unidade Saida 2
-- ******************************************

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;

--Entidade
entity contador100 is
    port (
        EN,CLK,RST,LOAD : in std_logic;
        dezload, uniload :in std_logic_vector(3 downto 0);
        cont_dezena, cont_unidade: out std_logic_vector(3 downto 0)
    );
end contador100;

--Arquitetura
architecture arq of contador100 is

    --Componente contador 10, referente à entidade do arquivo contador10.vhd
    component contador10 is 
        port (
            EN,CLK,RST,RCI,LOAD : in std_logic;
            D: in std_logic_vector(3 downto 0);
            Q: out std_logic_vector(3 downto 0);
            RCO: out std_logic
        );
    end component;

    --Sinais auxiliares
    signal RCO_unidade: std_logic;
    signal EN_dezena : std_logic;

begin

    -- Instância do contador de unidades
    U1: contador10 
        port map (
            EN => EN,
            CLK => CLK,
            RST => RST,
            RCI => '0', -- sempre ativo (em baixo)
            LOAD => LOAD,
            D => uniload,
            Q => cont_unidade,
            RCO => RCO_unidade
        );
    
    -- Enable do contador das dezenas com base no rco da unidade
    EN_dezena <= RCO_unidade;

    -- Instância do contador de dezenas
    U2: contador10 
        port map (
            EN => EN_dezena,
            CLK => CLK,
            RST => RST,
            RCI => '0', -- sempre ativo (em baixo)
            LOAD => LOAD,
            D => dezload,
            Q => cont_dezena,
            RCO => open -- RCO do contador de dezenas não é usado
        );
end arq;
