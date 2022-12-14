library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity toplevel_pipeline is
    Port (clk, rst:  in std_logic    
          );
end toplevel_pipeline;

architecture structural of toplevel_pipeline is
signal ALUZero, PCSrc, PCSrc1:                  std_logic;
signal pc_sig:                          std_logic_vector(15 downto 0);
signal IFEX_instruction, instruction:   std_logic_vector(15 downto 0);
signal Instr_mem:                       std_logic_vector(15 downto 0);
signal readD1, readD2:                  std_logic_vector(15 downto 0);
signal ALU_result:                      std_logic_vector(15 downto 0);
signal dm_readD:                        std_logic_vector(15 downto 0);
signal PC_branch:                       std_logic_vector(15 downto 0);
signal PCin, writeData, ALUDin2:        std_logic_vector(15 downto 0);
signal sign_ex:                         std_logic_vector(15 downto 0);
signal IF_instAdder, instAdder, branchAdder:  std_logic_vector(15 downto 0);
signal shift_r1:                        std_logic_vector(11 downto 0);
signal jump_addr, shift_r2:             std_logic_vector(15 downto 0);

signal RegDst, Jump, Branch, MemRead:   std_logic;
signal MemtoReg, MemWrite:              std_logic;
signal ALUSrc, RegWrite:                std_logic;
signal ALUOp, regDin:                   std_logic_vector(3 downto 0);   

signal EX_RegDst:   std_logic;
signal EX_Jump:     std_logic;
signal EX_Branch:   std_logic;
signal EX_MemRead:  std_logic;
signal EX_MemtoReg: std_logic;
signal EX_MemWrite: std_logic;
signal EX_ALUSrc:   std_logic;
signal EX_RegWrite: std_logic;
signal EX_ALUOp:    std_logic_vector(3 downto 0);
signal EX_instructionAdd:    std_logic_vector(15 downto 0);
signal EX_readData1:         std_logic_vector(15 downto 0);
signal EX_readData2:         std_logic_vector(15 downto 0);
signal EX_signExtend:        std_logic_vector(15 downto 0);
signal EX_jumpAddr:        std_logic_vector(15 downto 0);
signal EX_rs:        std_logic_vector(3 downto 0);
signal EX_rt:        std_logic_vector(3 downto 0);
signal EX_rd:        std_logic_vector(3 downto 0);


signal MEM_Jump:      std_logic;
signal MEM_Branch:    std_logic;
signal MEM_MemRead:   std_logic;
signal MEM_MemtoReg:  std_logic;
signal MEM_MemWrite:  std_logic;
signal MEM_ALUSrc:    std_logic;
signal MEM_RegWrite:  std_logic;
signal MEM_branchAdd:     std_logic_vector(15 downto 0);
signal MEM_jumpAddr:    std_logic_vector(15 downto 0);
signal MEM_ALUZero:       std_logic;
signal MEM_ALUResult:     std_logic_vector(15 downto 0);
signal MEM_readData2:  std_logic_vector(15 downto 0);
signal MEM_writeReg:   std_logic_vector(3 downto 0);

signal WB_ALUSrc:    std_logic;
signal WB_MemtoReg:  std_logic;
signal WB_RegWrite:  std_logic;
signal WB_dm_ReadData:   std_logic_vector(15 downto 0);
signal WB_ALUResult:     std_logic_vector(15 downto 0);
signal WB_writeReg:      std_logic_vector(3 downto 0);

signal ForwardA:    std_logic_vector(1 downto 0);
signal ForwardB:    std_logic_vector(1 downto 0);
signal ALUforwardA: std_logic_vector(15 downto 0);
signal ALUforwardB: std_logic_vector(15 downto 0);

