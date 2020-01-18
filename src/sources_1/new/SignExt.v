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


module SignExt(
    in,
    out
    );
    
    //Parameters for size of input and output
    parameter IN_SIZE = 8;
    parameter OUT_SIZE = 16;
    
    //Declare input and output
    input [IN_SIZE-1:0]in;
    output [OUT_SIZE-1:0]out;
    
    //Sign extend input and assign to output
    assign out = {{(OUT_SIZE - IN_SIZE){in[IN_SIZE-1]}}, in};
    
endmodule
