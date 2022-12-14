library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MEM_WB is
    Port (clk, rst: in std_logic;
          ALUSrc:   in std_logic;
          MemtoReg: in std_logic;
          RegWrite: in std_logic;
          dm_ReadData:  in std_logic_vector(15 downto 0);
          ALUResult:    in std_logic_vector(15 downto 0);
          writeReg:     in std_logic_vector;
          WB_ALUSrc:    out std_logic;
          WB_MemtoReg: out std_logic;
          WB_RegWrite: out std_logic;
          WB_dm_ReadData:  out std_logic_vector(15 downto 0);
          WB_ALUResult:    out std_logic_vector(15 downto 0);
          WB_writeReg:     out std_logic_vector(3 downto 0)
          );
end MEM_WB;

architecture Behavioral of MEM_WB is

begin
process(clk, rst)
begin
    if rst = '1' then
        WB_ALUSrc <= '0';
        WB_MemtoReg <= '0';
        WB_RegWrite <= '0';
        WB_dm_ReadData <= x"0000";
        WB_ALUResult <= x"0000";
        WB_writeReg <= "0000";
    else
        if falling_edge(clk) then
            WB_ALUSrc <= ALUSrc;
            WB_MemtoReg <= MemtoReg;
            WB_RegWrite <= RegWrite;
            WB_dm_ReadData <= dm_ReadData;
            WB_ALUResult <= ALUResult;
            WB_writeReg <= writeReg;
        end if;
    end if;
end process;
end Behavioral;
