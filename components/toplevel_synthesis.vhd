library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity toplevel_synthesis is
    Port (
          SYS_CLK, CPU_RESETN:  in std_logic;    
          LED:                  out std_logic_vector(15 downto 0)
          );
end toplevel_synthesis;

architecture structural of toplevel_synthesis is
signal ALUZero, and_result:             std_logic;
signal pc_sig:                          std_logic_vector(15 downto 0);
signal instruction:                     std_logic_vector(15 downto 0);
signal readD1, readD2:                  std_logic_vector(15 downto 0);
signal ALU_result:                      std_logic_vector(15 downto 0);
signal dm_readD:                        std_logic_vector(15 downto 0);
signal mux_r:                           std_logic_vector(3 downto 0);
signal mux_r1, mux_r2, mux_r3, mux_r4:  std_logic_vector(15 downto 0);
signal sign_ex:                         std_logic_vector(15 downto 0);
signal instAdder, branchAdder:          std_logic_vector(15 downto 0);
signal shift_r1:                        std_logic_vector(11 downto 0);
signal jump_addr, shift_r2:             std_logic_vector(15 downto 0);

signal RegDst, Jump, Branch, MemRead:   std_logic;
signal MemtoReg, MemWrite:              std_logic;
signal ALUSrc, RegWrite:                std_logic;
signal ALUOp:                           std_logic_vector(3 downto 0);   

signal clk,rst  : std_logic := '0';
begin

rst <= not CPU_RESETN;

LED <= instruction;

-- clock divided
clock_devider: entity work.clock_divider(behavior)
	               generic map(DIVISOR => 5000000)
	               port map(mclk => SYS_CLK, sclk => clk);


-- PC
Program_counter: entity work.PC(Behavioral)
                port map(clk => clk,
                         rst => rst,
                         PCin => mux_r4,
                         PCout => pc_sig
                         );
                         
--control
countrolUnit: entity work.control(Behavioral)
              port map(opcode => instruction(15 downto 12),
                       RegDst => RegDst,
                       Jump => Jump,
                       Branch => Branch,
                       MemRead => MemRead,
                       MemtoReg => MemtoReg,
                       MemWrite => MemWrite,
                       ALUSrc => ALUSrc,
                       RegWrite => RegWrite,
                       ALUOp => ALUOp
                       );
                         
-- jump
adder: entity work.adder(Behavioral)
       port map(Din => pc_sig,
                Dout => instAdder
                );
                
instruction_memory: entity work.instruction_memory(Behavioral)
                    port map(
                             ReadAddr => pc_sig,
                             instruction => instruction
                             );

shift_left_2: entity work.shift_left_2(Behavioral)
              generic map(12)
              port map(Din1 => instruction(11 downto 0),
                       Din2 => x"002",
                       Dout => shift_r1
                       );
jump_addr <= instAdder(15 downto 12) & std_logic_vector(unsigned(instAdder(11 downto 0)) + unsigned(shift_r1));                     

-- branch
shift_left_2_2: entity work.shift_left_2(Behavioral)
              port map(Din1 => sign_ex,
                       Din2 => x"0002",
                       Dout => shift_r2
                       );

branch_add: entity work.add_16bits(Behavioral)
            port map(C_in => '0',
                     Din1 => instAdder,
                     Din2 => shift_r2,
                     Dout => branchAdder
                     );

and_result <= Branch and ALUZero;

mux3: entity work.mux_2to1_nbits(Behavioral)
      port map(sel => and_result,
               Din1 => instAdder,
               Din2 => branchAdder,
               Dout => mux_r3
               );

-- registers
mux4: entity work.mux_2to1_nbits(Behavioral)
      port map(sel => Jump,
               Din1 => mux_r3,
               Din2 => jump_addr,
               Dout => mux_r4
               );

mux: entity work.mux_2to1_nbits(Behavioral)
      generic map(4)
      port map(sel => RegDst,
               Din1 => instruction(7 downto 4),
               Din2 => instruction(3 downto 0),
               Dout => mux_r
               );
               
Registers: entity work.registers(Behavioral)
           port map(clk => clk,
                    RegWrite => RegWrite,
                    r1 => instruction(11 downto 8),
                    r2 => instruction(7 downto 4),
                    wr => mux_r,
                    wd => mux_r2,
                    rd1 => readD1,
                    rd2 => readD2
                    );

Sign_extend: entity work.signExtend(Behavioral)
             port map(din => instruction(3 downto 0),
                      dout => sign_ex
                      );
                      
-- ALU
mux1: entity work.mux_2to1_nbits(Behavioral)
      generic map(16)
      port map(sel => ALUSrc,
               Din1 => readD2,
               Din2 => sign_ex,
               Dout => mux_r1
               );

ALU: entity work.ALU_16bits(Behavioral)
     port map(Din1 => readD1,
              Din2 => mux_r1,
              control => ALUOp,
              zero => ALUZero,
              result => ALU_result
              );

--data memory
Data_memory: entity work.dataMemory(Behavioral)
             port map(clk => clk,
                      memWrite => MemWrite,
                      memRead => MemRead,
                      Addr => ALU_result,
                      writeData => readD2,
                      readData => dm_readD
                      );
mux2: entity work.mux_2to1_nbits(Behavioral)
      port map(sel => MemtoReg,
               Din1 => ALU_result,
               Din2 => dm_readD,
               Dout => mux_r2
               );


end structural;