signal IFIDWrite:   std_logic;
signal PCWrite:     std_logic;
signal ID_Control:  std_logic;
signal HazardRegDst, HazardJump, HazardBranch, HazardMemRead:   std_logic;
signal HazardMemtoReg, HazardMemWrite:              std_logic;
signal HazardALUSrc, HazardRegWrite:                std_logic;
signal HazardALUOp, HazardregDin:                   std_logic_vector(3 downto 0); 
signal compareRegRead :     std_logic;
signal IF_Flush:    std_logic;

signal Forward : std_logic;
signal read_Forward:    std_logic_vector(15 downto 0);

begin
--state 1: Instruction Fetch---------------------------------------------------------------------------------
branch_mux: entity work.mux_2to1_nbits(Behavioral)
                    port map(sel => PCSrc,
                             Din1 => IF_instAdder,
                             Din2 => branchAdder,
                             Dout => PC_branch
                    );
Jump_mux:   entity work.mux_2to1_nbits(Behavioral)
                    port map(sel => HazardJump,
                             Din1 => PC_branch,
                             Din2 => jump_addr,
                             Dout => PCin
                             );
                    
Program_counter: entity work.PC(Behavioral)
                port map(clk => clk,
                         rst => rst,
                         PCWrite => PCWrite,
                         PCin => PCin,
                         PCout => pc_sig
                         );
                    
adder: entity work.adder(Behavioral)
       port map(Din => pc_sig,
                Dout => IF_instAdder
                );
                  
                
instruction_memory: entity work.instructionMemory_pipeline(Behavioral)
                    port map(
                             ReadAddr => pc_sig,
                             instruction => Instr_mem
                             );
inst_mux_when_jump: entity work.mux_2to1_nbits(Behavioral)
         port map(sel => IF_Flush,
                  Din1 => Instr_mem,
                  Din2 => x"0000",
                  Dout => IFEX_instruction
                  );
-- IF/ID buffer -----------------------------------------------------------------------------------------------                         
IFID: entity work.IF_ID(Behavioral)
              port map(clk => clk,
                       rst => rst,
                       IFID_Write => IFIDWrite,
                       IF_InstructionAdd => IF_instAdder,
                       IF_Instruction => IFEX_instruction,
                       ID_instruction => instruction,
                       ID_instructionAdd => instAdder
                       );
                       
--state 2: Decode--------------------------------------------------------------------------------------------------                       
shift_left_2: entity work.shift_left_2(Behavioral)
              generic map(12)
              port map(Din1 => instruction(11 downto 0),
                       Din2 => x"002",
                       Dout => shift_r1
                       );
                       
jump_addr <= instAdder(15 downto 12) & std_logic_vector(unsigned(instAdder(11 downto 0)) + unsigned(shift_r1)); 

compare: entity work.compareWclock(Behavioral)
        port map(clk => clk,
                 a => readD1,
                 b => read_Forward,
                 result => compareRegRead
                 );
                 
PCSrc <= Branch and compareRegRead;
PCSrc1 <= HazardBranch and compareRegRead;
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

mux_control: entity work.mux(Behavioral)
            port map(sel => ID_Control,
                     RegDst => RegDst,
                     Jump => Jump,
                     Branch => Branch,
                     MemRead => MemRead,
                     MemtoReg => MemtoReg,
                     MemWrite => MemWrite,
                     ALUSrc => ALUSrc,
                     RegWrite => RegWrite,
                     ALUOp => ALUOp,
                     Dout1 => HazardRegDst,
                     Dout2 => HazardJump,
                     Dout3 => HazardBranch,
                     Dout4 => HazardMemRead,
                     Dout5 => HazardMemtoReg,
                     Dout6 => HazardMemWrite,
                     Dout7 => HazardALUSrc,
                     Dout8 => HazardRegWrite,
                     Dout9 => HazardALUOp
                     );

Registers: entity work.registers(Behavioral)
           port map(clk => clk,
                    RegWrite => WB_RegWrite,
                    r1 => instruction(11 downto 8),
                    r2 => instruction(7 downto 4),
                    wr => WB_writeReg,
                    wd => writeData,
                    rd1 => readD1,
                    rd2 => readD2
                    );

