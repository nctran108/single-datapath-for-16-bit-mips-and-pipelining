library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_8to1_16bits is
    Port (sel:      in std_logic_vector(2 downto 0);
          a:        in std_logic_vector(15 downto 0);
          b:        in std_logic_vector(15 downto 0);
          c:        in std_logic_vector(15 downto 0);
          d:        in std_logic_vector(15 downto 0);
          e:        in std_logic_vector(15 downto 0);
          f:        in std_logic_vector(15 downto 0);
          g:        in std_logic_vector(15 downto 0);
          h:        in std_logic_vector(15 downto 0);
          output:   out std_logic_vector(15 downto 0)          
          );
end mux_8to1_16bits;

architecture Behavioral of mux_8to1_16bits is

begin
process(sel,a,b,c,d,e,f,g,h)
begin
    if sel = "000" then
        output <= a;
    elsif sel = "001" then
        output <= b;
    elsif sel = "010" then
        output <= c;
    elsif sel = "011" then
        output <= d;
    elsif sel = "100" then
        output <= e;
    elsif sel = "101" then
        output <= f;
    elsif sel = "110" then
        output <= g;
    else
        output <= h;
    end if;
end process;

end Behavioral;
