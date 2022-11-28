library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registers_testbench is
end registers_testbench;

architecture Behavioral of registers_testbench is
constant TIME_DELAY : time := 20 ns;
constant NUM_VALS : integer := 8;

signal clk_sig: std_logic := '0';
signal RegWrite_sig: std_logic;
signal r1_sig, r2_sig, wr_sig: std_logic_vector(3 downto 0);
signal rd1_sig, rd2_sig:    std_logic_vector(15 downto 0);
signal wd_sig: std_logic_vector(15 downto 0);

type sig_array is array(0 to NUM_VALS-1) of std_logic_vector(15 downto 0);
type reg_array is array(0 to NUM_VALS-1) of std_logic_vector(3 downto 0);
type sel_array is array(0 to NUM_VALS-1) of std_logic;

constant RegWrite_vals: sel_array := ('0','0','0','0','1','1','1','1');
constant r1_vals: reg_array := (x"0",x"1",x"2",x"3",x"A",x"B",x"C",x"D");
constant r2_vals: reg_array := (x"4",x"5",x"6",x"7",x"8",x"9",x"E",x"F");
constant wr_vals: reg_array := (x"4",x"5",x"6",x"7",x"A",x"B",x"C",x"D");
constant wd_vals: sig_array := (x"0000",x"0004",x"0008",x"000C",x"0003",x"0000",x"0001",x"0005");
constant rd1_vals: sig_array := (x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000");
constant rd2_vals: sig_array := (x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000");

begin
DUT: entity work.registers(Behavioral)
    port map(clk => clk_sig,
             RegWrite => RegWrite_sig,
             r1 => r1_sig,
             r2 => r2_sig,
             wr => wr_sig,
             wd => wd_sig,
             rd1 => rd1_sig,
             rd2 => rd2_sig
             );

clock: process(CLK_sig)
      begin
        CLK_sig <= not CLK_sig after TIME_DELAY/2;
end process clock;

stimulus: process
begin
    for i in 0 to NUM_VALS-1 loop
        RegWrite_sig <= RegWrite_vals(i);
        r1_sig <= r1_vals(i);
        r2_sig <= r2_vals(i);
        wr_sig <= wr_vals(i);
        wd_sig <= wd_vals(i);
        rd1_sig <= rd1_vals(i);
        rd2_sig <= rd2_vals(i);
        wait for TIME_DELAY;
    end loop;
    wait;
end process stimulus; 

end Behavioral;
