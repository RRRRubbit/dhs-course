LIBRARY IEEE;
USE IEEE.ELECTRICAL_SYSTEMS.ALL;

ENTITY sw_resistor_E IS
  
  GENERIC (
       -- change entity to switchable resistor
    resistance_on:=0.01;    
    resistance_off:=10.0e6;
  );
  PORT (
    TERMINAL a,b : ELECTRICAL;--analog
    signal d: in std_logic--digital
    );

END sw_resistor_E;

ARCHITECTURE simple OF sw_resistor_E IS
  QUANTITY u_r ACROSS i_r THROUGH a TO b;
BEGIN  -- simple
  if d ='1' use
  i_r == u_r/resistance_on;
  else 
  i_r == u_r/resistance_off;
  end use; 
END simple;
