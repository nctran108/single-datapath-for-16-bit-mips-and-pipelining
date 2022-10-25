library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_2to1_nbits is
    generic (N: integer := 16);
    Port (sel:      in std_logic;
          Din1:     in std_logic_vector(N-1 downto 0);
          Din2:     in std_logic_vector(N-1 downto 0);
          Dout:     out std_logic_vector(N-1 downto 0)
          );
end mux_2to1_nbits;

architecture Behavioral of mux_2to1_nbits is

begin
process(sel,Din1,Din2)
begin
    if sel = '0' then
        Dout <= Din1;
    else
        Dout <= Din2;
    end if;
end process;
end Behavioral;
