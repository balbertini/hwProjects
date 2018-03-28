library ieee;
use ieee.std_logic_1164.all;

entity hpstut is
	port(
		clock_50: in std_logic;
		sw: in std_logic_vector(9 downto 0);
		ledr: out std_logic_vector(9 downto 0);
		-- HPS
		HPS_CONV_USB_N:INOUT STD_LOGIC;
		HPS_DDR3_ADDR:OUT STD_LOGIC_VECTOR(14 downto 0);
		HPS_DDR3_BA: OUT STD_LOGIC_VECTOR(2 downto 0);
		HPS_DDR3_CAS_N: OUT STD_LOGIC;
		HPS_DDR3_CKE:OUT STD_LOGIC;
		HPS_DDR3_CK_N: OUT STD_LOGIC;
		HPS_DDR3_CK_P: OUT STD_LOGIC;
		HPS_DDR3_CS_N: OUT STD_LOGIC;
		HPS_DDR3_DM: OUT STD_LOGIC_VECTOR(3 downto 0);
		HPS_DDR3_DQ: INOUT STD_LOGIC_VECTOR(31 downto 0);
		HPS_DDR3_DQS_N: INOUT STD_LOGIC_VECTOR(3 downto 0);
		HPS_DDR3_DQS_P: INOUT STD_LOGIC_VECTOR(3 downto 0);
		HPS_DDR3_ODT: OUT STD_LOGIC;
		HPS_DDR3_RAS_N: OUT STD_LOGIC;
		HPS_DDR3_RESET_N: OUT  STD_LOGIC;
		HPS_DDR3_RZQ: IN  STD_LOGIC;
		HPS_DDR3_WE_N: OUT STD_LOGIC;
		HPS_ENET_GTX_CLK: OUT STD_LOGIC;
		HPS_ENET_INT_N:INOUT STD_LOGIC;
		HPS_ENET_MDC:OUT STD_LOGIC;
		HPS_ENET_MDIO:INOUT STD_LOGIC;
		HPS_ENET_RX_CLK: IN STD_LOGIC;
		HPS_ENET_RX_DATA: IN STD_LOGIC_VECTOR(3 downto 0);
		HPS_ENET_RX_DV: IN STD_LOGIC;
		HPS_ENET_TX_DATA: OUT STD_LOGIC_VECTOR(3 downto 0);
		HPS_ENET_TX_EN: OUT STD_LOGIC;
		HPS_KEY: INOUT STD_LOGIC;
		HPS_SD_CLK: OUT STD_LOGIC;
		HPS_SD_CMD: INOUT STD_LOGIC;
		HPS_SD_DATA: INOUT STD_LOGIC_VECTOR(3 downto 0);
		HPS_UART_RX: IN   STD_LOGIC;
		HPS_UART_TX: OUT STD_LOGIC;
		HPS_USB_CLKOUT: IN STD_LOGIC;
		HPS_USB_DATA:INOUT STD_LOGIC_VECTOR(7 downto 0);
		HPS_USB_DIR: IN STD_LOGIC;
		HPS_USB_NXT: IN STD_LOGIC;
		HPS_USB_STP: OUT STD_LOGIC
	);
end hpstut;

