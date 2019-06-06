--------------------------------------------------------------------------------
--! @file   rom.vhd
--! @brief  Parametrisable Sync RAM memory
--! @author Bruno Albertini (balbertini@usp.br)
--! @date   20190606
--------------------------------------------------------------------------------
library ieee;
use ieee.numeric_bit.all;

entity ram is
  generic(
    address_size : natural := 64;
    word_size    : natural := 32
  );
  port(
    ck, wr : in  bit;
    addr   : in  bit_vector(address_size-1 downto 0);
    data_i : in  bit_vector(word_size-1 downto 0);
    data_o : out bit_vector(word_size-1 downto 0)
  );
end ram;

architecture vendorfree of ram is
  constant depth : natural := 2**address_size;
  type mem_type is array (0 to depth-1) of bit_vector(word_size-1 downto 0);
  signal mem : mem_type;
begin
  wrt: process(ck)
  begin
    if (ck='1' and ck'event) then
      if (wr='1') then
        mem(to_integer(unsigned(addr))) <= data_i;
      end if;
    end if;
  end process;
  data_o <= mem(to_integer(unsigned(addr)));
end vendorfree;
