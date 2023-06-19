library ieee;
use ieee.std_logic_1164.all;

entity PWM_driver_E is
  generic(
    pwm_bit : integer := 14
    );
  port(
    reset_n                         : in  std_logic;
    clk                             : in  std_logic;
    pwm_base_period                 : in  integer range 0 to 2**(pwm_bit)-1;
    pwm_duty_cycle                  : in  integer range 0 to 2**(pwm_bit)-1;
    pwm_control                     : in  std_logic_vector(7 downto 0);
    pwm_cycle_done                  : out std_logic;  -- new values at inputs are now used
    pwm_out1, pwm_out2, pwm_n_sleep : out std_logic);
end PWM_driver_E;

architecture rtl of PWM_driver_E is
--ADD SIGNALS

begin

--ADD THE FUNCTIONALITY FOR THE PWM DRIVER


end rtl;
