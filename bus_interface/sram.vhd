library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

entity SRAM is
  generic (
    kAddressLength : positive := 20;
    kDataLength : positive := 32
          );
  port (
    SramClk  : in std_logic;

    sAddress : in  unsigned ( kAddressLength - 1 downto 0 );
    sDataIn  : in  std_logic_vector ( kDataLength - 1 downto 0 );
    sDataOut : out std_logic_vector ( kDataLength - 1 downto 0 );

    sWrite   : in  boolean
       );
end entity SRAM;

architecture RTL of SRAM is

  subtype Word_t is std_logic_vector ( sDataIn'range );

  type WordArray_t is array ( natural range<> ) of Word_t;

  signal sMemory : WordArray_t ( 0 to ( 2**sAddress'length ) -1 );

begin

  MemoryWrite:
  Process ( SramClk ) is
  begin
    if rising_edge ( SramClk ) then
      if sWrite then
        sMemory ( to_integer ( sAddress ) ) <= sDataIn;
      end if;
    end if;
  end Process MemoryWrite;

  MemoryIndex:
  Process ( SramClk ) is
  begin
    if rising_edge ( SramClk ) then
      sDataOut <= sMemory ( to_integer ( sAddress ) );
    end if;
  end process MemoryIndex;

end RTL;
