`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2018 01:28:57 AM
// Design Name: 
// Module Name: CPU_tb
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


module CPU_tb;
    
    //Instruction opcodes
    localparam HALT = 4'h0;
    localparam AND  = 4'h1;
    localparam OR   = 4'h2;
    localparam XOR  = 4'h3;
    localparam ADD  = 4'h4;
    localparam SUB  = 4'h5;
    localparam LD   = 4'h6;
    localparam STR  = 4'h7;
    localparam MOV  = 4'h8;
    localparam MVR  = 4'h9;
    localparam CMP  = 4'hA;
    localparam B    = 4'hB;
    localparam BEQ  = 4'hC;
    localparam BNE  = 4'hD;
    localparam BLT  = 4'hE;
    localparam BGT  = 4'hF;
    
    //IO
    reg clk;
    wire [15:0]outvalue;
    
    //CPU instantiation
    CPU cpu_t(
        .clk(clk),
        .reset(0),
        .inr(4'd0),
        .outvalue(outvalue));
        
        
    //Set up clock
    initial clk = 0;
    always #5 clk = !clk;
    
    //Testbench
    initial begin
        #1605;
        $finish;
    end
    


endmodule
