--Descricao: Um multiplexador e um dispositivo digital que seleciona uma de varias fontes de dados e a direciona para um unico canal de saida.

-- *************
-- Circuito: Funcao x e y a partir de multiplexador
-- A Entrada 1
-- B Entrada 2
-- C Entrada 3
-- X Saida funcao 1
-- Y Saida funcao 2 

-- *************

-- Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;

-- Entidade
entity Q1 is
    port(
        A, B, C: in std_logic;
        X, Y: out std_logic
    );
end entity Q1;

-- Arquitetura
architecture arqQ1 of Q1 is

    -- Componente Mux4x1
    component Mux4x1 is
        port ( 
            I0, I1, I2, I3: in std_logic;          -- Entrada de 4 bits
            S: in std_logic_vector(1 downto 0);   -- Seletor de 2 bits
            Z: out std_logic                      -- Saída
        );
    end component Mux4x1;

    -- Sinal de seleção (A e B)
    signal selects: std_logic_vector(1 downto 0);
    
    -- Sinais para instância Mux1
    signal X_0, X_1, X_2, X_3, X_out: std_logic;

    -- Sinais para instância Mux2
    signal Y_0, Y_1, Y_2, Y_3, Y_out: std_logic;

begin
    -- A e B sendo usados como seletores, cada um como bit do sinal selects
    selects <= A & B;

    -- Mux com saida X
    process(C)
    begin
        X_0 <= '0';                             
        X_1 <= C;
        X_2 <= not C;
        X_3 <= '1';
    end process;

    -- Mux com saida Y
    process(C)
    begin
        Y_0 <= '1';                             
        Y_1 <= not C;
        Y_2 <= '0';
        Y_3 <= C;
    end process;

    -- Mapeamento dos sinais de X e Y
    X_out <= X_0 when (selects = "00") else
             X_1 when (selects = "01") else
             X_2 when (selects = "10") else
             X_3;  -- Quando selects = "11"
             
    Y_out <= Y_0 when (selects = "00") else
             Y_1 when (selects = "01") else
             Y_2 when (selects = "10") else
             Y_3;  -- Quando selects = "11"

    -- Instanciando e mapeando Mux1  
    Mux1 : Mux4x1
    port map (
        I0 => X_0,
        I1 => X_1,
        I2 => X_2,
        I3 => X_3,
        S => selects, 
        Z => X_out
    );
    
    -- Atribuindo saida do mux à porta X
    X <= X_out;

    -- Instanciando e mapeando Mux2
    Mux2 : Mux4x1
    port map (
        I0 => Y_0,
        I1 => Y_1,
        I2 => Y_2,
        I3 => Y_3,
        S => selects, 
        Z => Y_out
    );
    
    -- Atribuindo saida do mux à porta Y
    Y <= Y_out;

end architecture arqQ1;