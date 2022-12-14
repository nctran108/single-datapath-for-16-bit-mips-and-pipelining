library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity forwardingUnit is
    Port (EX_MEM_RegWrite: in       std_logic;
          EX_MEM_ALUSrc:  in       std_logic;
          EX_MEM_RegRd:    in       std_logic_vector(3 downto 0);
          ID_EX_ALUSrc:    in       std_logic;
          ID_EX_RegRs:     in       std_logic_vector(3 downto 0);
          ID_EX_RegRt:     in       std_logic_vector(3 downto 0);
          MEM_WB_RegWrite: in       std_logic;
          MEM_WB_ALUSrc:   in       std_logic;
          MEM_WB_RegRd:    in       std_logic_vector(3 downto 0);
          ForwardA:        out      std_logic_vector(1 downto 0);
          ForwardB:        out      std_logic_vector(1 downto 0)
          );
end forwardingUnit;

architecture Behavioral of forwardingUnit is
signal a,b: std_logic_vector(1 downto 0) := "00";

begin
process(EX_MEM_RegWrite,EX_MEM_ALUSrc,EX_MEM_RegRd,MEM_WB_RegRd,MEM_WB_ALUSrc,MEM_WB_RegWrite,ID_EX_RegRs,ID_EX_RegRt)
begin
    if (EX_MEM_RegWrite = '1') and
         (EX_MEM_RegRd /= "0000") and
           (EX_MEM_RegRd = ID_EX_RegRs) then
        ForwardA <= "10";
    elsif (MEM_WB_RegWrite = '1') and
            (MEM_WB_RegRd /= "0000") and
             (MEM_WB_RegRd = ID_EX_RegRs) then
        ForwardA <= "01";
    else
        ForwardA <= "00";
    end if;
    
    if (EX_MEM_RegWrite = '1') and
         (EX_MEM_RegRd /= "0000") and
          (EX_MEM_RegRd = ID_EX_RegRt) then
        if ID_EX_ALUSrc = '1' then
            ForwardB <= "00";
        else
            ForwardB <= "10";
        end if;
    elsif (MEM_WB_RegWrite = '1') and
            (MEM_WB_RegRd /= "0000") and
              (MEM_WB_RegRd = ID_EX_RegRt) then
        if ID_EX_ALUSrc = '1' then
            ForwardB <= "00";
        else
            ForwardB <= "01";
        end if;
    else
        ForwardB <= "00";
    end if;
end process;

end Behavioral;
