library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instruction_adder_testbench is
end Instruction_adder_testbench;

architecture Behavioral of Instruction_adder_testbench is
constant TIME_DELAY : time := 20 ns;
constant NUM_VALS : integer := 8;

signal clk_sig: std_logic := '0';
signal Din_sig:    std_logic_vector(15 downto 0);
signal Dout_sig: std_logic_vector(15 downto 0);

type sig_array is array(0 to NUM_VALS-1) of std_logic_vector(15 downto 0);

constant Din_vals: sig_array := (x"0000",x"0004",x"0008",x"000C",x"0010",x"0014",x"0018",x"001C");
constant Dout_vals: sig_array := (x"0004",x"0008",x"000C",x"0010",x"0014",x"0018",x"001C",x"0020");

begin

DUT: entity work.adder(Behavioral)
    port map(Din => Din_sig,
             Dout => Dout_sig);

clock: process(CLK_sig)
      begin
        CLK_sig <= not CLK_sig after TIME_DELAY/2;
end process clock;

stimulus: process
begin
    for i in 0 to NUM_VALS-1 loop
        Din_sig <= Din_vals(i);
        Dout_sig <= Dout_vals(i);
        wait for TIME_DELAY;
    end loop;
    wait;
end process stimulus;        

end Behavioral;
