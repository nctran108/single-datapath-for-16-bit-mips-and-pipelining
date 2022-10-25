library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shift_left_2 is
    generic (N: integer := 16);
    Port (Din:      in std_logic_vector(N-1 downto 0);
          Dout:     out std_logic_vector(N-1 downto 0)
          );
end shift_left_2;

architecture Behavioral of shift_left_2 is

begin
process(Din)
begin
    Dout <= Din(N-3 downto 0) & "00";
end process;
end Behavioral;
