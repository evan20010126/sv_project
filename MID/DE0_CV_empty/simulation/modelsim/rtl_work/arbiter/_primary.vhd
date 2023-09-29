library verilog;
use verilog.vl_types.all;
entity arbiter is
    generic(
        STATE_IDLE      : integer := 0;
        STATE_A         : integer := 1;
        STLL            : integer := 4;
        STLL1           : integer := 5;
        STATE_B         : integer := 2;
        STATE_C         : integer := 3
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        a               : in     vl_logic;
        b               : in     vl_logic;
        c               : in     vl_logic;
        trg_a           : out    vl_logic;
        trg_b           : out    vl_logic;
        trg_c           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of STATE_IDLE : constant is 1;
    attribute mti_svvh_generic_type of STATE_A : constant is 1;
    attribute mti_svvh_generic_type of STLL : constant is 1;
    attribute mti_svvh_generic_type of STLL1 : constant is 1;
    attribute mti_svvh_generic_type of STATE_B : constant is 1;
    attribute mti_svvh_generic_type of STATE_C : constant is 1;
end arbiter;
