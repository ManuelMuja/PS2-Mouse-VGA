library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity count8 is
  port( clockIn : in std_logic;
        reset  : in std_logic;
        clockOut : out std_logic);
end count8;

architecture behavioral of count8 is
signal conta : std_logic_vector(2 downto 0);
begin
process (reset, clockIn)
begin
  if (reset = '1') then
    conta <= '000';
  elsif (clockIn = '1' and clockIn'event) then
    conta <= conta + '1';
  end if;
end process;
clockOut <= conta(2);
end behavioral;
