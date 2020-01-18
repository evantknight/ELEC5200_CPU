`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2018 11:39:42 PM
// Design Name: 
// Module Name: CPU
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


module CPU(
    input clk,
    input reset,
    input [3:0]inr,
    output [15:0]outvalue
    );
    
    //Signals--------------------------------------
    //Instsruction Register
    wire [15:0]ins;
    
    //FSM_CONTROL
    wire      status_we;
    wire [2:0]alu_op;
    wire      alu_in0;
    wire [1:0]alu_in1;
    wire      memory_write;
    wire [1:0]memory_addr;
    wire      ins_reg;
    wire [1:0]reg_data;
    wire [1:0]reg_addr;
    wire      regfile_write;
    
    //Register File
    wire [15:0] out0;
    wire [15:0] out1;
    wire [15:0] PC;
    
    //Reg_data sign extension
    wire [15:0] reg_data_sign_ext_out;
    
    //Reg_data mux
    wire [15:0] reg_data_out;
    
    //Reg_addr mux
    wire [15:0] reg_addr_out;
    
    //out0 reg
    wire [15:0] out0_reg_out;
    
    //out1 reg
    wire [15:0] out1_reg_out;
    
    //alu_in0 mux
    wire [15:0] alu_in0_out;
    
    //alu_in1 mux
    wire [15:0] alu_in1_out;
    
    //alu_in1 sign extension
    wire [15:0] alu_in1_signext_out;
    
    //ALU
    wire [15:0] alu_out;
    wire [1:0]  alu_status_out;
    
    //ALU Out Reg
    wire [15:0] alu_out_reg_out;
    
    //Status Register
    wire [1:0] status_reg_out;
    
    //Memory
    wire [15:0]read_data_bus;
    wire [15:0]address_bus;
    
    
    //END Signals----------------------------------------
    
    //Components-----------------------------------------
    FSM_Control control(
        .clk(clk),
        .opcode(ins[15:12]),
        .status(status_reg_out),
        .status_we(status_we),
        .alu_op(alu_op),
        .alu_in0(alu_in0),
        .alu_in1(alu_in1),
        .memory_write(memory_write),
        .memory_addr(memory_addr),
        .ins_reg(ins_reg),
        .reg_data(reg_data),
        .reg_addr(reg_addr),
        .regfile_write(regfile_write));
        
    ALU alu(
        .clk(clk), 
        .opcode(alu_op), 
        .in0(alu_in0_out), 
        .in1(alu_in1_out), 
        .out(alu_out), 
        .status(alu_status_out));
    
    RegFile regfile(
        .clk(clk),
        .sel0(ins[7:4]),
        .sel1(ins[3:0]),
        .inr(inr),
        .data_in(reg_data_out),
        .write_address(reg_addr_out),
        .write_en(regfile_write),
        .PC(PC),
        .out0(out0),
        .out1(out1),
        .outvalue(outvalue));
        
    register #(2) status_reg(
        .reset(reset), 
        .data_in(alu_status_out), 
        .data_out(status_reg_out), 
        .write_enable(status_we));
    
    register #(16) ins_register(
        .reset(reset), 
        .data_in(read_data_bus), 
        .data_out(ins), 
        .write_enable(ins_reg));
        
    FourOneMux #(16) reg_data_mux(
        .in0(reg_data_sign_ext_out),
        .in1(read_data_bus),
        .in2(alu_out_reg_out),
        .in3(out1_reg_out),
        .select(reg_data),
        .out(reg_data_out)); 
        
    ThreeOneMux #(4) reg_addr_mux(
        .in0(ins[11:8]),
        .in1(ins[7:4]),
        .in2(15),
        .select(reg_addr),
        .out(reg_addr_out));
        
    register #(16) out0_reg(
        .reset(reset),
        .data_in(out0),
        .data_out(out0_reg_out),
        .write_enable(1));
        
    register #(16) out1_reg(
        .reset(reset),
        .data_in(out1),
        .data_out(out1_reg_out),
        .write_enable(1));
        
    ThreeOneMux #(16) mem_addr_mux(
        .in0(PC),
        .in1(out0_reg_out),
        .in2(out1_reg_out),
        .select(memory_addr),
        .out(address_bus));
        
    SignExt #(8,16) reg_data_signext(
        .in(ins[7:0]),
        .out(reg_data_sign_ext_out));
        
    SignExt #(12,16) alu_in1_signext(
        .in(ins[11:0]),
        .out(alu_in1_signext_out));
        
    TwoOneMux #(16) alu_in0_mux(
        .in0(out0_reg_out),
        .in1(PC),
        .select(alu_in0),
        .out(alu_in0_out));
        
    ThreeOneMux #(16) alu_in1_mux(
        .in0(out1_reg_out),
        .in1(alu_in1_signext_out),
        .in2(1),
        .select(alu_in1),
        .out(alu_in1_out));
        
    register #(16) alu_out_reg(
        .reset(reset),
        .data_in(alu_out),
        .data_out(alu_out_reg_out),
        .write_enable(1));
        
    memory mem(
        .clk(clk),
        .address(address_bus),
        .data_in(out1_reg_out),
        .write_en(memory_write),
        .data_out(read_data_bus));
        
    //END Components-------------------------------------
    
endmodule
