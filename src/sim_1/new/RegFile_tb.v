`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2018 05:41:37 PM
// Design Name: 
// Module Name: RegFile_tb
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


module RegFile_tb;
    
    //IO variables
    reg clk, write_en;
    reg [3:0]sel0;
    reg [3:0]sel1;
    reg [3:0]insr;
    reg [3:0]write_address;
    reg [15:0]data_in;
    reg [15:0]PC;
    reg [15:0]out0;
    reg [15:0]out1;
    reg [15:0]outvalue;
    
    //Register file set up
    RegFile rfile(
        .clk(clk),
        .sel0(sel0),
        .sel1(sel1),
        .insr(insr),
        .data_in(data_in),
        .write_address(write_address),
        .write_en(write_en),
        .PC(PC),
        .out0(out0),
        .out1(out1),
        .outvalue(outvalue));
    
    //Clock set up
    initial begin
        clk = 0;
        write_en = 0;
    end
    always #5 clk = !clk;
    
    //Loop variable    
    integer i;
    
    initial begin
        //Check PC initialization 
        sel0 = 15;
        sel1 = 15;
        insr = 15;
        #10;
        
        //Single write
        write_address = 1;
        data_in = 2;
        write_en = 1;
        #10;
        
        //Read back
        sel0 = 1;
        #10;
        
        //Doesn't write when enable is low
        write_en = 0;
        data_in = 4;
        #10;
        
        //Write all
        write_en = 1;
        for (i = 0; i < 16; i = i + 1) begin
            write_address = i;
            data_in = i;
            #10;
        end
        
        //Read all
        write_en = 0;
        for (i = 0; i < 16; i = i + 1) begin
            sel0 = i;
            #10;
        end
        
        //Reverse write
        for (i = 15; i > -1; i = i - 1) begin
            write_address = i;
            data_in = 15 - i;
            #10;
        end
        
        //Reverse read
        for (i = 15; i > -1; i = i - 1) begin
            sel0 = i;
            #10;
        end
        
        $finish;
    end

    
    
    
endmodule
