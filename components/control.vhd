library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control is
    Port (signal opcode:                          in std_logic_vector(3 downto 0);
          signal RegDst, Jump, Branch, MemRead:   out std_logic;
          signal MemtoReg, MemWrite:              out std_logic;
          signal ALUSrc, RegWrite:                out std_logic;
          signal ALUOp:                           out std_logic_vector(3 downto 0)
          );
end control;

architecture Behavioral of control is
begin

process(opcode)
variable a, b, c, d:  std_logic := '0';
begin
    a := opcode(3);
    b := opcode(2);
    c := opcode(1);
    d := opcode(0);
    
    ALUOp(3) <=(not a and not b and c and d) or (a and not b and c and d);
    ALUOp(2) <=(a and not d) or (a and not b and c) or (a and b and not c);
    ALUOp(1) <=(a and not b and d) or (a and c and d) or (a and b and not d);
    ALUOp(0) <=(b and not c and not d) or (a and not b and c) or (a and c and d);
    RegDst <= (not a and not b and c) or (not b and c and not d) or
                (a and not b and not c) or (not a and b and not c and not d);
    Jump <= not a and b and c and d;
    Branch <= (a and not b and c and d) or (a and b and not c and not d);
    MemRead <= not a and b and not c and d;
    MemtoReg <= not a and b and not c and d;
    MemWrite <= not a and b and c and not d;
    ALUSrc <= (not a and not c and d) or (b and c and not d) or (a and b and d);
    RegWrite <= (not c and d) or (a and not b and not d) or (not a and b and not c) or
                (a and b and c) or (not a and not b and c);
end process;

end Behavioral;
