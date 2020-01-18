`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2018 07:07:48 PM
// Design Name: 
// Module Name: FSM_Control_tb
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


module FSM_Control_tb;
            
    //States
    localparam FETCH_0   = 4'h0;
    localparam FETCH_1   = 4'h1;
    localparam DECODE_0  = 4'h2;
    localparam HALT_0    = 4'h3;
    localparam REG_0     = 4'h4;
    localparam REG_1     = 4'h5;
    localparam LD_0      = 4'h6;
    localparam LD_1      = 4'h7;
    localparam STR_0     = 4'h8;
    localparam MOV_0     = 4'h9;
    localparam MVR_0     = 4'hA;
    localparam BRANCH_0  = 4'hB;
    localparam BRANCH_1  = 4'hC;
    
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
    
    //ALU Opcodes
    localparam ALU_AND = 3'b000;
    localparam ALU_OR  = 3'b001;
    localparam ALU_XOR = 3'b010;
    localparam ALU_ADD = 3'b011;
    localparam ALU_SUB = 3'b100;
    
    //Status bits indexes
    localparam ZERO = 1;
    localparam NEG  = 0;
    
    //ALU in0 select
    localparam ALU_IN0_OUT0 = 0;
    localparam ALU_IN0_PC   = 1;
    
    //ALU in1 select
    localparam ALU_IN1_OUT1 = 2'b00;
    localparam ALU_IN1_INS  = 2'b01;
    localparam ALU_IN1_1    = 2'b10;
    
    //Register file data input select
    localparam REG_DATA_IMM  = 2'b00;
    localparam REG_DATA_MEM  = 2'b01;
    localparam REG_DATA_ALU  = 2'b10;
    localparam REG_DATA_OUT1 = 2'b11;
    
    //Register file address select
    localparam REG_ADDR_D  = 2'b00;
    localparam REG_ADDR_S1 = 2'b01;
    localparam REG_ADDR_PC = 2'b10;
    
    //Memory address select
    localparam MEM_ADDR_PC   = 2'b00;
    localparam MEM_ADDR_OUT0 = 2'b01;
    localparam MEM_ADDR_OUT1 = 2'b10;
    
    //Testing variable
    reg[3:0] state;
    
    //FSM_Control
    reg clk;
    reg [3:0] opcode;
    reg [1:0] status;
    
    //ALU
    wire status_we;
    wire [2:0] alu_op;
    wire alu_in0;
    wire [1:0] alu_in1;
    
    //Memory
    wire memory_write;
    wire [1:0]memory_addr;
    wire ins_reg;
    
    //Register file
    wire [1:0]reg_data;
    wire [1:0]reg_addr;
    wire regfile_write;
    
    //Module initialization
    FSM_Control control(
        .state(state),
        .clk(clk),
        .opcode(opcode),
        .status(status),
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
        
    //Clock set up
    initial clk = 0;
    always #5 clk = !clk;
    
    initial begin
        //Check initialization
        #10;
        
        //Register Instruction
        opcode = AND;
        #50
        //Load instruction
        opcode = LD;
        #50;
        
        //Store instruction
        opcode = STR;
        #40;
        
        //Move instruction
        opcode = MOV;
        #40;
        
        //Move register instruction
        opcode = MVR;
        #40;
        
        //Branch---------------------
        opcode = BEQ;
        //Status bits incorrect
        status = 'b00;
        #30;
        
        //Status bits correct
        status = 'b10;
        #50;
        
        //Halt
        opcode = HALT;
        #30;
        $finish;
        
    end
    
            
        
    

endmodule
