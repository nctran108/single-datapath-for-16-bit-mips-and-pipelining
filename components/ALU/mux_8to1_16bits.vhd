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
          a:      in std_logic_vector(15 downto 0);
          b:      in std_logic_vector(15 downto 0);
          c:      in std_logic_vector(15 downto 0);
          d:      in std_logic_vector(15 downto 0);
          e:      in std_logic_vector(15 downto 0);
          f:      in std_logic_vector(15 downto 0);
          g:      in std_logic_vector(15 downto 0);
          h:      in std_logic_vector(15 downto 0);
          result: out std_logic_vector(15 downto 0)          
          );
end mux_8to1_16bits;

architecture Behavioral of mux_8to1_16bits is

begin
process(sel,a,b,c,d,e,f,g,h)
begin
    case sel is
    when "000" =>
        result <= a;
    when "001" =>
        result <= b;
    when "010" =>
        result <= c;
    when "011" =>
        result <= d;
    when "100" =>
        result <= e;
    when "101" =>
        result <= f;
    when "110" =>
        result <= g;
    when others =>
        result <= h;
    end case;
end process;

end Behavioral;
