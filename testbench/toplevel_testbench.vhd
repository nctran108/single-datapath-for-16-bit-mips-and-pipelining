library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity toplevel_testbench is
end toplevel_testbench;

architecture Behavioral of toplevel_testbench is
constant TIME_DELAY : time := 20 ns;
constant NUM_VALS : integer := 10;

signal clk_sig, rst_sig:                                std_logic := '0';
signal RegDst_sig, Jump_sig, Branch_sig, MemRead_sig:   std_logic;
signal MemtoReg_sig, MemWrite_sig:                      std_logic;
signal ALUSrc_sig, RegWrite_sig:                        std_logic;
signal ALUOp_sig:                                       std_logic_vector(3 downto 0);  

type RegDst_array is array(0 to NUM_VALS-1) of std_logic;
type Jump_array is array(0 to NUM_VALS-1) of std_logic; 
type Branch_array is array(0 to NUM_VALS-1) of std_logic; 
type MemRad_array is array(0 to NUM_VALS-1) of std_logic; 
type MemtoReg_array is array(0 to NUM_VALS-1) of std_logic; 
type MemWrite_array is array(0 to NUM_VALS-1) of std_logic; 
type ALUSrc_array is array(0 to NUM_VALS-1) of std_logic; 
type RegWrite_array is array(0 to NUM_VALS-1) of std_logic; 
type ALUOp_array is array(0 to NUM_VALS-1) of std_logic_vector(3 downto 0); 

constant RegDst_val : RegDst_array := ('0','0','0','0','0','0','0','0','0','0');
constant Jump_val : Jump_array := ('0','0','0','0','0','0','0','0','0','0');
constant Branch_val : Branch_array := ('0','0','0','0','0','0','0','0','0','0');
constant MemRead_val : MemRad_array := ('0','0','0','0','0','0','0','0','0','0');
constant MemtoReg_val : MemtoReg_array := ('0','0','0','0','0','0','0','0','0','0');
constant MemWrite_val : MemWrite_array := ('0','0','0','0','0','0','0','0','0','0');
constant ALUSrc_val : ALUSrc_array := ('1','1','1','1','1','1','1','1','1','1');
constant RegWrite_val : RegWrite_array := ('0','0','0','0','0','0','0','0','0','0');
constant ALUOp_val : ALUOp_array := (x"0",x"6",x"0",x"6",x"0",x"6",x"0",x"6",x"0",x"6");
 

begin

DUT: entity work.toplevel(simple)
    port map(clk => clk_sig,
             rst => rst_sig,
             RegDst => RegDst_sig,
             Jump => Jump_sig,
             Branch => Branch_sig,
             MemRead => MemRead_sig,
             MemtoReg => MemtoReg_sig,
             MemWrite => MemWrite_sig,
             ALUSrc => ALUSrc_sig,
             RegWrite => RegWrite_sig,
             ALUOp => ALUOp_sig
             );

rst_sig <= '1', '0' after 5 ns;

clock: process
begin
    for i in 0 to 2 * (NUM_VALS-1) loop
        clk_sig <= not clk_sig;
        wait for TIME_DELAY/2;
    end loop;
    wait;
end process clock;

stimulus: process
begin
    for i in 0 to NUM_VALS-1 loop
        RegDst_sig <= RegDst_val(i);
        Jump_sig <= Jump_val(i);
        Branch_sig <= Branch_val(i);
        MemRead_sig <= MemRead_val(i);
        MemtoReg_sig <= MemtoReg_val(i);
        MemWrite_sig <= MemWrite_val(i);
        ALUSrc_sig <= ALUSrc_val(i);
        RegWrite_sig <= RegWrite_val(i);
        ALUOp_sig <= ALUOp_val(i);
        wait for 2 * TIME_DELAY;
    end loop;
    wait;
end process stimulus;

end Behavioral;