architecture estrutural of hpstut is
	component testeHps is
		port (
			chaves_external_connection_export : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- export
			clk_clk                           : in    std_logic                     := 'X';             -- clk
			hps_0_h2f_reset_reset_n           : out   std_logic;                                        -- reset_n
			hps_io_hps_io_emac1_inst_TX_CLK   : out   std_logic;                                        -- hps_io_emac1_inst_TX_CLK
			hps_io_hps_io_emac1_inst_TXD0     : out   std_logic;                                        -- hps_io_emac1_inst_TXD0
			hps_io_hps_io_emac1_inst_TXD1     : out   std_logic;                                        -- hps_io_emac1_inst_TXD1
			hps_io_hps_io_emac1_inst_TXD2     : out   std_logic;                                        -- hps_io_emac1_inst_TXD2
			hps_io_hps_io_emac1_inst_TXD3     : out   std_logic;                                        -- hps_io_emac1_inst_TXD3
			hps_io_hps_io_emac1_inst_RXD0     : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD0
			hps_io_hps_io_emac1_inst_MDIO     : inout std_logic                     := 'X';             -- hps_io_emac1_inst_MDIO
			hps_io_hps_io_emac1_inst_MDC      : out   std_logic;                                        -- hps_io_emac1_inst_MDC
			hps_io_hps_io_emac1_inst_RX_CTL   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CTL
			hps_io_hps_io_emac1_inst_TX_CTL   : out   std_logic;                                        -- hps_io_emac1_inst_TX_CTL
			hps_io_hps_io_emac1_inst_RX_CLK   : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RX_CLK
			hps_io_hps_io_emac1_inst_RXD1     : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD1
			hps_io_hps_io_emac1_inst_RXD2     : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD2
			hps_io_hps_io_emac1_inst_RXD3     : in    std_logic                     := 'X';             -- hps_io_emac1_inst_RXD3
			hps_io_hps_io_sdio_inst_CMD       : inout std_logic                     := 'X';             -- hps_io_sdio_inst_CMD
			hps_io_hps_io_sdio_inst_D0        : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D0
			hps_io_hps_io_sdio_inst_D1        : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D1
			hps_io_hps_io_sdio_inst_CLK       : out   std_logic;                                        -- hps_io_sdio_inst_CLK
			hps_io_hps_io_sdio_inst_D2        : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D2
			hps_io_hps_io_sdio_inst_D3        : inout std_logic                     := 'X';             -- hps_io_sdio_inst_D3
			hps_io_hps_io_usb1_inst_D0        : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D0
			hps_io_hps_io_usb1_inst_D1        : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D1
			hps_io_hps_io_usb1_inst_D2        : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D2
			hps_io_hps_io_usb1_inst_D3        : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D3
			hps_io_hps_io_usb1_inst_D4        : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D4
			hps_io_hps_io_usb1_inst_D5        : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D5
			hps_io_hps_io_usb1_inst_D6        : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D6
			hps_io_hps_io_usb1_inst_D7        : inout std_logic                     := 'X';             -- hps_io_usb1_inst_D7
			hps_io_hps_io_usb1_inst_CLK       : in    std_logic                     := 'X';             -- hps_io_usb1_inst_CLK
			hps_io_hps_io_usb1_inst_STP       : out   std_logic;                                        -- hps_io_usb1_inst_STP
			hps_io_hps_io_usb1_inst_DIR       : in    std_logic                     := 'X';             -- hps_io_usb1_inst_DIR
			hps_io_hps_io_usb1_inst_NXT       : in    std_logic                     := 'X';             -- hps_io_usb1_inst_NXT
			hps_io_hps_io_uart0_inst_RX       : in    std_logic                     := 'X';             -- hps_io_uart0_inst_RX
			hps_io_hps_io_uart0_inst_TX       : out   std_logic;                                        -- hps_io_uart0_inst_TX
			leds_external_connection_export   : out   std_logic_vector(9 downto 0);                     -- export
			memory_mem_a                      : out   std_logic_vector(14 downto 0);                    -- mem_a
			memory_mem_ba                     : out   std_logic_vector(2 downto 0);                     -- mem_ba
			memory_mem_ck                     : out   std_logic;                                        -- mem_ck
			memory_mem_ck_n                   : out   std_logic;                                        -- mem_ck_n
			memory_mem_cke                    : out   std_logic;                                        -- mem_cke
			memory_mem_cs_n                   : out   std_logic;                                        -- mem_cs_n
			memory_mem_ras_n                  : out   std_logic;                                        -- mem_ras_n
			memory_mem_cas_n                  : out   std_logic;                                        -- mem_cas_n
			memory_mem_we_n                   : out   std_logic;                                        -- mem_we_n
			memory_mem_reset_n                : out   std_logic;                                        -- mem_reset_n
			memory_mem_dq                     : inout std_logic_vector(31 downto 0) := (others => 'X'); -- mem_dq
			memory_mem_dqs                    : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs
			memory_mem_dqs_n                  : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- mem_dqs_n
			memory_mem_odt                    : out   std_logic;                                        -- mem_odt
			memory_mem_dm                     : out   std_logic_vector(3 downto 0);                     -- mem_dm
			memory_oct_rzqin                  : in    std_logic                     := 'X';             -- oct_rzqin
			reset_reset_n                     : in    std_logic                     := 'X'              -- reset_n
		);
	end component testeHps;
	SIGNAL HPS_H2F_RST:STD_LOGIC;
