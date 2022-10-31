library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_testbench is
end ALU_testbench;

architecture Behavioral of ALU_testbench is
constant TIME_DELAY : time := 20 ns;
constant NUM_VALS : integer := 8;

signal clk_sig:      std_logic := '0';
signal Din1_sig:     std_logic_vector(15 downto 0);
signal Din2_sig:     std_logic_vector(15 downto 0);
signal control_sig:  std_logic_vector(3 downto 0);
signal zero_sig:     std_logic;
signal result_sig:   std_logic_vector(15 downto 0);

type Din1_array is array(0 to NUM_VALS-1) of std_logic_vector(15 downto 0);
type Din2_array is array(0 to NUM_VALS-1) of std_logic_vector(15 downto 0);
type control_array is array(0 to NUM_VALS-1) of std_logic_vector(3 downto 0);
type zero_array is array(0 to NUM_VALS-1) of std_logic;
type result_array is array(0 to NUM_VALS-1) of std_logic_vector(15 downto 0);

constant Din1_vals : Din1_array := (x"0020",x"0020",x"0020",x"0020",x"0020",x"0020",x"0020",x"0020");
constant Din2_vals : Din2_array := (x"0004",x"0004",x"0004",x"0004",x"0004",x"0004",x"0004",x"0004");
constant control_vals : control_array := (x"0",x"1",x"2",x"3",x"4",x"5",x"6",x"7");
constant zero_vals : zero_array := ('0','0','0','0','0','1','0','1');
constant result_vals : Din2_array := (x"0024",x"0024",x"0024",x"0080",x"0008",x"0000",x"0200",x"0000");

begin

DUT: entity work.ALU_16bits(Behavioral)
    port map(Din1 => Din1_sig,
             Din2 => Din2_sig,
             control => control_sig,
             zero => zero_sig,
             result => result_sig
             );

clock: process(CLK_sig)
      begin
        CLK_sig <= not CLK_sig after TIME_DELAY/2;
end process clock;

stimulus: process
begin
    for i in 0 to NUM_VALS-1 loop
        Din1_sig <= Din1_vals(i);
        Din2_sig <= Din2_vals(i);
        control_sig <= control_vals(i);
        zero_sig <= zero_vals(i);
        result_sig <= result_vals(i);
        wait for 2 * TIME_DELAY;
    end loop;
    wait;
end process stimulus;

end Behavioral;
