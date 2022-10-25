library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity or_16bits is
    Port (Din1:     in std_logic_vector(15 downto 0);
          Din2:     in std_logic_vector(15 downto 0);
          Dout:     out std_logic_vector(15 downto 0)
          );
end or_16bits;

architecture Behavioral of or_16bits is

begin

    Dout <= Din1 or Din2;

end Behavioral;
