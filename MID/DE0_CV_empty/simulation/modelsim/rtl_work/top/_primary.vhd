library verilog;
use verilog.vl_types.all;
entity top is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic;
        c               : in     vl_logic;
        count_a         : out    vl_logic_vector(3 downto 0);
        crosswalk_light : out    vl_logic_vector(2 downto 0);
        road_light      : out    vl_logic_vector(2 downto 0)
    );
end top;
