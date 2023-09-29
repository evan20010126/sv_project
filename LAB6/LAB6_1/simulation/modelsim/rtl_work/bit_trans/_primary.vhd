library verilog;
use verilog.vl_types.all;
entity bit_trans is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        r_LPF_threshold : in     vl_logic;
        rx              : in     vl_logic;
        tx              : in     vl_logic;
        rx_finish       : out    vl_logic;
        shift_register  : out    vl_logic_vector(7 downto 0)
    );
end bit_trans;
