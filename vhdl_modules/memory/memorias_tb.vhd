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
  component ram is
    generic(
      address_size : natural;
      word_size    : natural
    );
    port(
      ck, wr : in  bit;
      addr   : in  bit_vector(address_size-1 downto 0);
      data_i : in  bit_vector(word_size-1 downto 0);
      data_o : out bit_vector(word_size-1 downto 0)
    );
  end component;
  -- sinais de suporte
  signal a5: bit_vector(4 downto 0);
  signal d4a, d4b, d4ci, d4co, d4d: bit_vector(3 downto 0);
  signal stopc, clk, wr: bit := '0';
  -- Periodo do clock
  constant periodo : time := 10 ns;
begin
  -- Geração de clock
  clk <= stopc and (not clk) after periodo/2;
  -- Instâncias a serem testada
  dutA: entity work.rom32x4(literais)   port map(a5,d4a);
  dutB: entity work.rom32x4(de_arquivo) port map(a5,d4b);
  dutC: ram generic map(5,4) port map(clk,wr,a5,d4ci,d4co);
  dutD: rom generic map(5,4,"rom32x4.dat") port map(a5,d4d);
  -- Estímulos
  stim: process
    variable addr_tmp: bit_vector(4 downto 0);
  begin
    stopc <= '1';
    wr <='0';
    --! Escrevendo um padrão na RAM
    for i in 0 to 31 loop
      addr_tmp := bit_vector(to_unsigned(i,5));
      d4ci <= addr_tmp(3 downto 0);
      a5 <= addr_tmp;
      wr<='1';
      wait until rising_edge(clk);
      wr<='0';
    end loop;
    --! Lendo todas as memórias
    for i in 0 to 31 loop
      a5 <= bit_vector(to_unsigned(i,5));
      wait for 1 ns;
      assert d4a = a5(3 downto 0)
        report "ROM1 mem("&to_bstring(a5)&")="&to_bstring(d4a);
      assert d4b = a5(3 downto 0)
        report "ROM2 mem("&to_bstring(a5)&")="&to_bstring(d4b);
      assert d4co = a5(3 downto 0)
        report "RAM mem("&to_bstring(a5)&")="&to_bstring(d4co);
      assert d4d = a5(3 downto 0)
        report "ROM3 mem("&to_bstring(a5)&")="&to_bstring(d4d);
    end loop;
    stopc <= '0';
    wait;
  end process;
end architecture;
