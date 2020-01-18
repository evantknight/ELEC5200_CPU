`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2018 03:31:39 PM
// Design Name: 
// Module Name: SignExt_tb
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


module SignExt_tb;

reg [1:0]in_t;
wire [3:0]out_t;

SignExt #(.IN_SIZE(2), .OUT_SIZE(4))
    SE(.in(in_t), .out(out_t));
    
initial begin
    in_t = 2'b01;
    #10;
    in_t = 2'b10;
    #10;
    $finish;
end

endmodule
