library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mul_16bits is
    Port (a:        in std_logic_vector(15 downto 0);
          b:        in std_logic_vector(15 downto 0);
          result:   out std_logic_vector(15 downto 0)
         );
end mul_16bits;

architecture Behavioral of mul_16bits is

begin
    result <= std_logic_vector(signed(a) * signed(b));
end Behavioral;
