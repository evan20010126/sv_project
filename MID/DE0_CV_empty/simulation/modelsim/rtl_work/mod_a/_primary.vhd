library verilog;
use verilog.vl_types.all;
entity mod_a is
    generic(
        T0              : integer := 0;
        T1              : integer := 1
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        trg_a           : in     vl_logic;
        count_a         : out    vl_logic_vector(3 downto 0);
        ok              : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of T0 : constant is 1;
    attribute mti_svvh_generic_type of T1 : constant is 1;
end mod_a;
