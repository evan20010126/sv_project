library verilog;
use verilog.vl_types.all;
entity SPI is
    port(
        miso            : out    vl_logic;
        data_debug      : out    vl_logic_vector(15 downto 0);
        mosi            : in     vl_logic;
        sclk            : in     vl_logic;
        ssn             : in     vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic
    );
end SPI;
