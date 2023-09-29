library verilog;
use verilog.vl_types.all;
entity handshaking is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        c1              : out    vl_logic_vector(3 downto 0);
        c2              : out    vl_logic_vector(3 downto 0)
    );
end handshaking;
