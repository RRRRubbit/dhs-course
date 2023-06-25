-- Model for TI DRV8837 motor driver (Calliope)
---- Chenxi Sun 768218-----------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.ELECTRICAL_SYSTEMS.ALL;
use IEEE.std_logic_1164.all;
use ieee.math_real.all;

ENTITY motor_driver_E IS
  GENERIC(
    idealityfactor:real:=1.1;
    thermalvotage:real:=0.025;
    saturationcurrent:real:=1.0e-9
    resistance_on:=0.01;    
    resistance_off:=10.0e6;
  );

  PORT (
    TERMINAL Out1, Out2, GROUND, VM, VCC : ELECTRICAL;
    SIGNAL IN1, IN2, nSLEEP : in std_logic);

END motor_driver_E;

-- ARCHITECTURE to be filled by the students
architecture behavior of motor_driver_E is 

component  sw_resistor_E IS
  
  GENERIC (
       -- change entity to switchable resistor
    resistance_on:=0.01;    
    resistance_off:=10.0e6;
  );
  PORT (
    TERMINAL a,b : ELECTRICAL;--analog
    signal d: in std_logic--digital
    );

END component sw_resistor_E;

component diode_E IS
  GENERIC(
    idealityfactor:real:=1.1;
    thermalvotage:real:=0.025;
    saturationcurrent:real:=1.0e-9
  );

  PORT (
    TERMINAL anode, cathode : ELECTRICAL);

END component diode_E;

signal sw_1, sw_2, sw_3, sw_4 :std_logic;

begin
-- out1
  s1 : sw_resistor_E
  generic map(
    resistance_on => resistance_on,
    resistance_off => resistance_off);
  port map(
    a => VM,
    b => Out1,
    d => sw_1
  );
  s2 : sw_resistor_E
  generic map(
    resistance_on => resistance_on,
    resistance_off => resistance_off);
  port map(
    a => Out1,
    b => GROUND,
    d => sw_2
  );
  d1 : diode_E
  generic map(
    saturationcurrent => saturationcurrent,
    thermalvotage => thermalvotage,
    idealityfactor => idealityfactor
  );
  port map(
    anode => Out1, 
    cathode => VM
  );
  d2 : diode_E
  generic map(
    saturationcurrent => saturationcurrent,
    thermalvotage => thermalvotage,
    idealityfactor => idealityfactor
  );
  port map(
    anode => GROUND, 
    cathode => Out1
  );
  -- out2
  s3 : sw_resistor_E
  generic map(
    resistance_on => resistance_on,
    resistance_off => resistance_off);
  port map(
    a => VM,
    b => Out2,
    d => sw_3
  );
  s4 : sw_resistor_E
  generic map(
    resistance_on => resistance_on,
    resistance_off => resistance_off);
  port map(
    a => Out2,
    b => GROUND,
    d => sw_4
  );
  d3 : diode_E
  generic map(
    saturationcurrent => saturationcurrent,
    thermalvotage => thermalvotage,
    idealityfactor => idealityfactor
  );
  port map(
    anode => Out2, 
    cathode => VM
  );
  d4 : diode_E
  generic map(
    saturationcurrent => saturationcurrent,
    thermalvotage => thermalvotage,
    idealityfactor => idealityfactor
  );
  port map(
    anode => GROUND, 
    cathode => Out2
  );

--digital sw to rotat
digital : process (IN1, IN2, nSLEEP)
begin
  if nSLEEP = '1' then
--Drive motor 1
    if IN1 = '1' and IN2 = '0' then
    sw_1 <= '1';
    sw_2 <= '0';
    sw_3 <= '0';
    sw_4 <= '1';
--Drive motor 2
    elsif IN1 = '0' and IN2 = '1' then
    sw_1 <= '0';
    sw_2 <= '1';
    sw_3 <= '1';
    sw_4 <= '0';
--brake
    elsif IN1 = '1' and IN2 = '1' then
    sw_1 <= '0';
    sw_2 <= '1';
    sw_3 <= '0';
    sw_4 <= '1';
--coast
    elsif IN1 = '0' and IN2 = '0' then
    sw_1 <= '0';
    sw_2 <= '0';
    sw_3 <= '0';
    sw_4 <= '0';
--coast
    else  
    sw_1 <= '0';
    sw_2 <= '0';
    sw_3 <= '0';
    sw_4 <= '0';
    end if;
  else
  sw_1 <= '0';
  sw_2 <= '0';
  sw_3 <= '0';
  sw_4 <= '0';
  end if;
end process;
end architecture behavior;