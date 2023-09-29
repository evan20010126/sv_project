library verilog;
use verilog.vl_types.all;
entity gen_step_col is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        cnt_meas_rdy    : in     vl_logic;
        cnt_meas        : in     vl_logic_vector(15 downto 0);
        r_distance      : in     vl_logic_vector(13 downto 0);
        step_col        : out    vl_logic
    );
end gen_step_col;
