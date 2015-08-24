library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity VGA is
  port( reset : in std_logic;
        clk_0 : in std_logic;
	    xs: in std_logic_vector(9 downto 0);
	    ys: in std_logic_vector(9 downto 0);
		lbutton : in std_logic;
		rbutton : in std_logic;
        r,g,b : out std_logic;
        hs,vs : out std_logic);
end VGA;

architecture behavior of VGA is
  signal clk        : std_logic:='0';		       --25M像素时钟
  signal r1,g1,b1   : std_logic;
  signal hs1,vs1    : std_logic;
  signal vector_x : std_logic_vector(9 downto 0);		--X坐标
  signal vector_y : std_logic_vector(8 downto 0);		--Y坐标
begin

-----------------------------------------------------------------------
  process(reset, clk_0)
  begin
    if (reset = '1') then
      clk <= '0';
    elsif (clk_0'event and clk_0='1') then 
      clk <= not clk;
    end if;
  end process;

 -----------------------------------------------------------------------
  process(clk, reset)
  begin
    if reset='1' then
      vector_x <= (others=>'0');
    elsif clk'event and clk='1' then
      if vector_x=799 then
        vector_x <= (others=>'0');
      else
        vector_x <= vector_x + 1;
      end if;
    end if;
  end process;

  -----------------------------------------------------------------------
  process(clk, reset)
  begin
    if reset='1' then
      vector_y <= (others=>'0');
    elsif clk'event and clk='1' then
      if vector_x=799 then
        if vector_y=524 then
          vector_y <= (others=>'0');
        else
          vector_y <= vector_y + 1;
        end if;
      end if;
    end if;
  end process;
 
  -----------------------------------------------------------------------
	 process(clk, reset)
	 begin
		  if reset='1' then
		   hs1 <= '1';
		  elsif clk'event and clk='1' then
		   	if vector_x>=656 and vector_x<752 then
		    	hs1 <= '0';
		   	else
		    	hs1 <= '1';
		   	end if;
		  end if;
	 end process;
 
 -----------------------------------------------------------------------
	 process(clk, reset) --场同步信号产生（同步宽度2，前沿10）
	 begin
	  	if reset='1' then
	   		vs1 <= '1';
	  	elsif clk'event and clk='1' then
	   		if vector_y>=490 and vector_y<492 then
	    		vs1 <= '0';
	   		else
	    		vs1 <= '1';
	   		end if;
	  	end if;
	 end process;
 -----------------------------------------------------------------------
	 process(clk, reset) --行同步信号输出
	 begin
	  	if reset='1' then
	   		hs <= '0';
	  	elsif clk'event and clk='1' then
	   		hs <=  hs1;
	  	end if;
	 end process;

 -----------------------------------------------------------------------
	 process(clk, reset) --场同步信号输出
	 begin
	  	if reset='1' then
	   		vs <= '0';
	  	elsif clk'event and clk='1' then
	   		vs <=  vs1;
	  	end if;
	 end process;
	
 -----------------------------------------------------------------------	
	process(reset,clk,vector_x,vector_y) -- XY坐标定位控制
	begin  
		if reset='1' then
			        r1   <= '0';
					g1	<= '0';
					b1	<= '0';	
		elsif(clk'event and clk='1')then
		  if (vector_x>=xs and vector_x<=xs+7) then
		    if ((vector_y>=ys and vector_y<=ys+10 and vector_x=xs) or
		      (vector_y>=ys+1 and vector_y<=ys+9 and vector_x=xs+1) or
		      (vector_y>=ys+2 and vector_y<=ys+8 and vector_x=xs+2) or
		      (vector_y>=ys+3 and vector_y<=ys+7 and vector_x=xs+3) or
		      (vector_y>=ys+4 and vector_y<=ys+7 and vector_x=xs+4) or
		      ((vector_y=ys+5 or vector_y=ys+6 or vector_y=ys+7) and vector_x=xs+5) or
		      ((vector_y=ys+6 or vector_y=ys+7) and vector_x=xs+6) or
		      (vector_y=ys+7 and vector_x=xs+7)) then
		      if (lbutton='1' and rbutton='1') then
		        r1<='1';b1<='1';g1<='1';
		      elsif (lbutton='1') then
		        r1<='1';b1<='1';g1<='0';
		      elsif (rbutton='1') then
		        r1<='1';b1<='0';g1<='1';
		      else
				r1<='0';b1<='1';g1<='1';
			  end if;
		    else
				r1 <='0';
				b1 <='0';
				g1 <='0';
		    end if;
		  else r1<='0';b1<='0';g1<='0';
		  end if;
		end if;		 
	    end process;	

-----------------------------------------------------------------------
	--色彩输出
	r <= r1 and hs1 and vs1;
	g <= g1 and hs1 and vs1;
   	b <= b1 and hs1 and vs1;

end behavior;