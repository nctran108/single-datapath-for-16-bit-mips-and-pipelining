library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registers is
    Port (clk:      in std_logic;
          RegWrite: in std_logic;
          r1:       in std_logic_vector(3 downto 0);
          r2:       in std_logic_vector(3 downto 0);
          wr:       in std_logic_vector(3 downto 0);
          wd:       in std_logic_vector(15 downto 0);
          rd1:      out std_logic_vector(15 downto 0);
          rd2:      out std_logic_vector(15 downto 0)
          );
end registers;

architecture Behavioral of registers is
type register_type is array (0 to 15) of std_logic_vector(15 downto 0);
signal register_array : register_type := (others => x"0000");


begin
clock: process(clk,RegWrite)
begin
    if falling_edge(clk) then
        if RegWrite = '1' then
            register_array(to_integer(unsigned(wr))) <= wd;
        else
            register_array(to_integer(unsigned(wr))) <= register_array(to_integer(unsigned(wr)));
        end if;
    end if;
end process clock;

rd1 <= register_array(TO_INTEGER(unsigned(r1)));
rd2 <= register_array(TO_INTEGER(unsigned(r2)));

end Behavioral;
