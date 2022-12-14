library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux3to1_nbits is
    generic (N: integer := 16);
    Port (sel:      in std_logic_vector(1 downto 0);
          Din1:     in std_logic_vector(N-1 downto 0);
          Din2:     in std_logic_vector(N-1 downto 0);
          Din3:     in std_logic_vector(N-1 downto 0);
          Dout:     out std_logic_vector(N-1 downto 0)
          );
end mux3to1_nbits;

architecture Behavioral of mux3to1_nbits is

begin
process(sel,Din1,Din2,Din3)
begin
    if sel = "00" then
        Dout <= Din1;
    elsif sel = "01" then
        Dout <= Din2;
    elsif sel = "10" then
        Dout <= Din3;
    else
        Dout <= Din1;
    end if;
end process;

end Behavioral;