control_hazard_mux: entity work.mux_2to1_nbits(Behavioral)
            port map(sel => Forward,
                     Din1 => readD2,
                     Din2 => MEM_ALUResult,
                     Dout => read_Forward
                  );

Sign_extend: entity work.signExtend(Behavioral)
             port map(din => instruction(3 downto 0),
                      dout => sign_ex
                      );

hazard_detection_control: entity work.HazardDetectUnit(Behavioral)
            port map(
                     IFID_rs => instruction(11 downto 8),
                     IFID_rt => instruction(7 downto 4),
                     IFID_rd => instruction(3 downto 0),
                     IDEX_rt => EX_rt,
                     PCSrc => PCSrc1,
                     IDEX_Jump => HazardJump,
                     IDEX_MemRead => EX_MemtoReg,
                     IFID_Write => IFIDWrite,
                     EX_MEM_RegRd => MEM_writeReg,
                     PCWrite => PCWrite,
                     ID_Control => ID_Control,
                     IF_Flush => IF_Flush
                     );
control_hazard_forward: entity work.control_forward(Behavioral)
            port map(EX_MEM_RegWrite => MEM_RegWrite,
                     EX_MEM_ALUResult => MEM_ALUResult,
                     EX_MEM_RegRd => MEM_writeReg,
                     ID_EX_RegRs => instruction(11 downto 8),
                     ID_EX_RegRt => instruction(7 downto 4),
                     Forward => Forward
                     );

-- ID/EX buffer ------------------------------------------------------------------------------------------------------
IDEX: entity work.ID_EX(Behavioral)
                port map(clk => clk,
                         rst => rst,
                         RegDst => HazardRegDst,
                         Jump => HazardJump,
                         Branch => HazardBranch,
                         MemRead => HazardMemRead,
                         MemtoReg => HazardMemtoReg,
                         MemWrite => HazardMemWrite,
                         ALUSrc => HazardALUSrc,
                         RegWrite => HazardRegWrite,
                         ALUOp => HazardALUOp,
                         ID_instructionAdd => instAdder,
                         ID_readData1 => readD1,
                         ID_readData2 => readD2,
                         ID_signExtend => sign_ex,
                         ID_rs => instruction(11 downto 8),
                         ID_rt => instruction(7 downto 4),
                         ID_rd => instruction(3 downto 0),
                         EX_RegDst => EX_RegDst,
                         EX_Jump => EX_Jump,
                         EX_Branch => EX_Branch,
                         EX_MemRead => EX_MemRead,
                         EX_MemtoReg => EX_MemtoReg,
                         EX_MemWrite => EX_MemWrite,
                         EX_ALUSrc => EX_ALUSrc,
                         EX_RegWrite => EX_RegWrite,
                         EX_ALUOp => EX_ALUOp,
                         EX_readData1 => EX_readData1,
                         EX_readData2 => EX_readData2,
                         EX_signExtend => EX_signExtend,
                         EX_rs => EX_rs,
                         EX_rt => EX_rt,
                         EX_rd => EX_rd
                         );

--state 3: Instruction Execution------------------------------------------------------------------------------------------------
                

ALUMux: entity work.mux_2to1_nbits(Behavioral)
      port map(sel => EX_ALUSrc,
               Din1 => EX_readData2,
               Din2 => EX_signExtend,
               Dout => ALUDin2
               );

forwardMuxA: entity work.mux3to1_nbits(Behavioral)
        port map(sel => ForwardA,
                 Din1 => EX_readData1,
                 Din2 => writeData,
                 Din3 => MEM_ALUResult,
                 Dout => ALUforwardA
                 );

forwardMuxB: entity work.mux3to1_nbits(Behavioral)
        port map(sel => ForwardB,
                 Din1 => ALUDin2,
                 Din2 => writeData,
                 Din3 => MEM_ALUResult,
                 Dout => ALUforwardB
                 );

