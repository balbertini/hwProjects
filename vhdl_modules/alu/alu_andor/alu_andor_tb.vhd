--------------------------------------------------------------------------------
--! @file alu_andor_tb.vhd
--! @brief Testbench for 8-bit ALU (S1A1)
--! @author Bruno Albertini (balbertini@usp.br)
--! @date 20200605
--------------------------------------------------------------------------------
-- WARNING: This testbench does NOT test all possible cases. Change it to add
--          more cases if you want.

entity alu_andor_tb is
end entity alu_andor_tb;

architecture dut of alu_andor_tb is
  component  alu is
    port (
      A, B : in  bit_vector(3 downto 0); -- inputs
      F    : out bit_vector(3 downto 0); -- output
      S    : in  bit_vector(2 downto 0); -- op selection
      Z    : out bit; -- zero flag
      Ov   : out bit; -- overflow flag
      Co   : out bit -- carry out
      );
  end component;
  signal A, B, F: bit_vector(3 downto 0) := (others=>'0');
  signal S: bit_vector(2 downto 0) := (others=>'0');
  signal Ze, Ov, Co: bit;
begin
  -- in1, in2, out, selection, flags (zero, overflow, carry-out)
  dut: alu port map (A, B, F, S, Ze, Ov, Co);

  stim: process is
  begin

    report "BOT";

    -- Testing AND
    S <= "000";
    A <= "0000"; B <= "1111";
    wait for 1 ns;
    assert F = "0000" report "Error on A&B.";
    A <= "1111"; B <= "0000";
    wait for 1 ns;
    assert F = "0000" report "Error on A&B.";
    A <= "0110"; B <= "1001";
    wait for 1 ns;
    assert F = "0000" report "Error on A&B.";

    -- Testing OR
    S <= "001";
    A <= "0000"; B <= "1111";
    wait for 1 ns;
    assert F = "1111" report "Error on A|B.";
    A <= "1111"; B <= "0000";
    wait for 1 ns;
    assert F = "1111" report "Error on A|B.";
    A <= "0110"; B <= "1001";
    wait for 1 ns;
    assert F = "1111" report "Error on A|B.";

    report "EOT";
    wait;
  end process;
end dut;
