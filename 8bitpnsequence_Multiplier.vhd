library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lfsr_n is
 	generic(constant N: integer :=8
 	);
 
 	port (
 	  x,y:in std_logic_vector(3 downto 0);
	 	clk			:in  std_logic;                    
		reset			:in  std_logic;  
		lfsr_outB:out std_logic_vector(3 downto 0);                
		lfsr_out		:out std_logic_vector (3 downto 0);
		CapX,CapY: out std_logic;
		Z:out std_logic;
		Zcnt:out integer)
		;
end entity;

architecture behavioral of lfsr_n is
 	signal lfsr_tmp			:std_logic_vector (0 to N-1);
 	signal lfsr_tmpB			:std_logic_vector (0 to N-1);
 	 
 	 signal Xtmp,Ytmp,Ztmp:std_logic;
 	 signal cnt: integer:=0;
 	 
begin
 	process (clk,reset) 
		variable feedback 	:std_logic;
	begin
	  	  if (reset = '1') then
		lfsr_tmp <= (0=>'1', others=>'1');
	elsif (rising_edge(clk)) then
	   feedback:=(((lfsr_tmp(5) xor lfsr_tmp(7)) xor lfsr_tmp(4))xor lfsr_tmp(3)); 
		lfsr_tmp <= feedback & lfsr_tmp(0 to N-2);	 
	end if;
	end process;	
	lfsr_out(0)<= lfsr_tmp(7);
	lfsr_out(1)<= lfsr_tmp(6);
	lfsr_out(2)<= lfsr_tmp(5);
	lfsr_out(3)<= lfsr_tmp(4);
	
	
	
	process (clk,reset) 
		variable feedbackB 	:std_logic;
	begin
	  	  if (reset = '1') then
		lfsr_tmpB <= ('1','1','1','1','1','1','1','1');
	elsif (rising_edge(clk)) then
	   feedbackB:=(((lfsr_tmpB(5) xor lfsr_tmpB(7)) xor lfsr_tmpB(4))xor lfsr_tmpB(3)); 
		lfsr_tmpB <= feedbackB & lfsr_tmpB(0 to N-2);	 
	end if;
	end process;	
	lfsr_outB(0)<= lfsr_tmpB(7);
	lfsr_outB(1)<= lfsr_tmpB(6);
	lfsr_outB(2)<= lfsr_tmpB(5);
	lfsr_outB(3)<= lfsr_tmpB(4);
       
        
        
        Xtmp<=(lfsr_tmp(7) and x(0)) or  ((lfsr_tmp(6) and not lfsr_tmp(7)) and x(1)) or ((lfsr_tmp(5) and not lfsr_tmp(6)) and x(2)) or ((lfsr_tmp(4) and not lfsr_tmp(5)) and x(3));
        Ytmp<=(lfsr_tmpB(7) and y(0)) or  ((lfsr_tmpB(6) and not lfsr_tmpB(7)) and y(1)) or ((lfsr_tmpB(5) and not lfsr_tmpB(6)) and y(2)) or ((lfsr_tmpB(4) and not lfsr_tmpB(5)) and y(3));

       CapX <=Xtmp;
        CapY<=Ytmp;
        Ztmp<=Xtmp and Ytmp;
        process(clk)
          --variable cnt: integer;
          begin
          
            if clk'event and clk='1' then 
            if Ztmp='1'
            then cnt<=cnt+1;
            else cnt<=cnt;
            end if;
          end if;
          end process;
          
          Z<=Ztmp;
          Zcnt<=cnt;
        
end architecture;

