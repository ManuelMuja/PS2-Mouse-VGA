library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ritardo is
  port( datoIn : in std_logic;
        clock  : in std_logic;
        datoOut : out std_logic);
end ritardo;

architecture behavioral of ritardo is
begin
process (datoIn, clock)
begin
  if (clock'event and clock='1') then
    datoOut <= datoIn;
  end if;
end process;
end behavioral;
