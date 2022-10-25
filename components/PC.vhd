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
          PCin:     in std_logic_vector(15 downto 0);
          PCout:    out std_logic_vector(15 downto 0));
end PC;

architecture Behavioral of PC is

begin
clock: process(CLK)
variable input: std_logic_vector(15 downto 0);
variable ouput: std_logic_vector(15 downto 0);
begin
    input := PCin;
    if falling_edge(CLK) then
        -- update every falling edge
        ouput := input;
    else
        ouput := ouput;
    end if;
    PCout <= ouput;
end process clock;

end Behavioral;
