--LIBRARY ieee;
--USE ieee.std_logic_1164.ALL;

-------------------------------------------------------------------------------

entity FULLADDER_tb is

end entity FULLADDER_tb;

architecture TEST_PR of FULLADDER_tb is

  signal A_S        : bit;
  signal B_S        : bit;
  signal CARRY_IN_S : bit;
  signal SUM_S      : bit;
  signal CARRY_S    : bit;
  component FULLADDER is
    port (
      A        : in  bit;
      B        : in  bit;
      CARRY_IN : in  bit;
      SUM      : out bit;
      CARRY    : out bit);
  end component FULLADDER;
begin  -- ARCHITECTURE TEST_PR

  DUT : FULLADDER
    port map (
      A        => A_S,
      B        => B_S,
      CARRY_IN => CARRY_IN_S,
      SUM      => SUM_S,
      CARRY    => CARRY_S);



  stimulus : process
  begin
    A_S        <= '0'; B_S <= '0'; CARRY_IN_S <= '0';
    wait for 10 ms;
    CARRY_IN_S <= '1';
    wait for 10 ms;
    B_S        <= '1'; CARRY_IN_S <= '0';
    wait for 10 ms;
    CARRY_IN_S <= '1';
    wait for 10 ms;
    A_S        <= '1'; B_S <= '0'; CARRY_IN_S <= '0';
    wait for 10 ms;
    CARRY_IN_S <= '1';
    wait for 10 ms;
    B_S        <= '1'; CARRY_IN_S <= '0';
    wait for 10 ms;
    A_S        <= '1'; CARRY_IN_S <= '1';
    wait;
  end process stimulus;
end architecture TEST_PR;

-------------------------------------------------------------------------------

configuration CFG_FULLADDER_TB of FULLADDER_tb is
  for TEST_PR
  end for;
end configuration CFG_FULLADDER_TB;




