--Descricao: Implementar funcao  booleana usando um decodificador e um multiplexador
-- ***********************************
--Circuito: Funcao booleana:
--S = F.G + A.B.C.D.E'.F'.G + A'.B'.C'.D'.E'.F'.G + A.B'.C.E.F.G' + A'.B.C.D.E'.F.G' + A.B.C.D.E.F'.G' + A.B'.C'.D.E.F'.G'
-- A: Entrada 1
-- B: Entrada 2
-- C: Entrada 3
-- D: Entrada 4
-- E: Entrada 5
-- F: Entrada 6
-- G: Entrada 7
-- S: Saida 

-- ***********************************

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;

--Entidade
entity Q2 is
    port(
        A,B,C,D,E,F,G: in std_logic;                     --Entrada
        S: out std_logic                                 --Saida
    );
end Q2;

--Arquitetura
architecture arqQ2 of Q2 is 

        --Componente decoder(decodificador)
        component Decoder4x16 is 
            port(
                A : in std_logic_vector(3 downto 0);        --Entrada
                Y : out std_logic_vector(15 downto 0)       --Saida
            );
        end component Decoder4x16;

        --Componente Mux(Multiplexador)
        component Mux8x1 is 
            port(
                I: in std_logic_vector(7 downto 0);        --Entradas
                Se: in std_logic_vector(2 downto 0);       --Seletora
                Z: out std_logic                           --Saida
            );
        end component Mux8x1;

        --Sinais auxiliares
        signal dec_out: std_logic_vector(15 downto 0);
        signal mux_in: std_logic_vector(7 downto 0);
        signal selects: std_logic_vector(3 downto 0);

        --Comeca de fato aqui
        begin
            selects <= A & B & C & D;
            --Instancia do componente Decoder4x16 e conexao dos componentes a entrada da funcao
            Deco1: Decoder4x16 
            port map(
                A(3) => A,
                A(2) => B,
                A(1) => C,
                A(0) => D,
                Y => dec_out
            );

            --Instancia do componente Mux8x1 e conexao dos componentes a entrada da funcao
            Mux1: Mux8x1 
            port map(
                I => mux_in,
                Se(2) => E,         --Entradas da funcao sendo usadas como seletoras do mux
                Se(1) => F,
                Se(0) => G,
                Z => S              --Saida S da funcao
            );

            --Setando as saidas do decoder
            with (selects) select
            dec_out <=  "0000000000000001" when "0000",
                        "0000000000000010" when "0001",
                        "0000000000000100" when "0010",
                        "0000000000001000" when "0011",
                        "0000000000010000" when "0100",
                        "0000000000100000" when "0101",
                        "0000000001000000" when "0110",
                        "0000000010000000" when "0111",
                        "0000000100000000" when "1000",
                        "0000001000000000" when "1001",
                        "0000010000000000" when "1010",
                        "0000100000000000" when "1011",
                        "0001000000000000" when "1100",
                        "0010000000000000" when "1101",
                        "0100000000000000" when "1110",
                        "1000000000000000" when others;

            --Associando as saidas do decoder as entradas do mux
            --Termo FG implica que EFG= 011(I3) ou 111(I7) a funcao é 1
            --Termo ABCDE'F'G implica que 1111(Y15) do decoder associa com 001(I1) do mux
            --Outros termos analogos
            --Os que sobraram (I0 e I5) sao 0
            mux_in(0) <= '0';
            mux_in(1) <= dec_out(15) or dec_out(0);
            mux_in(2) <= dec_out(7);
            mux_in(3) <= '1';                                 
            mux_in(4) <= dec_out(15) or dec_out(9);
            mux_in(5) <= '0';                                 
            mux_in(6) <= dec_out(11);
            mux_in(7) <= '1';



            --Logica da saida do mux
            S <= mux_in(0) when E='0' and F='0' and G='0' else
                 mux_in(1) when E='0' and F='0' and G='1' else
                 mux_in(2) when E='0' and F='1' and G='0' else
                 mux_in(3) when E='0' and F='1' and G='1' else
                 mux_in(4) when E='1' and F='0' and G='0' else
                 mux_in(5) when E='1' and F='0' and G='1' else
                 mux_in(6) when E='1' and F='1' and G='0' else
                 mux_in(7);

end architecture arqQ2;