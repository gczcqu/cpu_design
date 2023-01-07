`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/23 15:27:24
// Design Name: 
// Module Name: aludec
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
`include "defines2.vh"

module aludec(
	input wire[5:0] funct,
	input wire[3:0] aluop,
	output reg[4:0] alucontrol
    );
	always @(*) begin
		case (aluop)
		//alucontrol共五位，目前用至10（01010）
			//四条立即数逻辑运算指令
            `ANDI_OP:alucontrol <= `AND_CONTROL;//ANDi
			`LUI_OP:alucontrol <= `LUI_CONTROL;//LUI
			`ORI_OP:alucontrol <= `OR_CONTROL;//ORI
			`XORI_OP:alucontrol <= `XOR_CONTROL;//XORI
			//四条立即数算数运算指令
			`ADDI_OP:alucontrol <= `ADD_CONTROL;//ADDI
			`ADDIU_OP:alucontrol <= `ADDU_CONTROL;//ADDIU
			`SLTI_OP:alucontrol <= `SLT_CONTROL;//SLTI
			`SLTIU_OP:alucontrol <= `SLTU_CONTROL;//SLTIU
			// R-type指令
			`R_TYPE_OP : case (funct)
				//八条逻辑运算指令
				//前四条R-type指令
				`AND:alucontrol <= `AND_CONTROL; //AND
				`OR:alucontrol <= `OR_CONTROL; 	//OR
				`NOR:alucontrol <= `NOR_CONTROL; //NOR
				`XOR:alucontrol <= `XOR_CONTROL; //XOR

				//六条逻辑运算指令
				`SLLV:alucontrol <= `SLLV_CONTROL; //SLLV
				`SLL:alucontrol <= `SLL_CONTROL; //SLL
				`SRAV:alucontrol <= `SRAV_CONTROL; //SRAV
				`SRA:alucontrol <= `SRA_CONTROL; //SRA
				`SRLV:alucontrol <= `SRLV_CONTROL; //SRLV
				`SRL:alucontrol <= `SRL_CONTROL; //SRL

				//四条数据移动指令
				`MFHI:alucontrol <= `MFHI_CONTROL; //MFHI
				`MTHI:alucontrol <= `MTHI_CONTROL; //MTHI
				`MFLO:alucontrol <= `MFLO_CONTROL; //MFLO
				`MTLO:alucontrol <= `MTLO_CONTROL; //MTLO

				//14条算数指令(10条R-type类型)
				//1.6条基础的算数指令
				`ADD:alucontrol <= `ADD_CONTROL; //ADD
				`ADDU:alucontrol <= `ADDU_CONTROL; //ADDU
				`SUB:alucontrol <= `SUB_CONTROL; //SUB
				`SUBU:alucontrol <= `SUBU_CONTROL; //SUBU
				`SLT:alucontrol <= `SLT_CONTROL; //SLT
				`SLTU:alucontrol <= `SLTU_CONTROL; //SLTU
				//2.乘法指令与除法指令
				`MULT:alucontrol <= `MULT_CONTROL; //MULT
				`MULTU:alucontrol <= `MULTU_CONTROL; //MULTU
				`DIV:alucontrol <= `DIV_CONTROL; //DIV
				`DIVU:alucontrol <= `DIVU_CONTROL; //DIVU
				default:  alucontrol <= 5'b00000;
			endcase
		endcase
	
	end
endmodule
