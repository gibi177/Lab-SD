-- Testbench que comparando a saida da questao 1 (dut) com a questao 2 (golden model)

-- ******************************************
-- Testbench para a simulacao do 
--  Circuito: Somador de palavras de 4 bits:
-- A Entrada 1
-- B Entrada 2
-- S Saida
-- ******************************************

--Bibliotecas
library IEEE;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;  -- Para reconhecer o to_unsigned

--Entidade
entity tb_Q3 is 
end tb_Q3;

--Arquitetura
architecture testbench of tb_Q3 is

    -- Componente Q1, referente a entidade do arquivo Q1.vhd
    component Q1
        port(
            A: in std_logic_vector(3 downto 0);
            B: in std_logic_vector(3 downto 0);
            S: out std_logic_vector(4 downto 0)
        );
    end component;

    -- Componente Q2, referente a entidade do arquivo Q2.vhd
    component Q2
        port(
            A: in std_logic_vector(3 downto 0);
            B: in std_logic_vector(3 downto 0);
            S: out std_logic_vector(4 downto 0)
        );
    end component;

    -- Sinais auxiliares
    signal A, B: std_logic_vector(3 downto 0);
    signal DUT, GM: std_logic_vector(4 downto 0);

begin
    -- Instancia do DUT (questao 1)
    inst_DUT: Q1 port map (
        A => A,
        B => B,
        S => DUT
    );

    -- Instancia do Golden Model (questao 2)
    inst_GM: Q2 port map (
        A => A,
        B => B,
        S => GM
    );

    -- Processo de Teste
    process
    begin
        for i in 0 to 15 loop
            for j in 0 to 15 loop
                A <= std_logic_vector(to_unsigned(i, 4));
                B <= std_logic_vector(to_unsigned(j, 4));
                wait for 500 ns; -- Aguarda 500 ns entre combinações
                
                assert(DUT = GM) report "Teste Falhou" severity ERROR;
                
            end loop;
        end loop;
        wait;  -- Finaliza o processo
    end process;

end architecture testbench;
