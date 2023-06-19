
entity ORGATE is
  
  port (
    A   : in  bit;
    B   : in  bit;
    RES : out bit);

end entity ORGATE;

architecture RTL of ORGATE is

begin  -- ARCHITECTURE RTL
  RES <= A or B;
end architecture RTL;
