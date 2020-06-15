--------------------------------------------------------------------------------
--! @file alu_andor.vhd
--! @brief 8-bit ALU (S1A1)
--! @author Bruno Albertini (balbertini@usp.br)
--! @date 20200605
--------------------------------------------------------------------------------
entity alu is
  port (
    A, B : in  bit_vector(3 downto 0); -- inputs
    F    : out bit_vector(3 downto 0); -- output
    S    : in  bit_vector(2 downto 0); -- op selection
    Z    : out bit; -- zero flag
    Ov   : out bit; -- overflow flag
    Co   : out bit -- carry out
    );
end entity alu;
-------------------------------------------------------
architecture structural of alu is
begin
  -- MUX that select the output
  with S select F <=
    a and b when "000", -- AND
    a or  b when "001", -- OR
    "0000"  when others;
end architecture structural;
