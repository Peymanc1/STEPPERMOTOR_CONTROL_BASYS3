library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity STEPPER_MOTOR is
Port (
   CLOCK       : in     STD_LOGIC ;
   DONDUR      : in  STD_LOGIC ;
   BOBIN       : out    STD_LOGIC_VECTOR (3 downto 0)
);
end STEPPER_MOTOR;

architecture Behavioral of STEPPER_MOTOR is
   signal counter    : unsigned (19 downto 0);
   signal counter_v  : unsigned (1 downto 0);
begin

process(CLOCK)
begin
   if rising_edge (CLOCK) then
      counter <= counter + 1;
   end if;
end process;

process(counter(17))
begin
   if rising_edge(counter(17)) then
      counter_v <= counter_v + 1;
   end if ; 
end process; 

process(counter_v, DONDUR)
begin
   if DONDUR = '1' then  --Dondur sw 1 ise ileri
      case (counter_v) is
      when "00" => BOBIN <="0011";
      when "01" => BOBIN <="1010";
      when "10" => BOBIN <="1100";
      when "11" => BOBIN <="0101";
      end case ;
   elsif DONDUR = '0' then --dondur sw0 ise geri
      case (counter_v) is
      when "11" => BOBIN <="0011";
      when "10" => BOBIN <="1010";
      when "01" => BOBIN <="1100";
      when "00" => BOBIN <="0101";
      end case ;
   end if ;
end process;


end Behavioral;