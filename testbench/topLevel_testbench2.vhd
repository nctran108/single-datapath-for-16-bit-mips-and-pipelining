library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity topLevel_testbench2 is
end topLevel_testbench2;

architecture Behavioral of topLevel_testbench2 is
constant TIME_DELAY : time := 20 ns;
constant NUM_VALS : integer := 10;

signal clk_sig:     std_logic := '0';
signal rst_sig:    std_logic := '0';
signal count:   integer := 0;

begin
DUT: entity work.toplevel(Structural)
    port map(clk => clk_sig,
             rst => rst_sig);

clock: process(CLK_sig)
      begin
        CLK_sig <= not CLK_sig after TIME_DELAY/2;
end process clock;

rst_sig <= '0', '1' after 2 ns, '0' after 4 ns;

process(clk_sig)
begin
    if falling_edge(clk_sig) then
        count <= count + 1;
    end if;
end process;
end Behavioral;
