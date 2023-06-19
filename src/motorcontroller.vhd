LIBRARY IEEE;
USE IEEE.ELECTRICAL_SYSTEMS.ALL;
use IEEE.std_logic_1164.all;
use ieee.math_real.all;

ENTITY motorcontroller IS
    generic(message_length : integer   := 24;
            pwm_bit        : integer   := 21;
            address_length : integer   := 2);
    port (                 
      -- general signals
      reset_n                         : in  std_logic;
      clk                             : in  std_logic;
      -- SPI interface
      sclk                            : in  std_logic;
      cs_n                            : in  std_logic;
      din                             : in  std_logic;
      -- Analog connections
      TERMINAL Out1, Out2, GROUND, VM, VCC : ELECTRICAL);
END motorcontroller;

ARCHITECTURE struct OF motorcontroller IS

-- student work

BEGIN

-- student work


END struct;



