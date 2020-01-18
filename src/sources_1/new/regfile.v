`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2018 02:13:44 PM
// Design Name: 
// Module Name: RegFile
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


module RegFile(
    input reset,
    input clk,
    input [3:0] sel0,
    input [3:0] sel1,
    input [3:0] inr,
    input [15:0] data_in,
    input [3:0] write_address,
    input write_en,
    output [15:0] PC,
    output reg [15:0] out0,
    output reg [15:0] out1,
    output [15:0] outvalue
    );
    
    reg [15:0] registers [0:15]; //16 16-bit registers
    assign PC = registers[15]; //Set PC output
    assign outvalue = registers[inr];
    
    initial begin
        registers[15] = 16'h0100; //Set PC to starting address
    end
    
    always @(posedge clk) begin
        if (reset) registers[15] = 16'h0100;
        else begin
            //Output selected registers
            out0 <= registers[sel0];
            out1 <= registers[sel1];
            
            //Write if necessary
            if (write_en == 1)
                registers[write_address] = data_in;
        end
    end
endmodule
