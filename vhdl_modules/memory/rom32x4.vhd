--------------------------------------------------------------------------------
--! @file   rom32x4.vhd
--! @brief  ROM memory, 32 words of 4 bits
--! @author Bruno Albertini (balbertini@usp.br)
--! @date 20190606
--------------------------------------------------------------------------------
library ieee;
use ieee.numeric_bit.ALL;
--! textio is needed to read files in VHDL
use std.textio.all;

entity rom32x4 is
  port (
    addr : in  bit_vector(4 downto 0);
    data : out bit_vector(3 downto 0)
  );
end rom32x4;

--! @brief   Arquitetura que usa um vetor de literais para inicialização.
--! @details Nesta abordagem, no momento da instanciacao da matriz modelando a memoria já especifica-se o valor que a memoria deve conter.
architecture literais of rom32x4 is
  type mem_t is array (0 to 31) of bit_vector(3 downto 0);
  --! Note que a matriz de memória é uma constante, indicando que o valor não será escrito (comportamento da ROM).
  constant mem : mem_t := (
    "0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111",
    "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111",
    "0000", "0001", "0010", "0011", "0100", "0101", "0110", "0111",
    "1000", "1001", "1010", "1011", "1100", "1101", "1110", "1111");
begin
  data <= mem(to_integer(unsigned(addr)));
end literais;

--! @brief   Arquitetura que usa inicializa a memória a partir de um arquivo externo.
--! @details Nesta abordagem, no momento da instanciacao da matriz modelando a memoria chamamos uma função para preenche-la com dados provenientes de um arquivo externo. O formato é uma palavra por linha, com 4 bits em texto.
architecture de_arquivo of rom32x4 is
  type mem_t is array (0 to 31) of bit_vector(3 downto 0);
  --! Funcao que le o arquivo e preenche uma matriz temporaria
  --! Entrada: string com o nome do arquivo
  --! Saida: matriz identica ao mem_t, preenchida com os valores do arquivo
  impure function inicializa(nome_do_arquivo : in string) return mem_t is
    file     arquivo  : text open read_mode is nome_do_arquivo;
    variable linha    : line;
    variable temp_bv  : bit_vector(3 downto 0);
    variable temp_mem : mem_t;
    begin
      --! Itera sobre o tamanho do tipo de dados (profundidade da matriz)
      for i in mem_t'range loop
        --! Le uma linha inteira do arquivo e coloca em "linha"
        readline(arquivo, linha);
        --! Interpreta a linha com um unico bit_vector e coloca em "temp_bv"
        read(linha, temp_bv);
        --! Atribui o valor lido para a matriz
        temp_mem(i) := temp_bv;
      end loop;
      return temp_mem;
    end;
  --! Delaracao da matriz de memoria em si, note que foi chamada a funcao para preenche-la.  
  constant mem : mem_t := inicializa("rom32x4.dat");
begin
  data <= mem(to_integer(unsigned(addr)));
end de_arquivo;
