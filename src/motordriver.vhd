-- Model for TI DRV8837 motor driver (Calliope)

LIBRARY IEEE;
USE IEEE.ELECTRICAL_SYSTEMS.ALL;
use IEEE.std_logic_1164.all;
use ieee.math_real.all;

ENTITY motor_driver_E IS
  PORT (
    TERMINAL Out1, Out2, GROUND, VM, VCC : ELECTRICAL;
    SIGNAL IN1, IN2, nSLEEP : in std_logic);

END motor_driver_E;

-- ARCHITECTURE to be filled by the students
