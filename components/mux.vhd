library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux is
    Port (sel:      in std_logic;
          RegDst:   in std_logic;
          Jump:     in std_logic;
          Branch:   in std_logic;
          MemRead:  in std_logic;
          MemtoReg: in std_logic;
          MemWrite: in std_logic;
          ALUSrc:   in std_logic;
          RegWrite: in std_logic;
          ALUOp:    in std_logic_vector(3 downto 0);
          Dout1:     out std_logic;
          Dout2:     out std_logic;
          Dout3:     out std_logic;
          Dout4:     out std_logic;
          Dout5:     out std_logic;
          Dout6:     out std_logic;
          Dout7:     out std_logic;
          Dout8:     out std_logic;
          Dout9:     out std_logic_vector(3 downto 0)
          );
end mux;

architecture Behavioral of mux is

begin

process(sel,RegDst,Jump,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,ALUOp)
begin
    if sel = '0' then
        Dout1 <= RegDst;
        Dout2 <= Jump;
        Dout3 <= Branch;
        Dout4 <= MemRead;
        Dout5 <= MemtoReg;
        Dout6 <= MemWrite;
        Dout7 <= ALUSrc;
        Dout8 <= RegWrite;
        Dout9 <= ALUOp;
    else
        Dout1 <= '0';
        Dout2 <= '0';
        Dout3 <= '0';
        Dout4 <= '0';
        Dout5 <= '0';
        Dout6 <= '0';
        Dout7 <= '0';
        Dout8 <= '0';
        Dout9 <= "0000";
    end if;
end process;

end Behavioral;
