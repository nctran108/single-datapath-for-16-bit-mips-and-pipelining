library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instructionMemory_pipeline is
    Port (
          ReadAddr:     in std_logic_vector(15 downto 0);
          instruction:  out std_logic_vector(15 downto 0)
          );
end instructionMemory_pipeline;

architecture Behavioral of instructionMemory_pipeline is
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
--              $v0 = $v0 � 8; 
--              $v1 = $v1 | $v0; //or 
--              Mem[$a0] = FF00hex; 
--          } 
--          else { 
--              $v2 = $v2 � 4; 
--              $v3 = $v3 ? $v2; //xor 
--              Mem[$a0] = 00FFhex; 
--          } 
--          $a0 = $a0 + 2; 
--          } 
--      return;
constant memory: ram:=(
       "0001000000100100",--00
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0001000000110001",--04
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0001000001000101",--08      
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0001000001100001",--0C
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110001000100100",--10
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110001100110100",--14
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1111010001000011",--18
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110011001100100",--1C
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0001000001110101",--20
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110001100110100",--24
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110010001010100",--28
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0001000010000000",--2C
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110011011000100",--30
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0001001100110001",--34
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0010010001011110",--38
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--3C
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--40
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110001100110100",--44
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110111011010100",--48
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1010000001110001",--4C
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0001000010010001",--50
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0101011010000000",--54
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110110111110100",--58
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1011000000010111",--5C
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0011011110010111",--60
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--64
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--68
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0111000000100011",--6C
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--70
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--74
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--78
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1010110010000001",--7c
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0001000010010100",--80
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--84
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--88
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1011000000010100",--8c
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110100110010001",--90
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--94
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--98
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0111000000001100",--9c
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1000001010010010",--a0
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0110011011110000",--a4
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--a8
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--ac
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1001001100100011",--b0
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0111000000001001",--b4
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--b8
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--bc
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--c0
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1111010001000100",--c4
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--c8
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--cc
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--d0
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0100010100100101",--d4
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0110011011100000",--d8
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0001011001100010",--dc
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "0111111111010111",--e0
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--e4
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--e8
       "0000000000000000",
       "0000000000000000",
       "0000000000000000",
       "1110000000000000",--ec
       OTHERS => x"0000");

begin
process(ReadAddr)
begin   
    instruction <= memory(to_integer(unsigned(ReadAddr)));
end process;
end Behavioral;