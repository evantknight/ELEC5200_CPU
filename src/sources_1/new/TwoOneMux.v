`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2018 02:49:12 PM
// Design Name: 
// Module Name: ThreeOneMux
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


module TwoOneMux(
    in0,
    in1,
    select,
    out
    );
    
    parameter size = 16;
    
    input [size-1:0]in0;
    input [size-1:0]in1;
    input select;
    output [size-1:0]out;
    
    assign out = (select == 0) ? in0 :
    (select == 1) ? in1 :
    'hx;
endmodule
