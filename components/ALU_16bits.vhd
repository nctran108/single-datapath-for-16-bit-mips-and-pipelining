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
signal a,b,sum,Din2_Compl:      std_logic_vector(15 downto 0);
signal r_xor, r_or:             std_logic_vector(15 downto 0);
signal r_mul, r_div, r_slt:     std_logic_vector(15 downto 0);
signal r_sll:                   std_logic_vector(15 downto 0);
signal ALU_result:              std_logic_vector(15 downto 0);
signal isEqual, isNotEqual:     std_logic_vector(15 downto 0);
signal equal_sig:               std_logic_vector(15 downto 0);

begin

Din2_Compl <= not Din2;
a <= Din1;

mux_2to1: entity work.mux_2to1_nbits(Behavioral)
      port map(sel => control(3),
               Din1 => Din2,
               Din2 => Din2_Compl,
               Dout => b
               );

adder: entity work.add_16bits(Behavioral)
    port map(C_in => control(3),
             Din1 =>a,
             Din2 => b,
             Dout => sum);

r_xor <= a xor b;

r_or <= a or b;

multiplier: entity work.mul_16bits(Behavioral)
    port map(a => a,
             b => b,
             result => r_mul);

division: entity work.div_16bits(Behavioral)
    port map(a => a,
             b => b,
             result => r_div);
    
set_less_than: entity work.setLessThan_16bits(Behavioral)
    port map(a => a,
             b => b,
             rt => r_slt);
    
shiftLeft: entity work.shift_left_2(Behavioral)
    port map(Din1 => a,
             Din2 => b,
             Dout => r_sll);

check_equal: entity work.equal(Behavioral)
    port map(a => Din1,
             b => Din2,
             result => isEqual
             );
chech_not_equal: entity work.not_equal(Behavioral)
    port map(a => Din1,
             b => Din2,
             result => isNotEqual
             );
             
mux_2to1_2: entity work.mux_2to1_nbits(Behavioral)
    port map(sel => control(3),
             Din1 => isEqual,
             Din2 => isNotEqual,
             Dout => equal_sig
             );
    
mux_8to1: entity work.mux_8to1_16bits(Behavioral)
    port map(sel => control(2 downto 0),
             a => sum,
             b => r_xor,
             c => r_or,
             d => r_mul,
             e => r_div,
             f => r_slt,
             g => r_sll,
             h => equal_sig,
             output => ALU_result);

process(ALU_result)
variable zero_result: std_logic;
begin
    if ALU_result = x"0000" then
        zero_result := '1';
    else
        zero_result := '0';
    end if;
    result <= ALU_result;
    zero <= zero_result;
end process;

end Behavioral;
