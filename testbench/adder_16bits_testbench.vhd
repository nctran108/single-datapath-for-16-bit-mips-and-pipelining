library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder_16bits_testbench is
end adder_16bits_testbench;

architecture Behavioral of adder_16bits_testbench is
constant TIME_DELAY : time := 20 ns;
constant NUM_VALS : integer := 8;

signal clk_sig: std_logic := '0';
signal Cin_sig: std_logic;
signal Din1_sig, Din2_sig:    std_logic_vector(15 downto 0);
signal Dout_sig: std_logic_vector(15 downto 0);

type sig_array is array(0 to NUM_VALS-1) of std_logic_vector(15 downto 0);
type carry_array is array(0 to NUM_VALS-1) of std_logic;

constant Cin_vals: carry_array := ('0','0','0','0','1','1','1','1');
constant Din1_vals: sig_array := (x"0000",x"0004",x"0008",x"000C",x"0010",x"0014",x"0018",x"001C");
constant Din2_vals: sig_array := (x"0000",x"0000",x"0001",x"0002",x"0003",x"0000",x"0001",x"0005");
constant Dout_vals: sig_array := (x"0000",x"0004",x"0009",x"000E",x"000D",x"0014",x"0017",x"0017");

begin
DUT: entity work.add_16bits(Behavioral)
    port map(C_in => Cin_sig,
             Din1 => Din1_sig,
             Din2 => Din2_sig,
             Dout => Dout_sig);

clock: process(CLK_sig)
      begin
        CLK_sig <= not CLK_sig after TIME_DELAY/2;
end process clock;

stimulus: process
begin
    for i in 0 to NUM_VALS-1 loop
        Cin_sig <= Cin_vals(i);
        Din1_sig <= Din1_vals(i);
        if i <= 3 then
            Din2_sig <= Din2_vals(i);
        else
            Din2_sig <= not Din2_vals(i);
        end if;
        Dout_sig <= Dout_vals(i);
        wait for TIME_DELAY;
    end loop;
    wait;
end process stimulus; 
end Behavioral;
