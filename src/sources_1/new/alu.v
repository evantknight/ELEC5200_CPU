`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/19/2018 01:17:21 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input clk,
    input [2:0]opcode,
    input [15:0]in0,
    input [15:0]in1,
    output reg [15:0]out,
    output reg [1:0]status
    );
    
    //Opcodes
    localparam AND = 3'b000;
    localparam OR  = 3'b001;
    localparam XOR = 3'b010;
    localparam ADD = 3'b011;
    localparam SUB = 3'b100;
    
    always @(*) begin
        case (opcode)
            AND: out = in0 & in1; //AND
            OR:  out = in0 | in1; //OR
            XOR: out = in0 ^ in1; //XOR
            ADD: out = in0 + in1; //ADD
            SUB: out = in0 - in1; //SUB
            default: out = 16'hxxxx; //Error: Unknown opcode
        endcase
        if (out[15] == 1'b1) status = 2'b10;
        else if (out == 16'h0) status = 2'b01;
        else status = 0;
    end
endmodule