begin
u0 : component testeHps
		port map (
			chaves_external_connection_export => sw, -- chaves_external_connection.export
			clk_clk                           => clock_50,                           --                        clk.clk
			hps_0_h2f_reset_reset_n           => HPS_H2F_RST,           --            hps_0_h2f_reset.reset_n
			hps_io_hps_io_emac1_inst_TX_CLK   => hps_ENET_GTX_CLK,   --                     hps_io.hps_io_emac1_inst_TX_CLK
			hps_io_hps_io_emac1_inst_TXD0     => hps_ENET_TX_DATA(0),     --                           .hps_io_emac1_inst_TXD0
			hps_io_hps_io_emac1_inst_TXD1     => hps_ENET_TX_DATA(1),     --                           .hps_io_emac1_inst_TXD1
			hps_io_hps_io_emac1_inst_TXD2     => hps_ENET_TX_DATA(2),     --                           .hps_io_emac1_inst_TXD2
			hps_io_hps_io_emac1_inst_TXD3     => hps_ENET_TX_DATA(3),     --                           .hps_io_emac1_inst_TXD3
			hps_io_hps_io_emac1_inst_RXD0     => hps_ENET_RX_DATA(0),     --                           .hps_io_emac1_inst_RXD0
			hps_io_hps_io_emac1_inst_MDIO     => hps_ENET_MDIO,     --                           .hps_io_emac1_inst_MDIO
			hps_io_hps_io_emac1_inst_MDC      => hps_ENET_MDC,      --                           .hps_io_emac1_inst_MDC
			hps_io_hps_io_emac1_inst_RX_CTL   => hps_ENET_RX_DV,   --                           .hps_io_emac1_inst_RX_CTL
			hps_io_hps_io_emac1_inst_TX_CTL   => hps_ENET_TX_EN,   --                           .hps_io_emac1_inst_TX_CTL
			hps_io_hps_io_emac1_inst_RX_CLK   => hps_ENET_RX_CLK,   --                           .hps_io_emac1_inst_RX_CLK
			hps_io_hps_io_emac1_inst_RXD1     => hps_ENET_RX_DATA(1),     --                           .hps_io_emac1_inst_RXD1
			hps_io_hps_io_emac1_inst_RXD2     => hps_ENET_RX_DATA(2),     --                           .hps_io_emac1_inst_RXD2
			hps_io_hps_io_emac1_inst_RXD3     => hps_ENET_RX_DATA(3),     --                           .hps_io_emac1_inst_RXD3
			hps_io_hps_io_sdio_inst_CMD       => hps_SD_CMD,       --                           .hps_io_sdio_inst_CMD
			hps_io_hps_io_sdio_inst_D0        => hps_SD_DATA(0),        --                           .hps_io_sdio_inst_D0
			hps_io_hps_io_sdio_inst_D1        => hps_SD_DATA(1),        --                           .hps_io_sdio_inst_D1
			hps_io_hps_io_sdio_inst_CLK       => hps_SD_CLK,       --                           .hps_io_sdio_inst_CLK
			hps_io_hps_io_sdio_inst_D2        => hps_SD_DATA(2),        --                           .hps_io_sdio_inst_D2
			hps_io_hps_io_sdio_inst_D3        => hps_SD_DATA(3),        --                           .hps_io_sdio_inst_D3
			hps_io_hps_io_usb1_inst_D0        => hps_USB_DATA(0),        --                           .hps_io_usb1_inst_D0
			hps_io_hps_io_usb1_inst_D1        => hps_USB_DATA(1),        --                           .hps_io_usb1_inst_D1
			hps_io_hps_io_usb1_inst_D2        => hps_USB_DATA(2),        --                           .hps_io_usb1_inst_D2
			hps_io_hps_io_usb1_inst_D3        => hps_USB_DATA(3),        --                           .hps_io_usb1_inst_D3
			hps_io_hps_io_usb1_inst_D4        => hps_USB_DATA(4),        --                           .hps_io_usb1_inst_D4
			hps_io_hps_io_usb1_inst_D5        => hps_USB_DATA(5),        --                           .hps_io_usb1_inst_D5
			hps_io_hps_io_usb1_inst_D6        => hps_USB_DATA(6),        --                           .hps_io_usb1_inst_D6
			hps_io_hps_io_usb1_inst_D7        => hps_USB_DATA(7),        --                           .hps_io_usb1_inst_D7
			hps_io_hps_io_usb1_inst_CLK       => hps_USB_CLKOUT,       --                           .hps_io_usb1_inst_CLK
			hps_io_hps_io_usb1_inst_STP       => hps_USB_STP,       --                           .hps_io_usb1_inst_STP
			hps_io_hps_io_usb1_inst_DIR       => hps_USB_DIR,       --                           .hps_io_usb1_inst_DIR
			hps_io_hps_io_usb1_inst_NXT       => hps_USB_NXT,       --                           .hps_io_usb1_inst_NXT
			hps_io_hps_io_uart0_inst_RX       => hps_UART_RX,       --                           .hps_io_uart0_inst_RX
			hps_io_hps_io_uart0_inst_TX       => hps_UART_TX,       --                           .hps_io_uart0_inst_TX
			leds_external_connection_export   => ledr,   --   leds_external_connection.export
			memory_mem_a                      => hps_DDR3_ADDR,                      --                     memory.mem_a
			memory_mem_ba                     => hps_DDR3_BA,                     --                           .mem_ba
			memory_mem_ck                     => hps_DDR3_CK_P,                     --                           .mem_ck
			memory_mem_ck_n                   => hps_DDR3_CK_N,                   --                           .mem_ck_n
			memory_mem_cke                    => hps_DDR3_CKE,                    --                           .mem_cke
			memory_mem_cs_n                   => hps_DDR3_CS_N,                   --                           .mem_cs_n
			memory_mem_ras_n                  => hps_DDR3_RAS_N,                  --                           .mem_ras_n
			memory_mem_cas_n                  => hps_DDR3_CAS_N,                  --                           .mem_cas_n
			memory_mem_we_n                   => hps_DDR3_WE_N,                   --                           .mem_we_n
			memory_mem_reset_n                => hps_DDR3_RESET_N,                --                           .mem_reset_n
			memory_mem_dq                     => hps_DDR3_DQ,                     --                           .mem_dq
			memory_mem_dqs                    => hps_DDR3_DQS_P,                    --                           .mem_dqs
			memory_mem_dqs_n                  => hps_DDR3_DQS_N,                  --                           .mem_dqs_n
			memory_mem_odt                    => hps_DDR3_ODT,                    --                           .mem_odt
			memory_mem_dm                     => hps_DDR3_DM,                     --                           .mem_dm
			memory_oct_rzqin                  => hps_DDR3_RZQ,                  --                           .oct_rzqin
			reset_reset_n                     => '1'                      --                      reset.reset_n
		);
end estrutural;