library verilog;
use verilog.vl_types.all;
entity Low_Pass_Filter_4ENC is
    generic(
        N               : integer := 13
    );
    port(
        sig_filter      : out    vl_logic;
        \signal\        : in     vl_logic;
        r_LPF_threshold_enc: in     vl_logic_vector(13 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end Low_Pass_Filter_4ENC;
