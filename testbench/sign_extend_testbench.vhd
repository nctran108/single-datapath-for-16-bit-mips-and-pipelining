library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sign_extend_testbench is
end sign_extend_testbench;

architecture Behavioral of sign_extend_testbench is
constant TIME_DELAY : time := 20 ns;
constant NUM_VALS : integer := 8;

signal clk_sig: std_logic := '0';
signal Din_sig:    std_logic_vector(3 downto 0);
signal Dout_sig: std_logic_vector(15 downto 0);

type sig_array is array(0 to NUM_VALS-1) of std_logic_vector(15 downto 0);
type Din_array is array(0 to NUM_VALS-1) of std_logic_vector(3 downto 0);

constant Din_vals: Din_array := (x"0",x"4",x"8",x"C",x"A",x"7",x"F",x"D");
constant Dout_vals: sig_array := (x"0000",x"0004",x"FFF8",x"FFFC",x"FFFA",x"0007",x"FFFF",x"FFFD");

begin
DUT: entity work.signExtend(Behavioral)
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
