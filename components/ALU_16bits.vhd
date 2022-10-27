library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_16bits is
    Port (Din1:     in std_logic_vector(15 downto 0);
          Din2:     in std_logic_vector(15 downto 0);
          control:  in std_logic_vector(3 downto 0);
          zero:     out std_logic;
          result:   out std_logic_vector(15 downto 0)
          );
end ALU_16bits;

architecture Behavioral of ALU_16bits is
component add_16bits
        port(C_in:      in std_logic;
             a:         in std_logic_vector(15 downto 0);
             b:         in std_logic_vector(15 downto 0);
             result:    out std_logic_vector(15 downto 0)    
             );
end component;

component mux_2to1_nbits
        generic (N: integer :=16);
        port (sel:      in std_logic;
              Din1:     in std_logic_vector(N-1 downto 0);
              Din2:     in std_logic_vector(N-1 downto 0);
              Dout:     out std_logic_vector(N-1 downto 0)
              );
end component;

signal a,b,sum,Din2_Compl:      std_logic_vector(15 downto 0);

begin

Din2_Compl <= not Din2;
a <= Din1;

mux_2to1: mux_2to1_nbits
    port map(control(3),Din2,Din2_Compl,b);

adder: add_16bits
    port map(control(3),a,b,sum);



end Behavioral;
