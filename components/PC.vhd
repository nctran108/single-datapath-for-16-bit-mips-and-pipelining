library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PC is
    Port (CLK:      in std_logic;
          rst:      in std_logic;
          PCin:     in std_logic_vector(15 downto 0);
          PCout:    out std_logic_vector(15 downto 0));
end PC;

architecture Behavioral of PC is

begin
clock: process(CLK,rst)
variable input: std_logic_vector(15 downto 0);
variable output: std_logic_vector(15 downto 0) := x"0000";
begin
    input := PCin;
    if rst = '1' then
        output := x"0000";
    else
        if falling_edge(CLK) then
            -- update every falling edge
            output := input;
        else
            output := output;
        end if;
    end if;
    PCout <= output;
end process clock;

end Behavioral;
