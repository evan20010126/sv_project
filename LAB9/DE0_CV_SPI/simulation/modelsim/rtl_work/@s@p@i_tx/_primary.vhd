library verilog;
use verilog.vl_types.all;
entity SPI_tx is
    port(
        miso            : out    vl_logic;
        ack             : out    vl_logic;
        prepare_data    : in     vl_logic_vector(15 downto 0);
        sclk_palse      : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        req             : in     vl_logic
    );
end SPI_tx;
