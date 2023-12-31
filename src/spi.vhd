-------------------------------------------------------------------------------
-- Title      : DHS ADC
-- Project    : 
-------------------------------------------------------------------------------
-- File       : control.vhd
-- Author     : Marcel Putsche  <...@hrz.tu-chemnitz.de>
-- Company    : TU-Chemmnitz, SSE
-- Created    : 2018-04-10
-- Last update: 2019-04-11
-- Platform   : x86_64-redhat-linux
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: SPI part of the ADC in DHS practical lab
-------------------------------------------------------------------------------
-- Copyright (c) 2018 TU-Chemmnitz, SSE
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2018-04-10  1.0      mput    Created
-------------------------------------------------------------------------------
-- Chenxi Sun 768218
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SPI is
  generic(message_length : integer   := 17;
          pwm_bit        : integer   := 14;
          address_length : integer   := 2);
         
  port (                                -- general signals
    reset_n    : in  std_logic;
    clk        : in  std_logic;
    -- SPI interface
    sclk       : in  std_logic;
    cs_n       : in  std_logic;
    din        : in  std_logic;
    -- internal interface
    new_data   : out std_logic;         -- new data available
    regnr      : out std_logic_vector (address_length-1 downto 0);  -- register address
    regcontent : out std_logic_vector (pwm_bit-1 downto 0);  -- register write value
    regwrite_n : out std_logic          -- write access?
    );
end entity SPI;

architecture RTL of SPI is
  --ADD TYPE FOR STATE MACHINE
  type state_type is (s1,s2,s3,s4);
  --ADD SIGNALS
  signal s_counter  : integer range 0 to 17;
  signal s_state, s_nextstate    : state_type;
  signal s_set_counter : std_logic;
  signal s_regnr      : std_logic_vector (address_length-1 downto 0); 
  signal s_regcontent : std_logic_vector (pwm_bit-1 downto 0); 
  signal s_regwrite_n : std_logic ;
  signal s_parallel_out : std_logic_vector (message_length-1 downto 0);



begin

--ADD PROCESSES FOR THE STATE MACHINE WHIC CONTROLS THE SPI, COUNTER FOR SPI
Finite_State_Machine_counter:process (clk,reset_n,sclk)
	begin
	if reset_n= '0' then
	s_state <=s1;
	s_counter <= 0;
	--end if;
	elsif rising_edge(clk)then
		s_state <= s_nextstate;
		if s_set_counter ='1' then
		s_counter <= 0;
	end if;
	elsif falling_edge(sclk)then
		if s_counter < 17 then
			s_counter <=s_counter+1;
		else
			s_counter <=0;
		end if;
	end if;
	
end process;

Finite_State_Machine_stats:process(s_state,s_counter,cs_n)
	begin
	s_set_counter <='0';
	s_nextstate<=s_state;
	case s_state is
		when s1=> if cs_n = '0' then
			s_nextstate <= s2; s_set_counter <= '1';
		end if;
		when s2=> if s_counter = 17 then
			s_nextstate <= s3;
		end if;
		when s3=>
			s_nextstate <= s4; 
		when s4=> if cs_n = '1' then
			s_nextstate <= s1;
		end if;
		when others=>
			s_nextstate <= s1; 
	end case;
end process;
--AND OUTPUT REGISTERS
Output_reg: process(sclk,reset_n,clk,s_state,din)
	begin
	if reset_n= '0' then
		s_parallel_out <= (others=>'0');
		s_regnr <= (others=>'0');
		s_regcontent <= (others=>'0');
		s_regwrite_n <= '1';
		new_data <= '0';
	elsif reset_n= '1' then
		if s_state = s1 then
			s_parallel_out <= (others=>'0');
		elsif s_state = s2 then
			if falling_edge(sclk)then
			s_parallel_out <= s_parallel_out(15 downto 0)&din;
			end if;
		elsif s_state = s3 then
			new_data <= '1';
			s_regnr <= s_parallel_out(16 downto 15);
			s_regcontent <= s_parallel_out(13 downto 0);
			s_regwrite_n <= s_parallel_out(14);
		elsif s_state = s4 then
			new_data <= '0';
		end if;
	end if;
end process;

	regnr <= s_regnr;
	regwrite_n <= s_regwrite_n;
	regcontent <= s_regcontent;

-- counter synchronous to SPI clock?



end architecture RTL;