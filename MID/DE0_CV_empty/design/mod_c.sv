module mod_c (
    output logic [2:0] crosswalk_light,
    output logic [2:0] road_light,
    output logic ok,
    input logic clk,
    input logic reset,
    input logic trg_c

    );

logic [9:0] ps, ns;

always_comb
begin
    if (ps == 40) ns = 0;
    else ns = ps + 1;
end

always_ff @(posedge clk) 
begin
    if (reset) begin
        ps <= 0; //idle
    end else begin
        ps <= ns;
    end
end
	
	
always_comb
	begin
        case (ps)
            0: begin
                road_light = 3'b0;
                crosswalk_light = 3'b0;
            end
            1,2,3,4,5: begin
                road_light[0] = 0;
                road_light[1] = 0;
                road_light[2] = 1;
                crosswalk_light[0] = 1;
                crosswalk_light[1] = 0;
                crosswalk_light[2] = 0;
            end
            6,7,8,9,10: begin
                road_light[0] = 0;
                road_light[1] = 1;
                road_light[2] = 0;
                crosswalk_light[0] = 1;
                crosswalk_light[1] = 0;
                crosswalk_light[2] = 0;
            end
            11,12: begin
                road_light[0] = 1;
                road_light[1] = 0;
                road_light[2] = 0;
                crosswalk_light[0] = 1;
                crosswalk_light[1] = 0;
                crosswalk_light[2] = 0;
            end
            13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32: begin
                road_light[0] = 1;
                road_light[1] = 0;
                road_light[2] = 0;
                crosswalk_light[0] = 0;
                crosswalk_light[1] = 0;
                crosswalk_light[2] = 1;
            end
            33,34,35,36,37: begin
                road_light[0] = 1;
                road_light[1] = 0;
                road_light[2] = 0;
                crosswalk_light[0] = 0;
                crosswalk_light[1] = 1;
                crosswalk_light[2] = 0;
            end
            38,39: begin
                road_light[0] = 1;
                road_light[1] = 0;
                road_light[2] = 0;
                crosswalk_light[0] = 1;
                crosswalk_light[1] = 0;
                crosswalk_light[2] = 0;
            end
            40: begin
                ok = 1;
            end
            default: begin 
            end
        endcase
	end
	
endmodule