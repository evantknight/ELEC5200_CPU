`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2018 04:16:15 PM
// Design Name: 
// Module Name: ThreeOneMux_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ThreeOneMux_tb;

reg [3:0]in0_t;
reg [3:0]in1_t;
reg [3:0]in2_t;
reg [1:0]select_t;
wire [3:0]out_t;

ThreeOneMux #(.size(4))
    mux(
    .in0(in0_t),
    .in1(in1_t),
    .in2(in2_t),
    .select(select_t),
    .out(out_t));
    
initial begin
    in0_t = 4'b0011;
    in1_t = 4'b1100;
    in2_t = 4'b1010;
    select_t = 0;
    #10;
    select_t = 1;
    #10;
    select_t = 2;
    #10;
    in0_t = 4'b1111;
    in1_t = 4'b0000;
    in2_t = 4'b0101;
    #10;
    select_t = 0;
    #10;
    select_t = 1;
    #10;
    $finish;
end

endmodule
