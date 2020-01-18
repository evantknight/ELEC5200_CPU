`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2018 11:24:51 AM
// Design Name: 
// Module Name: register
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


module register(
    reset,
    data_in,
    data_out,
    write_enable
    );
    
    //Size of register
    parameter SIZE = 16;
    
    //I/O declarations
    input reset;
    input [SIZE-1:0]data_in;
    input write_enable;
    output reg [SIZE-1:0]data_out;
    
    initial begin
        data_out = 0;
    end
    
    always @(*) begin
        if (reset) data_out = 0;
        else if (write_enable) data_out = data_in;
    end
endmodule
