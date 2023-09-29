library verilog;
use verilog.vl_types.all;
entity pll_0002 is
    port(
        refclk          : in     vl_logic;
        rst             : in     vl_logic;
        outclk_0        : out    vl_logic;
        locked          : out    vl_logic
    );
end pll_0002;
