library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity count64 is
  port( sysclk : in std_logic;
        reset  : in std_logic;
        clkout : out std_logic);
end count64;

architecture behavioral of count64 is
signal count : std_logic_vector(6 downto 0);
begin
process (reset,sysclk)
begin
  if (reset='1') then
    count <= (others=>'0');
  elsif (sysclk'event and sysclk='1') then
    count <= count+'1';
  end if;
end process;
clkout <= count(6);
end behavioral;
