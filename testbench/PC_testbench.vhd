library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC_testbench is
end PC_testbench;

architecture Behavioral of PC_testbench is
constant TIME_DELAY : time := 20 ns;
constant NUM_VALS : integer := 8;

signal clk_sig: std_logic := '0';
signal PCin_sig:    std_logic_vector(15 downto 0);
signal PCout_sig:   std_logic_vector(15 downto 0);

type sig_array is array(0 to NUM_VALS-1) of std_logic_vector(15 downto 0);

constant PCin_vals: sig_array := (x"0000",x"0004",x"0008",x"000C",x"0010",x"0014",x"0018",x"001C");
constant PCout_vals: sig_array := (x"0000",x"0004",x"0008",x"000C",x"0010",x"0014",x"0018",x"001C");

begin

DUT: entity work.PC(Behavioral)
    port map(clk => clk_sig,
             PCin => PCin_sig,
             PCout => PCout_sig
             );

clock: process(CLK_sig)
      begin
        CLK_sig <= not CLK_sig after TIME_DELAY/2;
end process clock;

stimulus: process
begin
    for i in 0 to NUM_VALS-1 loop
        PCin_sig <= PCin_vals(i);
        PCout_sig <= PCout_vals(i);
        wait for TIME_DELAY;
    end loop;
    wait;
end process stimulus;



end Behavioral;
