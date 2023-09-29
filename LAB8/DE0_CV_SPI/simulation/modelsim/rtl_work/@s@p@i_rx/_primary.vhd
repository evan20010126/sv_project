library verilog;
use verilog.vl_types.all;
entity SPI_rx is
    port(
        address         : out    vl_logic_vector(7 downto 0);
        data            : out    vl_logic_vector(15 downto 0);
        read_en         : out    vl_logic;
        write_en        : out    vl_logic;
        tx_req          : out    vl_logic;
        mosi            : in     vl_logic;
        sclk            : in     vl_logic;
        ssn             : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic
    );
end SPI_rx;
