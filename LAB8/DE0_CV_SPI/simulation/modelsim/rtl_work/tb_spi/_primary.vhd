library verilog;
use verilog.vl_types.all;
entity tb_spi is
    generic(
        WRITE           : integer := 0;
        READ            : integer := 1;
        DIGITS          : integer := 16;
        SPI_T           : integer := 50
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WRITE : constant is 1;
    attribute mti_svvh_generic_type of READ : constant is 1;
    attribute mti_svvh_generic_type of DIGITS : constant is 1;
    attribute mti_svvh_generic_type of SPI_T : constant is 1;
end tb_spi;
