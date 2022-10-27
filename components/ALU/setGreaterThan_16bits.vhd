library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity setGreaterThan_16bits is
    Port (a:        in std_logic_vector(15 downto 0);
          b:        in std_logic_vector(15 downto 0);
          result:   out std_logic_vector(15 downto 0)
          );
end setGreaterThan_16bits;

architecture Behavioral of setGreaterThan_16bits is

begin
process(a,b)
variable a_sig,b_sig: integer := 0;
begin
    a_sig := to_integer(signed(a));
    b_sig := to_integer(signed(b));
    if a > b then
        result <= x"0001";
    else
        result <= x"0000";
    end if;
end process;

end Behavioral;
