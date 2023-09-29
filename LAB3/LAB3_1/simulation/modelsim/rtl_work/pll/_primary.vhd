library verilog;
use verilog.vl_types.all;
entity pll is
    port(
        refclk          : in     vl_logic;
        rst             : in     vl_logic;
        outclk_0        : out    vl_logic;
        outclk_1        : out    vl_logic;
        locked          : out    vl_logic
    );
end pll;
