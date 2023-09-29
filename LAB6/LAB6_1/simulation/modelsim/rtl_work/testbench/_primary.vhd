library verilog;
use verilog.vl_types.all;
entity testbench is
    generic(
        BAUD_CNT_MAX_9600: integer := 5208;
        BAUD_CNT_MAX_19200: integer := 2604;
        BAUD_CNT_MAX_38400: integer := 1302
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BAUD_CNT_MAX_9600 : constant is 1;
    attribute mti_svvh_generic_type of BAUD_CNT_MAX_19200 : constant is 1;
    attribute mti_svvh_generic_type of BAUD_CNT_MAX_38400 : constant is 1;
end testbench;
