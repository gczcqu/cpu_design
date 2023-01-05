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
			// R-type指令
			`R_TYPE_OP : case (funct)
				// 6'b100000:alucontrol <= 3'b010; //add
				// 6'b100010:alucontrol <= 3'b110; //sub
				// 6'b100100:alucontrol <= 3'b000; //and
				// 6'b100101:alucontrol <= 3'b001; //or
				// 6'b101010:alucontrol <= 3'b111; //slt
				
				//八条逻辑运算指令
				//前四条R-type指令
				`AND:alucontrol <= `AND_CONTROL; //AND
				`OR:alucontrol <= `OR_CONTROL; //OR
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

				default:  alucontrol <= 5'b00000;
			endcase
		endcase
	
	end
endmodule
