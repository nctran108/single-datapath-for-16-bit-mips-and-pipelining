library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity signExtend is
    Port (din:      in std_logic_vector(3 downto 0);
          dout:     out std_logic_vector(15 downto 0)
          );
end signExtend;

architecture Behavioral of signExtend is
begin
dout(15 downto 4) <= (others => din(3));
dout(3 downto 0) <= din;
end Behavioral;
