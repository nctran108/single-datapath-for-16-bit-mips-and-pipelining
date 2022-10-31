library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instruction_memory_testbench is
end instruction_memory_testbench;

architecture Behavioral of instruction_memory_testbench is
constant TIME_DELAY : time := 20 ns;
constant NUM_VALS : integer := 8;

signal clk_sig: std_logic := '0';
signal ReadAddr_sig:    std_logic_vector(15 downto 0);
signal instruction_sig: std_logic_vector(15 downto 0);

type sig_array is array(0 to NUM_VALS-1) of std_logic_vector(15 downto 0);

constant ReadAddr_vals: sig_array := (x"0000",x"0004",x"0008",x"000C",x"0010",x"0014",x"0018",x"001C");
constant instruction_vals: sig_array := ("0001000000100011","1110001000100100","0001000000110001","1110001100110100","1110001100110100","0001001100110001","1110001100110100","0001010000000111");

begin

DUT: entity work.instruction_memory(Behavioral)
    port map(ReadAddr => ReadAddr_sig,
             instruction => instruction_sig
             );

clock: process(CLK_sig)
      begin
        CLK_sig <= not CLK_sig after TIME_DELAY/2;
end process clock;

stimulus: process
begin
    for i in 0 to NUM_VALS-1 loop
        ReadAddr_sig <= ReadAddr_vals(i);
        instruction_sig <= instruction_vals(i);
        wait for TIME_DELAY;
    end loop;
    wait;
end process stimulus;             

end Behavioral;
