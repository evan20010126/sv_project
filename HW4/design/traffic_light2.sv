`timescale 1ns/100ps
module traffic_light2 (
    input clk,
    input reset,
    output logic [1:0]R,
    output logic [1:0]Y,
    output logic [1:0]G,
    output logic [3:0]count
);

logic [1:0] ps,ns;
logic [3:0] a;
assign count = a;

always_ff @(posedge clk)
begin
    if(reset) a<=#1 0;
    else a<=#1 a+1;
end

always_ff @(posedge clk)
// next state
begin
    if(reset) ps<=#1 0;
    else ps <= #1 ns;
end

parameter T0 = 0;
parameter T1 = 1;
parameter T2 = 2; 
parameter T3 = 3;

always_comb 
begin
    ns = 0; //next state
    
    case(ps)
        T0: 
        begin
            R[0] = 1;
            R[1] = 0;
            G[0] = 0;
            G[1] = 1;
            Y[0] = 0;
            Y[1] = 0;
            if (a==5) ns = T1;
            else ns = T0;
        end
        T1:
        begin
            R[0] = 1;
            R[1] = 0;
            G[0] = 0;
            G[1] = 0;
            Y[0] = 0;
            Y[1] = 1;
            if (a==7) ns = T2;
            else ns = T1;
        end
        T2:
        begin
            R[0] = 0;
            R[1] = 1;
            G[0] = 1;
            G[1] = 0;
            Y[0] = 0;
            Y[1] = 0;
            if (a==13) ns = T3;
            else ns = T2;
        end
        T3:
        begin
            R[0] = 0;
            R[1] = 1;
            G[0] = 0;
            G[1] = 0;
            Y[0] = 1;
            Y[1] = 0;
            if (a==15) ns = T0;
            else ns = T3;
        end
    endcase
end
    
endmodule

