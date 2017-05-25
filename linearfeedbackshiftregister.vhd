
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lfsr_n is
 	generic (constant N: integer :=4 );
 	port (
	 	clk			:in  std_logic;                    
		reset			:in  std_logic;                  
		lfsr_out		:out std_logic_vector (1 downto 0)
  	);
end entity;

architecture behavioral of lfsr_n is
 	
signal lfsr_tmp :std_logic_vector (0 to N-1);
begin
 	process (clk,reset) 
		variable feedback 	:std_logic;
	begin
	  	  if (reset = '1') then
		lfsr_tmp <= ('1','0','0','1');
	elsif (rising_edge(clk)) then
	   feedback:=lfsr_tmp(2) xor lfsr_tmp(3); 
		lfsr_tmp <= feedback & lfsr_tmp(0 to N-2);
		 
	end if;
	
	end process;	
	
	lfsr_out(0)<= lfsr_tmp(3);
	lfsr_out(1)<= lfsr_tmp(2);
	
end architecture;
