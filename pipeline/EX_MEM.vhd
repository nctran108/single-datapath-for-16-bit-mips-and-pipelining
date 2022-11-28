library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EX_MEM is
    Port (clk, rst:      in std_logic;
          Jump:     in std_logic;
          Branch:   in std_logic;
          MemRead:  in std_logic;
          MemtoReg: in std_logic;
          MemWrite: in std_logic;
          RegWrite: in std_logic;
          branchAdd:    in std_logic_vector(15 downto 0);
          jumpAddr:     in std_logic_vector(15 downto 0);
          ALUZero:      in std_logic;
          ALUResult:    in std_logic_vector(15 downto 0);
          EX_readData2: in std_logic_vector(15 downto 0);
          EX_writeReg:  in std_logic_vector(3 downto 0);
          MEM_Jump:     out std_logic;
          MEM_Branch:   out std_logic;
          MEM_MemRead:  out std_logic;
          MEM_MemtoReg: out std_logic;
          MEM_MemWrite: out std_logic;
          MEM_RegWrite: out std_logic;
          MEM_branchAdd:    out std_logic_vector(15 downto 0);
          MEM_jumpAddr:     out std_logic_vector(15 downto 0);
          MEM_ALUZero:      out std_logic;
          MEM_ALUResult:    out std_logic_vector(15 downto 0);
          MEM_readData2: out std_logic_vector(15 downto 0);
          MEM_writeReg:  out std_logic_vector(3 downto 0)
          );
end EX_MEM;

architecture Behavioral of EX_MEM is

begin
process(clk, rst)
begin
    if rst = '1' then
        MEM_Jump <= '0';
        MEM_Branch <= '0';
        MEM_MemRead <= '0';
        MEM_MemtoReg <= '0';
        MEM_MemWrite <= '0';
        MEM_RegWrite <= '0';
        MEM_branchAdd <= x"0000";
        MEM_jumpAddr <= x"0000";
        MEM_ALUZero <= '0';
        MEM_ALUResult <= x"0000";
        MEM_readData2 <= x"0000";
        MEM_writeReg <= "0000";
    else
        if falling_edge(clk) then
            MEM_Jump <= Jump;
            MEM_Branch <= Branch;
            MEM_MemRead <= MemRead;
            MEM_MemtoReg <= MemtoReg;
            MEM_MemWrite <= MemWrite;
            MEM_RegWrite <= RegWrite;
            MEM_branchAdd <= branchAdd;
            MEM_jumpAddr <= jumpAddr;
            MEM_ALUZero <= ALUZero;
            MEM_ALUResult <= ALUResult;
            MEM_readData2 <= EX_readData2;
            MEM_writeReg <= EX_writeReg;
        end if;
    end if;
end process;
end Behavioral;
