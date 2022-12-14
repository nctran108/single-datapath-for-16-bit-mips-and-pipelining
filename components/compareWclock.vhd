library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity compareWclock is
    Port (clk:      in std_logic;
          a:        in std_logic_vector(15 downto 0);
          b:        in std_logic_vector(15 downto 0);
          result:   out std_logic
          );
end compareWclock;

architecture Behavioral of compareWclock is

begin
process(clk,a,b)
variable output:    std_logic := '0';
begin
    if rising_edge(clk) then
        if a = b then
            output := '0';
        else
            output := '1';
        end if;
    elsif falling_edge(clk) then
        output := '0';
    end if;
    
    result <= output;
end process;

end Behavioral;
