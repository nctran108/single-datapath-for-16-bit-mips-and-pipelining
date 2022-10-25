library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder is
    Port (Din:      in std_logic_vector(15 downto 0);
          Dout:     out std_logic_vector(15 downto 0)
          );
end adder;

architecture Behavioral of adder is
begin
process(Din)
begin
    Dout <= std_logic_vector(unsigned(Din) + "0000000000000100");
end process;
end Behavioral;
