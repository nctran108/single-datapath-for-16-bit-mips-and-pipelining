library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity div_16bits is
    Port (a:        in std_logic_vector(15 downto 0);
          b:        in std_logic_vector(15 downto 0);
          result:   out std_logic_vector(15 downto 0)
          );
end div_16bits;

architecture Behavioral of div_16bits is

begin
process(a,b)
variable output: std_logic_vector(15 downto 0);
begin
    if b = x"0000" then
        output := x"0000";
    else
        output := std_logic_vector(unsigned(a)/unsigned(b));
    end if;
    result <= output;
end process;
end Behavioral;
