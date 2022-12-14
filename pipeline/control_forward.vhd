library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_forward is
    Port (EX_MEM_RegWrite: in       std_logic;
          EX_MEM_ALUResult:in       std_logic_vector(15 downto 0);
          EX_MEM_RegRd:    in       std_logic_vector(3 downto 0);
          ID_EX_RegRs:     in       std_logic_vector(3 downto 0);
          ID_EX_RegRt:     in       std_logic_vector(3 downto 0);
          Forward:        out      std_logic
          );
end control_forward;

architecture Behavioral of control_forward is

begin
process(EX_MEM_RegWrite,EX_MEM_ALUResult,EX_MEM_RegRd,ID_EX_RegRs,ID_EX_RegRt)
begin
    if EX_MEM_RegWrite = '1' and
     EX_MEM_RegRd = ID_EX_RegRt then
        Forward <= '1';
    else
        Forward <= '0';
    end if;
end process;

end Behavioral;
