library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IF_ID is
    Port (clk, rst:                   in std_logic;
          IF_InstructionAdd:     in std_logic_vector(15 downto 0);
          IF_Instruction:        in std_logic_vector(15 downto 0);
          ID_instruction:        out std_logic_vector(15 downto 0);
          ID_instructionAdd:     out std_logic_vector(15 downto 0)
          );
end IF_ID;

architecture Behavioral of IF_ID is

begin
process(clk,rst)
begin
    if rst = '1' then
        ID_instruction <= x"0000";
        ID_instructionAdd <= x"0000";
    else
        if falling_edge(clk) then
            ID_instructionAdd <= IF_InstructionAdd;
            ID_instruction <= IF_instruction;
        end if;
    end if;
end process;
end Behavioral;
