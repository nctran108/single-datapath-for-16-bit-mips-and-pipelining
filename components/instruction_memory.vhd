library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruction_memory is
    Port (clk:          in std_logic;
          ReadAddr:     in std_logic_vector(15 downto 0);
          instruction:  out std_logic_vector(15 downto 0)
          );
end instruction_memory;

architecture Behavioral of instruction_memory is
constant maxMem: integer := 65535;
type ram is array(0 to maxMem) of std_logic_vector(15 downto 0);
-- the assembly code that use for this lab
--      $v0 = 0040hex; // you can redefine $v0-3, $t0, and $a0-1 with 
--      $v1 = 1010hex; // your register numbers such as $1, $2, etc. 
--      $v2 = 000Fhex; 
--      $v3 = 00F0hex; 
--      $t0 = 0000hex; 
--      $a0 = 0010hex; 
--      $a1 = 0005hex; 
--      while ($a1 > 0) do { 
--          $a1 = $a1 -1; 
--          $t0 = Mem[$a0]; 
--          if ($t0 > 0100hex) then { 
--              $v0 = $v0 ÷ 8; 
--              $v1 = $v1 | $v0; //or 
--              Mem[$a0] = FF00hex; 
--          } 
--          else { 
--              $v2 = $v2 × 4; 
--              $v3 = $v3 ? $v2; //xor 
--              Mem[$a0] = 00FFhex; 
--          } 
--          $a0 = $a0 + 2; 
--          } 
--      return;

begin
process(clk,ReadAddr)
variable memory: ram:=(others => x"f000");
variable instruction_sig: std_logic_vector(15 downto 0) := (others => '0');
begin
    memory(2047) := "1100001000100100";
    memory(2051) := "1100001000100100";
    memory(2055) := "0000001100000001";
    memory(2059) := "1100001100111100";
    memory(2063) := "0000010000001111";
    memory(2067) := "1100010101000100";
    memory(2071) := "1011100000000000";
    memory(2075) := "0000011000000001";
    memory(2079) := "1100011001100100";
    memory(2083) := "0000011100000101";
    memory(2087) := "1000011110000001";
    memory(2091) := "1010000100000001";
    memory(2095) := "0111000000110100";
    memory(2099) := "0000100100000001";
    memory(2103) := "1101100110010000";
    memory(2107) := "0001011101111001";
    memory(2111) := "0101100001100000";
    memory(2115) := "0000100100000001";
    memory(2119) := "1100100110011000";
    memory(2123) := "1000100010010001";
    memory(2127) := "1010000100001010";
    memory(2131) := "1110010001000100";
    memory(2135) := "0100101001010000";
    memory(2139) := "0010101010100100";
    memory(2143) := "0100101101000000";
    memory(2147) := "0010010101011011";
    memory(2451) := "0011010101011010";
    memory(2155) := "0000100100001111";
    memory(2159) := "1100100110010100";
    memory(2163) := "0000100110011111";
    memory(2167) := "0110100101100000";
    memory(2171) := "0000100110010010";
    memory(2175) := "1011001000101001";
    memory(2179) := "0011001100110010";
    memory(2183) := "0000100100001111";
    memory(2187) := "1100100110010100";
    memory(2191) := "0000100110011111";
    memory(2195) := "1100100110011000";
    memory(2199) := "0110100101100000";
    memory(2203) := "0000011001100010";
    memory(2207) := "0111111111001001";
    memory(2211) := "1111000000000000";
    
    if falling_edge(clk) then
        instruction_sig := memory(to_integer(unsigned(ReadAddr)));
    else
        instruction_sig := instruction_sig;
    end if;
    instruction <= instruction_sig;
end process;
end Behavioral;
