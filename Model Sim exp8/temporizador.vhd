-- Universidade de Brasília
-- Laboratório de Sistemas Digitais
-- Aluno: Felipe Lopes Gibin Duarte
-- Matrícula: 231025207
-- Data: 11/06/2024

-- Descrição: Implementação de um sistema de temporização do controle de semaforos

-- ****************************************** 
-- Circuito: Sistema de temporização
-- RST             Entrada 1
-- CLK             Entrada 2
-- T5              Saida 1
-- T6              Saida 2
-- T20             Saida 3
-- T60             Saida 4
-- cont_dezena     Saida 5
-- cont_unidade    Saida 6
-- ******************************************

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;

--Entidade
entity temporizador is
    port (
        RST, CLK: in std_logic;
        T5, T6, T20, T60 : out std_logic;
        cont_dezena, cont_unidade : out std_logic_vector(3 downto 0)
    );
end temporizador;

architecture arq of temporizador is

    --Componente contador 100, referente à entidade do arquivo contador100.vhd
    component contador100 is
        port (
            EN,CLK,RST,LOAD : in std_logic;
            dezload, uniload :in std_logic_vector(3 downto 0);
            cont_dezena, cont_unidade: out std_logic_vector(3 downto 0)
        );
    end component;

    --Componente timeflags, referente a entidade do arquivo timeflags.vhd
    component timeflags is
        port (
            cont_dezena, cont_unidade :in std_logic_vector(3 downto 0);
            T5, T6, T20, T60 :out std_logic
        );
    end component;

    --Sinais auxiliares
    signal sig_dezena, sig_unidade: std_logic_vector(3 downto 0);   --Vai conectar a saida do contador a entrada do timeflags
    signal EN: std_logic := '0';                                    --Sinal de enable inicializado em zero(ativo em baixo)

begin
    
    --Instancia do componente contador100
    U1: contador100
        port map (
            EN => EN,
            CLK => CLK,
            RST => RST,
            LOAD => '0',                -- LOAD inativo
            dezload => (others => '0'), -- Valor inicial zerado
            uniload => (others => '0'), -- Valor inicial zerado
            cont_dezena => sig_dezena,
            cont_unidade => sig_unidade
        );

    -- Instancia do componente timeflags
    U2: timeflags
        port map (
            cont_dezena => sig_dezena,
            cont_unidade => sig_unidade,
            T5 => T5,
            T6 => T6,
            T20 => T20,
            T60 => T60
        );
    
    -- Saidas do temporizador <= saidas do contador
    cont_dezena <= sig_dezena;
    cont_unidade <= sig_unidade;

end arq;
