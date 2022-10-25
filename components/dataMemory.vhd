library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dataMemory is
    Port (clk:      in std_logic;
          memWrite: in std_logic;
          memRead:  in std_logic;
          Addr:     in std_logic_vector(15 downto 0);
          writeData:in std_logic_vector(15 downto 0);
          readData: out std_logic_vector(15 downto 0)
          );
end dataMemory;

architecture Behavioral of dataMemory is
constant MAX_SIZE: integer:= 65536;
type mem is array (0 to MAX_SIZE) of std_logic_vector(15 downto 0);
signal memArray: mem := (others => x"0000");

begin
process(clk,memWrite,memRead,Addr,writeData)
variable index: integer := 0;
begin
index := TO_INTEGER(unsigned(addr));
if falling_edge(clk) then
    if memWrite = '1' and memRead = '0' then
        memArray(index) <= writeData;
        readData <= x"0000";
    elsif memRead = '1' and memWrite = '0' then
        memArray(index) <= memArray(index);
        readData <= memArray(index);
    else
        memArray(index) <= memArray(index);
        readData <= addr;
        end if;
    end if;

end process;

end Behavioral;
