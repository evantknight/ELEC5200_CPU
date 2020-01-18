`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2018 05:38:54 AM
// Design Name: 
// Module Name: FSM_Control
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


module FSM_Control(
    //Testing Output (Commented when not testing)
    //output reg[3:0] state,
    
    //FSM_control-----------
    input clk,
    input [3:0]opcode,
    input [1:0]status,
    input reset,
    //Control signals
    //ALU--------------------
    output reg      status_we,
    output reg [2:0]alu_op,
    output reg      alu_in0,
    output reg [1:0]alu_in1,
    //Memory---------------------
    output reg      memory_write,
    output reg [1:0]memory_addr,
    output reg      ins_reg,
    //Register File--------------
    output reg [1:0]reg_data,
    output reg [1:0]reg_addr,
    output reg      regfile_write
    );
    
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
    localparam ZERO = 0;
    localparam NEG  = 1;
    
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
    
    
    //State variable (Commented when testing)
    reg[3:0] state;
    
    //Initialize by performing first fetch
    initial begin
        //Set next state to second phase of fetch
        state = FETCH_1;
        
        //Clear write enables
        memory_write  = 0;
        regfile_write = 0;
        status_we     = 0;
        
        //Fetch instruction from memory
        memory_addr = MEM_ADDR_PC;
        ins_reg     = 1;
        
        //Increment PC
        alu_in0 = ALU_IN0_PC;
        alu_in1 = ALU_IN1_1;
        alu_op  = ALU_ADD;
        
        #50; //Wait for all components to finish initialization 
    end
    
    
    always @(posedge clk) begin
        if (reset) begin
            //Set next state to second phase of fetch
            state = FETCH_1;
            
            //Clear write enables
            memory_write  = 0;
            regfile_write = 0;
            status_we     = 0;
            
            //Fetch instruction from memory
            memory_addr = MEM_ADDR_PC;
            ins_reg     = 1;
            
            //Increment PC
            alu_in0 = ALU_IN0_PC;
            alu_in1 = ALU_IN1_1;
            alu_op  = ALU_ADD;
        end
        else begin
            case (state)
                //Fetch-------------------------------------------
                FETCH_0: begin
                    //Reset write signals
                    memory_write  = 0;
                    regfile_write = 0;
                    
                    //Set next state
                    state         = FETCH_1;
                    
                    //Load instruction
                    memory_addr   = MEM_ADDR_PC;
                    ins_reg       = 1;
                    
                    //Increment PC
                    alu_in0       = ALU_IN0_PC;
                    alu_in1       = ALU_IN1_1;
                    alu_op        = ALU_ADD;
                    
                    //Disable Status write
                    status_we = 0;
                end
                FETCH_1: begin
                
                    //Set next state
                    state   = DECODE_0;
                    
                    //Disable instruction saving
                    ins_reg = 0;
                    
                    //Store new PC
                    reg_data = REG_DATA_ALU;
                    reg_addr = REG_ADDR_PC;
                    regfile_write = 1;
                end
                //-------------------------------------------------
                
                //Decode---------------------------------------------------------
                DECODE_0: begin
                    //Reset write signal
                    regfile_write = 0;
                    
                    //Set next state------------------------------
                    //Check if reg instruction
                    if ((opcode >= AND && opcode <= SUB) || opcode == CMP) state = REG_0;
                    else begin
                        case (opcode)
                            HALT: state = HALT_0;
                            LD:   state = LD_0;
                            STR:  state = STR_0;
                            MOV:  state = MOV_0;
                            MVR:  state = MVR_0;
                            B:    state = BRANCH_0;
                            
                            //Branch opcodes-----------------------------------
                            //Status bits are checked for correctness before
                            //entering branch state. If incorrect, goes to next instruction
                            BEQ: state = (status[ZERO] == 0) ?  FETCH_0 : BRANCH_0;
                            BNE: state = (status[ZERO] == 0) ? BRANCH_0 : FETCH_0;
                            BLT: state = (status[NEG] == 0) ? FETCH_0 : BRANCH_0;
                            BGT: state = (status[NEG] == 0 && status[ZERO] == 0) ? BRANCH_0 : FETCH_0;
                            
                            //Bad opcode
                            default: state = 'hx;
                        endcase
                    end
                end
                //----------------------------------------------------------------
                
                //Halt state is an infinite loop
                HALT_0: state = HALT_0;
                
                //Register operation----------------------------------
                REG_0: begin
                    //If compare instruction, the next state is fetch as the
                    //ALU result is not written to the register file
                    state = (opcode == CMP) ? FETCH_0 : REG_1;
                    
                    //Set ALU parameters
                    alu_in0 = ALU_IN0_OUT0;
                    alu_in1 = ALU_IN1_OUT1;
                    status_we = 1; //Save status of ALU operation
                    
                    //Set ALU opcode
                    case (opcode)
                        AND: alu_op = ALU_AND;
                        OR:  alu_op = ALU_OR;
                        XOR: alu_op = ALU_XOR;
                        ADD: alu_op = ALU_ADD;
                        SUB: alu_op = ALU_SUB;
                        CMP: alu_op = ALU_SUB;
                    endcase
                end
                
                //Save output of ALU 
                REG_1: begin
                    state = FETCH_0;
                    status_we = 0;
                    reg_data = REG_DATA_ALU;
                    reg_addr = REG_ADDR_D;
                    regfile_write = 1;
                end
                //-----------------------------------------------------
                
                //Load instruction--------------------
                LD_0: begin //Tell memory to get data at address
                    state = LD_1;
                    memory_addr = MEM_ADDR_OUT1;
                end
                LD_1: begin //Store memory output
                    state = FETCH_0;
                    reg_data = REG_DATA_MEM;
                    reg_addr = REG_ADDR_S1;
                    regfile_write = 1;
                end
                //------------------------------------
                
                //Store instruction-----------------
                STR_0: begin
                    state = FETCH_0;
                    memory_addr = MEM_ADDR_OUT0;
                    memory_write = 1;
                end
                //----------------------------------
                
                //Move-immediate instruction--------
                MOV_0: begin
                    state = FETCH_0;
                    reg_data = REG_DATA_IMM;
                    reg_addr = REG_ADDR_D;
                    regfile_write = 1;
                end
                //----------------------------------
                
                //Move register instruction---------
                MVR_0: begin
                    state = FETCH_0;
                    reg_data = REG_DATA_OUT1;
                    reg_addr = REG_ADDR_S1;
                    regfile_write = 1;
                end
                //---------------------------------
                
                //Branch instruction---------------
                BRANCH_0: begin //Add offset to PC
                    state = BRANCH_1;
                    alu_in0 = ALU_IN0_PC;
                    alu_in1 = ALU_IN1_INS;
                    alu_op = ALU_ADD;
                end
                BRANCH_1: begin //Write new PC
                    state = FETCH_0;
                    reg_data = REG_DATA_ALU;
                    reg_addr = REG_ADDR_PC;
                    regfile_write = 1;
                end
                //--------------------------------
                
                //Unknown instruction
                default: state = 'hx;
            endcase
        end
    end
    
endmodule
