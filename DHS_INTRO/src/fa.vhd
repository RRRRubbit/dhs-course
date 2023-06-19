LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY FULLADDER IS
  
  PORT (
    A         : IN  bit;
    B         : IN  bit;
    CARRY_IN  : IN  bit;
    SUM       : OUT bit;
    CARRY : OUT bit);

END ENTITY FULLADDER;

ARCHITECTURE STRUCT OF FULLADDER IS

  SIGNAL W_SUM_HA1              : bit;
  SIGNAL W_CARRY_HA1, W_CARRY_HA2 : bit;

  COMPONENT HALFADDER
    PORT (A, B : IN  bit;
          SUM, CARRY   : OUT bit);
  END COMPONENT;

  COMPONENT ORGATE
    PORT (A, B : IN  bit;
          RES     : OUT bit);
  END COMPONENT;

BEGIN  -- ARCHITECTURE STRUCT


  HA1 : HALFADDER
    PORT MAP(A => A,
             B => B,
             SUM   => W_SUM_HA1,
             CARRY => W_CARRY_HA1);

  HA2 : HALFADDER
    PORT MAP(A => W_SUM_HA1,
             B => CARRY_IN,
             SUM   => SUM,
             CARRY => W_CARRY_HA2);

  MODULE_OR : ORGATE
    PORT MAP (A   => W_CARRY_HA2,
              B   => W_CARRY_HA1,
              RES => CARRY);

END ARCHITECTURE STRUCT;
