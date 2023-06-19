library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PWM_digital_top_E is
  generic(message_length : integer   := 17;
          pwm_bit        : integer   := 14;
          address_length : integer   := 2);
  port (                                -- general signals
    reset_n                         : in  std_logic;
    clk                             : in  std_logic;
    -- SPI interface
    sclk                            : in  std_logic;
    cs_n                            : in  std_logic;
    din                             : in  std_logic;
    -- PWM output
    pwm_out1, pwm_out2, pwm_n_sleep : out std_logic);
end entity PWM_digital_top_E;

architecture struct of PWM_digital_top_E is

--ADD DECLARATION FOR THE NECESSARY COMPONENTS


--ADD NECESSARY SIGNALS

begin

--ADD INSTANCES OF THE DIFFERENT COMPONENTS


end struct;
