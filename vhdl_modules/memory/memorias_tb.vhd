-------------------------------------------------------
--! @file memorias.vhd
--! @brief TB para memorias em VHDL
--! @author Bruno Albertini (balbertini@usp.br)
--! @date 20190606
-------------------------------------------------------
library ieee;
use ieee.numeric_bit.all;
use work.utils.all;

entity memorias_tb is
end memorias_tb;

architecture testbench of memorias_tb is
  component  rom32x4 is
    port (
      addr : in  bit_vector(4 downto 0);
      data : out bit_vector(3 downto 0)
    );
  end component;
  component rom is
    generic(
      address_size   : natural := 64;
      word_size      : natural := 32;
      data_file_name : string  := "rom.dat"
    );
    port(
      addr : in  bit_vector(address_size-1 downto 0);
      data : out bit_vector(word_size-1 downto 0)
    );
  end component;

  -- sinais de suporte
  signal a5: bit_vector(4 downto 0);
  signal d4a, d4b: bit_vector(3 downto 0);
  -- signal stopc, clk, rst, done: bit := '0';
  -- Periodo do clock
  -- constant periodo : time := 1 ns;

begin
  -- Geração de clock
  -- clk <= stopc and (not clk) after periodo/2;

  -- Instância a ser testada
  dut1: entity work.rom32x4(literais)   port map(a5,d4a);
  dut2: entity work.rom32x4(de_arquivo) port map(a5,d4b);

  -- Estímulos
  stim: process
  begin
    -- stopc <= '1';

    for i in 0 to 31 loop
      a5 <= bit_vector(to_unsigned(i,5));
      wait for 1 ns;
      assert d4a = a5(3 downto 0)
        report "ROM1 mem("&to_bstring(a5)&")="&to_bstring(d4a);
      assert d4b = a5(3 downto 0)
        report "ROM2 mem("&to_bstring(a5)&")="&to_bstring(d4b);
    end loop;

    -- stopc <= '0';

    wait;
  end process;
end architecture;
