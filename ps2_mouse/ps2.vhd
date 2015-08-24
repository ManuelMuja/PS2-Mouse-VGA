--------------------------------------------
--功能：在VGA上显示鼠标光标，用双键机械鼠标
--时钟: Clock0=50M;
--模式: 5
--鼠标接下接口
---------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity manage_data is
  port( reset   : in std_logic;
        clk     : in std_logic;
        m_clk   : inout std_logic;
        m_data  : inout std_logic;
        r,g,b	: out std_logic;
        hs,vs	: out std_logic );
end manage_data;

architecture proc of manage_data is
  component VGA is
    port( reset : in std_logic;
          clk_0 : in std_logic;
          xs: in std_logic_vector(9 downto 0);
          ys: in std_logic_vector(9 downto 0);
          lbutton : in std_logic;
          rbutton : in std_logic;
          r,g,b : out std_logic;
          hs,vs : out std_logic);
  end component;

  component mouse is
    port( clk : in std_logic;
          reset : in std_logic;
          ps2_clk : inout std_logic;
          ps2_data : inout std_logic;
          left_button : out std_logic;
          right_button : out std_logic;
          mousex: buffer std_logic_vector(9 downto 0);
          mousey: buffer std_logic_vector(9 downto 0);
          error_no_ack : out std_logic );
  end component;
	
  component count64 is
    port( sysclk : in std_logic;
          reset  : in std_logic;
          clkout : out std_logic);
  end component;

signal x,y: std_logic_vector(9 downto 0);
signal ll,rr: std_logic;
signal err, clk_o: std_logic;
begin
u0: count64 port map(clk, reset, clk_o);
u1: mouse port map(clk_o, reset, m_clk, m_data, ll, rr, x,y, err);
u2: VGA port map(reset, clk, x,y,ll,rr,r,g,b,hs,vs);
end proc;