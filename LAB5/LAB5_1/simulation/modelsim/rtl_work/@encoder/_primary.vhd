library verilog;
use verilog.vl_types.all;
entity Encoder is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        r_LPF_threshold : in     vl_logic_vector(13 downto 0);
        r_distance      : in     vl_logic_vector(13 downto 0);
        enc             : in     vl_logic;
        step_col        : out    vl_logic
    );
end Encoder;
