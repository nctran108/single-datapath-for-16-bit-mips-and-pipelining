library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ID_EX is
    Port (clk, rst:      in std_logic;
          RegDst:   in std_logic;
          Jump:     in std_logic;
          Branch:   in std_logic;
          MemRead:  in std_logic;
          MemtoReg: in std_logic;
          MemWrite: in std_logic;
          ALUSrc:   in std_logic;
          RegWrite: in std_logic;
          ALUOp:    in std_logic_vector(3 downto 0);
          ID_instructionAdd:    in std_logic_vector(15 downto 0);
          ID_readData1:         in std_logic_vector(15 downto 0);
          ID_readData2:         in std_logic_vector(15 downto 0);
          ID_signExtend:        in std_logic_vector(15 downto 0);
          ID_rs:        in std_logic_vector(3 downto 0);
          ID_rt:        in std_logic_vector(3 downto 0);
          ID_rd:        in std_logic_vector(3 downto 0);
          EX_RegDst:   out std_logic;
          EX_Jump:     out std_logic;
          EX_Branch:   out std_logic;
          EX_MemRead:  out std_logic;
          EX_MemtoReg: out std_logic;
          EX_MemWrite: out std_logic;
          EX_ALUSrc:   out std_logic;
          EX_RegWrite: out std_logic;
          EX_ALUOp:    out std_logic_vector(3 downto 0);
          EX_readData1:         out std_logic_vector(15 downto 0);
          EX_readData2:         out std_logic_vector(15 downto 0);
          EX_signExtend:        out std_logic_vector(15 downto 0);
          EX_rs:        out std_logic_vector(3 downto 0);
          EX_rt:        out std_logic_vector(3 downto 0);
          EX_rd:        out std_logic_vector(3 downto 0)
          );
end ID_EX;

architecture Behavioral of ID_EX is

begin
process(clk,rst)
begin
    if rst = '1' then
        EX_RegDst <= '0';
        EX_Jump <= '0';
        EX_Branch <= '0';
        EX_MemRead <= '0';
        EX_MemtoReg <= '0';
        EX_MemWrite <= '0';
        EX_ALUSrc <= '0';
        EX_RegWrite <= '0';
        EX_ALUOp <= "0000";
        EX_readData1 <= x"0000";
        EX_readData2 <= x"0000";
        EX_signExtend <= x"0000";
        EX_rs <= "0000";
        EX_rt <= "0000";
        EX_rd <= "0000";
    else
        if falling_edge(clk) then
            EX_RegDst <= RegDst;
            EX_Jump <= Jump;
            EX_Branch <= Branch;
            EX_MemRead <= MemRead;
            EX_MemtoReg <= MemtoReg;
            EX_MemWrite <= MemWrite;
            EX_ALUSrc <= ALUSrc;
            EX_RegWrite <=RegWrite;
            EX_ALUOp <= ALUOp;
            EX_readData1 <= ID_readData1;
            EX_readData2 <= ID_readData2;
            EX_signExtend <= ID_signExtend;
            EX_rs <= ID_rs;
            EX_rt <= ID_rt;
            EX_rd <= ID_rd;
        end if;
    end if;
end process;
end Behavioral;
