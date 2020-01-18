`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2018 04:31:40 PM
// Design Name: 
// Module Name: register_tb
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


module register_tb;

    reg clk_t, we_t;
    reg [3:0]data_in_t;
    wire [3:0]data_out_t;
    
    register #(4) 
        reg_t (
        .clk(clk_t), 
        .data_in(data_in_t), 
        .data_out(data_out_t), 
        .write_enable(we_t));
    
    
    initial begin
        clk_t = 0;
    end
    
    always #5 clk_t = !clk_t;
    
    initial begin
        //Make sure it doesn't write when enable is low
        data_in_t = 1;
        we_t = 0;
        #10;
        
        //Writes while enable is high
        we_t = 1;
        #10;
        data_in_t = 4'hF;
        #10;
        
        //Goes back to not writing when enable is low
        we_t = 0;
        #10;
        data_in_t = 4'b0110;
        #10;
        data_in_t = 4'b1001;
        #10;
        $finish;
        
    end

endmodule
