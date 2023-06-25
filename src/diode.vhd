LIBRARY IEEE;
USE IEEE.ELECTRICAL_SYSTEMS.ALL;

ENTITY diode_E IS
  GENERIC(
    idealityfactor:real:=1.1;
    thermalvotage:real:=0.025;
    saturationcurrent:real:=1.0e-9
  );

  PORT (
    TERMINAL anode, cathode : ELECTRICAL);

END diode_E;

-- Architecture to be added by the students
architecture struct of diode_E is
  quantity u_d across i_d through anode to cathode;
begin 
  i_d == saturationcurrent*(exp(u_d/(idealityfactor*thermalvotage))-1.0);

end architecture struct;