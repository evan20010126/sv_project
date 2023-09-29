library verilog;
use verilog.vl_types.all;
entity Encoder is
    port(
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        enc             : in     vl_logic
    );
end Encoder;
