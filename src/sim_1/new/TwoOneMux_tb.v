`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2018 03:47:14 PM
// Design Name: 
// Module Name: TwoOneMux_tb
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


module TwoOneMux_tb;

reg [3:0]in0_t;
reg [3:0]in1_t;
reg select_t;
wire [3:0]out_t;

TwoOneMux #(.size(4))
    mux(
    .in0(in0_t),
    .in1(in1_t),
    .select(select_t),
    .out(out_t));
    
initial begin
    in0_t = 4'b0101;
    in1_t = 4'b1010;
    select_t = 0;
    #10;
    select_t = 1;
    #10;
    in0_t = 4'b1111;
    in1_t = 4'b0000;
    #10;
    select_t = 0;
    #10;
    $finish;
end
    
    


endmodule
