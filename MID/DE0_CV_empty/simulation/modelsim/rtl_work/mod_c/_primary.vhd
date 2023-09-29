library verilog;
use verilog.vl_types.all;
entity mod_c is
    port(
        crosswalk_light : out    vl_logic_vector(2 downto 0);
        road_light      : out    vl_logic_vector(2 downto 0);
        ok              : out    vl_logic;
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        trg_c           : in     vl_logic
    );
end mod_c;
