library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HazardDetectUnit is
    Port (IFID_rs:      in std_logic_vector(3 downto 0);
          IFID_rt:      in std_logic_vector(3 downto 0);
          IFID_rd:      in std_logic_vector(3 downto 0);
          IDEX_rt:      in std_logic_vector(3 downto 0);
          PCSrc:        in std_logic;
          IDEX_Jump:    in std_logic;
          IDEX_MemRead: in std_logic;
          EX_MEM_RegRd: in std_logic_vector(3 downto 0);
          IFID_Write:   out std_logic;
          PCWrite:      out std_logic;
          ID_Control:   out std_logic;
          IF_Flush :    out std_logic
          );
end HazardDetectUnit;

architecture Behavioral of HazardDetectUnit is
signal write, control, PCControl: std_logic := '0';
begin

process(IFID_rs,IFID_rt,IFID_rd,IDEX_rt,PCSrc,IDEX_Jump,IDEX_MemRead)
begin 
    if (IDEX_MemRead = '1') and ((IDEX_rt = IFID_rs) or (IDEX_rt = IFID_rt)) then
        write <= '1';
        control <= '1';
        PCControl <= '1';
        IF_Flush <= '0';
    elsif PCSrc = '1' and IDEX_rt = EX_MEM_RegRd then
        write <= '1';
        control <= '1';
        PCControl <= '1';
        IF_Flush <= '0';
    elsif IDEX_Jump = '1' or PCSrc = '1' then
        write <= '0';
        control <= '0';
        PCControl <= '0';
        IF_Flush <= '1';
    else
        write <= '0';
        control <= '0';
        PCControl <= '0';
        IF_Flush <= '0';
    end if;
        
end process;

IFID_Write <= write;
PCWrite <= PCControl;
ID_Control <= control;

end Behavioral;
