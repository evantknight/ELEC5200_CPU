`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2018 10:41:41 PM
// Design Name: 
// Module Name: memory
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


module memory(
    input clk,
    input [15:0]address,
    input [15:0]data_in,
    input write_en,
    output [15:0]data_out
    );
    
    //1K words, 16 bits each
    reg[15:0] ram [999:0];
    
    //Data out always = address_in
    assign data_out = ram[address];
    
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
    
    //Initialize ram contents with program
    initial begin
        //Program arguments
        ram[0] = 16'd6; //arg0 = 6
        ram[1] = 16'd3; //arg1 = 3
        ram[2] = 16'd0; //argv[2] = 0
        
        //Instructions from assembly program
        ram[16'h100] <= {MOV, 4'd2, 8'd0};
        ram[16'h101] <= {LD, 4'd0, 4'd0, 4'd2};
        ram[16'h102] <= {MOV, 4'd2, 8'd1};
        ram[16'h103] <= {LD, 4'd0, 4'd1, 4'd2};
        ram[16'h104] <= {MVR,4'd0,4'd14,4'd15};
        ram[16'h105] <= {B,12'd13};
        ram[16'h106] <= {MOV, 4'd2, 8'd2};
        ram[16'h107] <= {STR, 4'd0, 4'd2, 4'd0};
        ram[16'h108] <= {MOV, 4'd0, 8'd1};
        ram[16'h109] <= {LD, 4'd0, 4'd1, 4'd2};
        ram[16'h10A] <= {ADD,4'd1,4'd0,4'd1};
        ram[16'h10B] <= {STR, 4'd0, 4'd2, 4'd1};
        ram[16'h10C] <= {MOV, 4'd1, 8'd3};
        ram[16'h10D] <= {CMP,4'd0,4'd1,4'd0};
        ram[16'h10E] <= {BLT,12'd2};
        ram[16'h10F] <= {SUB,4'd1,4'd1,4'd0};
        ram[16'h110] <= {B,-12'd4};
        ram[16'h111] <= {MOV, 4'd0, 8'd0};
        ram[16'h112] <= {HALT,12'd0};
        ram[16'h113] <= {CMP,4'd0,4'd0,4'd1};
        ram[16'h114] <= {BLT, 12'd4};
        ram[16'h115] <= {BGT, 12'd2};
        ram[16'h116] <= {MOV, 4'd0, 8'd0};
        ram[16'h117] <= {B,12'd1};
        ram[16'h118] <= {MVR,4'd0,4'd0,4'd1};
        ram[16'h119] <= {MOV, 4'd1, 8'd1};
        ram[16'h11A] <= {ADD,4'd14,4'd14,4'd1};
        ram[16'h11B] <= {MVR,4'd0,4'd15,4'd14};
        
    end
    
    //Set word @ address if write enabled
    always @(posedge clk) begin
        if (write_en)
            ram[address] <= data_in;
    end
    
endmodule
