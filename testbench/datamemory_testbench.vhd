library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity datamemory_testbench is
end datamemory_testbench;

architecture Behavioral of datamemory_testbench is
constant TIME_DELAY : time := 20 ns;
constant NUM_VALS : integer := 8;

signal clk_sig:      std_logic := '0';
signal memWrite_sig, memRead_sig: std_logic;
signal Addr_sig:     std_logic_vector(15 downto 0);
signal writeData_sig:     std_logic_vector(15 downto 0);
signal readData_sig:   std_logic_vector(15 downto 0);

type Data_array is array(0 to NUM_VALS-1) of std_logic_vector(15 downto 0);
type onebit_array is array(0 to NUM_VALS-1) of std_logic;

constant Addr_vals : Data_array := (x"0000",x"0002",x"0010",x"0016",x"000A",x"0018",x"001A",x"0030");
constant writeData_vals : Data_array := (x"0002",x"0020",x"0200",x"2000",x"0000",x"0001",x"0010",x"0100");
constant memWrite_vals : onebit_array := ('0','1','0','1','0','1','0','1');
constant memRead_vals : onebit_array := ('0','0','0','0','1','1','1','1');
--constant readData_vals : Data_array := (x"0000",x"0000",x"0000",x"0008",x"0000",x"0004",x"0004",x"0004");

begin
DUT: entity work.dataMemory(Behavioral)
    port map(clk => clk_sig,
             memWrite => memWrite_sig,
             memRead => memRead_sig,
             Addr => Addr_sig,
             writeData => writeData_sig,
             readData => readData_sig
             );

clock: process(CLK_sig)
      begin
        CLK_sig <= not CLK_sig after TIME_DELAY/2;
end process clock;

stimulus: process
begin
    for i in 0 to NUM_VALS-1 loop
        memWrite_sig <= memWrite_vals(i);
        memRead_sig <= memRead_vals(i);
        Addr_sig <= Addr_vals(i);
        writeData_sig <= writeData_vals(i);
--        readData_sig <= readData_vals(i);
        wait for TIME_DELAY;
    end loop;
    wait;
end process stimulus;

end Behavioral;
