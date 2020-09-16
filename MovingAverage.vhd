library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity MovingAverage is
	port(
		clk 		: in std_logic;
		rst			: in std_logic;
		data_in 	: in std_logic_vector(15 downto 0);
		average 	: out std_logic_vector(15 downto 0)
	);
end entity MovingAverage;

architecture RTL of MovingAverage is
	signal clear_n : std_logic;
	signal we : std_logic;
	signal write_address:unsigned(4 downto 0):= "00000";
	signal read_address:unsigned(4 downto 0):= "00000";
	signal buff_value:std_logic_vector(15 downto 0);
	signal average_sum :std_logic_vector(15 downto 0);
begin
	clear_n <= not rst;

	rom_gen: entity work.rom_ram
		port map(
			clk           => clk,
			write_address => write_address,
			read_address  => read_address,
			we            => '1',
			data_in       => data_in,
			q             => buff_value
		);	

	process (clk, rst) is
	begin
		if rst = '1' then
			write_address <= "00000";
			read_address <= "00000";
			average_sum <= (others =>'0');
			--we <= '1';
		elsif rising_edge(clk) then	
			average_sum <= std_logic_vector(unsigned(average_sum)- unsigned(buff_value) + unsigned(data_in));
			-- write ram
			write_address <= read_address;
			read_address <= read_address + 1;
		end if;
	end process;
	average <= "00000" & average_sum(15 downto 5);
end architecture RTL;
