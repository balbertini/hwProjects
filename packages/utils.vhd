--------------------------------------------------------------------------------
--! @file utils.vhd
--! @brief Package for bit and bit_vector printing
--! @author Bruno Albertini (balbertini@usp.br)
--! @date 20191023
--------------------------------------------------------------------------------
-- Usage:
-- Include the package on your design:
-- library work;
-- And declare the functions that you are goinf to use (ou .all):
-- use work.utils.to_bstring;
-- After that use to convert to string. Example (test is a bit_vector):
-- report "This is the test string: " & to_bstring(test);

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;
use std.textio.all;

package utils is
  -- Based on Morten Zilmer answer on stackoverflow
  -- https://stackoverflow.com/questions/24329155/is-there-a-way-to-print-the-values-of-a-signal-to-a-file-from-a-modelsim-simulat
  function to_bstring(b : bit) return string;
  function to_bstring(bv : bit_vector) return string;
  -- https://stackoverflow.com/questions/26575986/vhdl-coding-conversion-from-integer-to-bit-vector
  -- Support comparison functions
  function equal(a,b: std_logic_vector) return boolean;
  function equalSignedBitvector(a: signed; b: bit_vector) return boolean;
end utils;

package body utils is
  function to_bstring(b : bit) return string is
  variable b_str_v : string(1 to 3);  -- bit image with quotes around
  begin
    b_str_v := bit'image(b);
    return "" & b_str_v(2);  -- "" & character to get string
  end function;

  function to_bstring(bv : bit_vector) return string is
    alias    bv_norm : bit_vector(1 to bv'length) is bv;
    variable b_str_v : string(1 to 1);  -- String of bit
    variable res_v    : string(1 to bv'length);
  begin
    for idx in bv_norm'range loop
      b_str_v := to_bstring(bv_norm(idx));
      res_v(idx) := b_str_v(1);
    end loop;
    return res_v;
  end function;

  function equal(a,b: std_logic_vector) return boolean is
  begin
    if a'length = b'length then
      for idx in 0 to a'length-1 loop
        if a(idx) /= b(idx) then
          return false;
        end if;
      end loop;
      return true;
    else
      return false;
    end if;
  end function;

  function equalSignedBitvector(a: signed; b: bit_vector) return boolean is
  begin
    if a'length = b'length then
      for idx in 0 to a'length-1 loop
        if a(idx) /= b(idx) then
          return false;
        end if;
      end loop;
      return true;
    else
      return false;
    end if;
  end function;

end utils;
