library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity setLessThan_16bits is
    Port (a:        in std_logic_vector(15 downto 0);
          b:        in std_logic_vector(15 downto 0);
          rt:   out std_logic_vector(15 downto 0)
          );
end setLessThan_16bits;

architecture Behavioral of setLessThan_16bits is

begin
process(a,b)
variable a_sig,b_sig: signed(15 downto 0);
begin
    a_sig := signed(a);
    b_sig := signed(b);
    if a_sig < b_sig then
        rt <= x"0001";
    else
        rt <= x"0000";
    end if;
end process;

end Behavioral;