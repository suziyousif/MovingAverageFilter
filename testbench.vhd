library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is

end entity testbench;

architecture RTL of testbench is
		signal clk 			: std_logic;
		signal rst			: std_logic;
		signal data_in 		: std_logic_vector(15 downto 0);
		signal average 		: std_logic_vector(15 downto 0);
begin

	MovingAverage_inst : entity work.MovingAverage
		port map(
			
			clk          => clk,
			rst          => rst,
			data_in      => data_in,
			average      => average
		);
	clock_driver : process
		constant period : time := 10 ns;
	begin
		clk <= '0';
		wait for period / 2;
		clk <= '1';
		wait for period / 2;
	end process clock_driver;

	dataIn : process is
	begin
		data_in <= std_logic_vector(to_unsigned(32, data_in'length));
		wait for 340 ns;
		data_in <= std_logic_vector(to_unsigned(16, data_in'length));
		wait for 320 ns;
		data_in <= std_logic_vector(to_unsigned(32, data_in'length));
		wait;
	end process dataIn;
	
	rst <= '1', '0' after 10 ns;	
	
end architecture RTL;
