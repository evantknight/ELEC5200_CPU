`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2018 04:48:02 PM
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb;
    
    //Opcodes
    localparam AND = 3'b000;
    localparam OR  = 3'b001;
    localparam XOR = 3'b010;
    localparam ADD = 3'b011;
    localparam SUB = 3'b100;
    
    //IO
    reg clk;
    reg [2:0]opcode;
    reg [15:0]in0;
    reg [15:0]in1;
    wire [15:0]out;
    wire [1:0]status;
    
    //ALU instantiation
    ALU alu_t(.clk(clk), .opcode(opcode), .in0(in0), .in1(in1), .out(out), .status(status));
    
    //Set up clock
    initial clk = 0;
    always #5 clk = !clk;
    
    //Tests
    initial begin
        //Check AND
        opcode = AND;
        in0 = 'b1111;
        in1 = 'b0110;
        #10;
                
        //Check OR
        opcode = OR;
        in0 = 'b1000;
        in1 = 'b0001;
        #10;
        
        //Check XOR
        opcode = XOR;
        in0 = 'b1100;
        in1 = 'b0110;
        #10;
        
        //Check ADD
        opcode = ADD;
        in0 = 'b1010;
        in1 = 'b0011;
        #10;
        
        //ADD overflow
        in0 = 16'hFFFF;
        in1 = 2;
        #10;
        
        //Check SUB
        opcode = SUB;
        in0 = 'b1100;
        in1 = 'b1010;
        #10;
        
        //SUB underflow
        in0 = 0;
        in1 = 2;
        #10;
        
        //Check status
        //Zero
        in0 = 5;
        in1 = 5;
        #10;
        
        //Negative
        opcode = ADD;
        in0 = 16'hFFFE;
        in1 = 0;
        #10;
        
        //Check unknown op
        opcode = 7;
        #10;
        
        $finish;
    end
    

endmodule
