--------------------------------------------------------------------------------
--! @file   rom.vhd
--! @brief  Parametrisable ROM memory
--! @author Bruno Albertini (balbertini@usp.br)
--! @date   20190606
--------------------------------------------------------------------------------
library ieee;
use ieee.numeric_bit.ALL;
use std.textio.all;

entity rom is
  generic(
    address_size   : natural := 64; --! Size of address bus
    word_size      : natural := 32; --! Size of each word
    data_file_name : string  := "rom.dat" --! File with initial data
  );
  port(
    addr : in  bit_vector(address_size-1 downto 0);
    data : out bit_vector(word_size-1 downto 0)
  );
end rom;

architecture vendorfree of rom is
  constant depth : natural := 2**address_size;
  type mem_type is array (0 to depth-1) of bit_vector(word_size-1 downto 0);
  --! Initial values filling function
  impure function init_mem(file_name : in string) return mem_type is
    file     f       : text open read_mode is file_name;
    variable l       : line;
    variable tmp_bv  : bit_vector(word_size-1 downto 0);
    variable tmp_mem : mem_type;
  begin
    for i in mem_type'range loop
      readline(f, l);
      read(l, tmp_bv);
      tmp_mem(i) := tmp_bv;
    end loop;
    return tmp_mem;
  end;
  --! Memory matrix
  constant mem : mem_type := init_mem(data_file_name);
begin
  data <= mem(to_integer(unsigned(addr)));
end vendorfree;
