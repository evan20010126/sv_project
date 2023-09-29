library verilog;
use verilog.vl_types.all;
entity edge_detector_pos is
    port(
        rst             : in     vl_logic;
        clk             : in     vl_logic;
        enc_filter      : in     vl_logic;
        enc_pos         : out    vl_logic
    );
end edge_detector_pos;