ALU: entity work.ALU_16bits(Behavioral)
     port map(Din1 => ALUforwardA,
              Din2 => ALUforwardB,
              control => EX_ALUOp,
              zero => ALUZero,
              result => ALU_result
              );  
              
registerMux: entity work.mux_2to1_nbits(Behavioral)
      generic map(4)
      port map(sel => EX_RegDst,
               Din1 => EX_rt,
               Din2 => EX_rd,
               Dout => regDin
               );

Forwarding_unit: entity work.forwardingUnit(Behavioral)
       port map(
                EX_MEM_RegWrite => MEM_RegWrite,
                EX_MEM_ALUSrc => MEM_ALUSrc,
                EX_MEM_RegRd => MEM_writeReg,   
                ID_EX_ALUSrc => EX_ALUSrc,            
                ID_EX_RegRs => EX_rs,
                ID_EX_RegRt => EX_rt,
                MEM_WB_RegWrite => WB_RegWrite,
                MEM_WB_ALUSrc => WB_ALUSrc,
                MEM_WB_RegRd => WB_writeReg,
                ForwardA => ForwardA,
                ForwardB => ForwardB
                );

-- EX/MEM buffer -------------------------------------------------------------------------------------------------
EXMEM: entity work.EX_MEM(Behavioral)
            port map(clk => clk,
                     rst => rst,
                     MemRead => EX_MemRead,
                     MemtoReg => EX_MemtoReg,
                     MemWrite => EX_MemWrite,
                     ALUSrc => EX_ALUSrc,
                     RegWrite => EX_RegWrite,
                     ALUZero => ALUZero,
                     ALUResult => ALU_result,
                     EX_readData2 => EX_readData2,
                     EX_writeReg => regDin,
                     MEM_MemRead => MEM_MemRead,
                     MEM_MemtoReg => MEM_MemtoReg,
                     MEM_MemWrite => MEM_MemWrite,
                     MEM_ALUSrc => MEM_ALUSrc,
                     MEM_RegWrite => MEM_RegWrite,
                     MEM_ALUZero => MEM_ALUZero,
                     MEM_ALUResult => MEM_ALUResult,
                     MEM_readData2 => MEM_readData2,
                     MEM_writeReg => MEM_writeReg
                     );             
--state 4: Memory --------------------------------------------------------------------------------------------------
--PCSrc <= MEM_Branch and MEM_ALUZero;

--data memory
Data_memory: entity work.dataMemory(Behavioral)
             port map(clk => clk,
                      memWrite => MEM_MemWrite,
                      memRead => MEM_MemRead,
                      Addr => MEM_ALUResult,
                      writeData => MEM_readData2,
                      readData => dm_readD
                      );
                      

-- MEM/WB buffer----------------------------------------------------------------------------------------------------
MEMWB: entity work.MEM_WB(Behavioral)
                port map(clk => clk, 
                         rst => rst,
                         ALUSrc => MEM_ALUSrc,
                         MemtoReg => MEM_MemtoReg,
                         RegWrite => MEM_RegWrite,
                         dm_ReadData => dm_readD,
                         ALUResult => MEM_ALUResult,
                         writeReg => MEM_writeReg,
                         WB_ALUSrc => WB_ALUSrc,
                         WB_MemtoReg => WB_MemtoReg,
                         WB_RegWrite => WB_RegWrite,
                         WB_dm_ReadData => WB_dm_ReadData,
                         WB_ALUResult => WB_ALUResult,
                         WB_writeReg => WB_writeReg
                         );
--state 5: WriteBack -----------------------------------------------------------------------------------------------                      
writebackmux: entity work.mux_2to1_nbits(Behavioral)
      port map(sel => WB_MemtoReg,
               Din1 => WB_ALUResult,
               Din2 => WB_dm_ReadData,
               Dout => writeData
               );
               
end structural;
