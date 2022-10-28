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
component add_16bits is
    Port (C_in:     in std_logic;
          Din1:     in std_logic_vector(15 downto 0);
          Din2:     in std_logic_vector(15 downto 0);
          Dout:     out std_logic_vector(15 downto 0)
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

component mul_16bits
        port (a:        in std_logic_vector(15 downto 0);
              b:        in std_logic_vector(15 downto 0);
              result:   out std_logic_vector(15 downto 0)
              );
end component;

component div_16bits
        port (a:        in std_logic_vector(15 downto 0);
              b:        in std_logic_vector(15 downto 0);
              result:   out std_logic_vector(15 downto 0)
              );
end component;

component setLessThan_16bits
        port (a:        in std_logic_vector(15 downto 0);
              b:        in std_logic_vector(15 downto 0);
              result:   out std_logic_vector(15 downto 0)
              );
end component;

component mux_8to1_16bits is
    Port (sel:      in std_logic_vector(2 downto 0);
          a:      in std_logic_vector(15 downto 0);
          b:      in std_logic_vector(15 downto 0);
          c:      in std_logic_vector(15 downto 0);
          d:      in std_logic_vector(15 downto 0);
          e:      in std_logic_vector(15 downto 0);
          f:      in std_logic_vector(15 downto 0);
          g:      in std_logic_vector(15 downto 0);
          h:      in std_logic_vector(15 downto 0);
          result: out std_logic_vector(15 downto 0)          
          );
end component;

component shift_left_2 is
    generic (N: integer := 16);
    Port (Din1:      in std_logic_vector(N-1 downto 0);
          Din2:     in std_logic_vector(N-1 downto 0);
          Dout:     out std_logic_vector(N-1 downto 0)
          );
end component;

signal a,b,sum,Din2_Compl:      std_logic_vector(15 downto 0);
signal r_xor, r_or:             std_logic_vector(15 downto 0);
signal r_mul, r_div, r_slt:     std_logic_vector(15 downto 0);
signal r_sll:                   std_logic_vector(15 downto 0);
signal ALU_result:              std_logic_vector(15 downto 0);
signal zero_result:             std_logic;

begin

Din2_Compl <= not Din2;
a <= Din1;

mux_2to1: mux_2to1_nbits
    port map(control(3),Din2,Din2_Compl,b);

adder: add_16bits
    port map(control(3),a,b,sum);

r_xor <= a xor b;

r_or <= a or b;

multiplier: mul_16bits
    port map(a,b,r_mul);

division: div_16bits
    port map(a,b,r_div);
    
set_less_than: setLessThan_16bits
    port map(a,b,r_slt);
    
shift_left: shift_left_2
    port map(a,b,r_sll);
    
mux_8to1: mux_8to1_16bits
    port map(control(2 downto 0),sum,r_xor,r_or,r_mul,r_div,r_slt,r_sll,x"0000",ALU_result);

process(ALU_result)
begin
    if ALU_result = x"0000" then
        zero_result <= '1';
    else
        zero_result <= '0';
    end if;
    result <= ALU_result;
    zero <= zero_result;
end process;

end Behavioral;
