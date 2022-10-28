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
variable memory: ram:=(others => x"0000");
variable instruction_sig: std_logic_vector(15 downto 0) := (others => '0');
begin
    memory(0) := "0001001000000010";
    memory(4) := "1110001000100100";
    memory(8) := "0001001100000001";
    memory(12) := "1110001100111100";
    memory(16) := "0001010000001111";
    memory(20) := "1110010101000100";
    memory(24) := "0001100000000000";
    memory(28) := "0001011000000001";
    memory(32) := "1110011001100100";
    memory(36) := "0001011100000101";
    memory(40) := "1010000001110001";
    memory(44) := "1011000100000001";
    memory(48) := "0111000000010111";
    memory(52) := "0001100100000001";
    memory(56) := "1101011110010111";
    memory(60) := "0101100001100000";
    memory(64) := "0001100100000001";
    memory(68) := "1110100110011000";
    memory(72) := "1010100110000001";
    memory(76) := "1011000100000110";
    memory(80) := "1111010001000100";
    memory(84) := "0100010100100101";
    memory(88) := "0001100100001111";
    memory(92) := "1110100110010100";
    memory(96) := "0001100110011111";
    memory(100) := "0110100101100000";
    memory(104) := "0001100110011000";
    memory(108) := "1101001000101001";
    memory(112) := "1001001100100011";
    memory(116) := "0001100100001111";
    memory(120) := "1110100110010100";
    memory(124) := "0001100110011111";
    memory(128) := "1110100110011000";
    memory(132) := "0110100101100000";
    memory(136) := "0001011001100010";
    memory(140) := "0111111111100110";
    
    if falling_edge(clk) then
        instruction_sig := memory(to_integer(unsigned(ReadAddr)));
    else
        instruction_sig := instruction_sig;
    end if;
    instruction <= instruction_sig;
end process;
end Behavioral;
