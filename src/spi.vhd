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

  --ADD SIGNALS


begin

--ADD PROCESSES FOR THE STATE MACHINE WHIC CONTROLS THE SPI, COUNTER FOR SPI
--AND OUTPUT REGISTERS

-- counter synchronous to SPI clock?


end architecture RTL;
