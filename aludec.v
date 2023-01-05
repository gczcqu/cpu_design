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


module aludec(
	input wire[5:0] funct,
	input wire[2:0] aluop,
	output reg[4:0] alucontrol
    );
	always @(*) begin
		case (aluop)
		//alucontrol共五位，目前用至10（01010）
			//四条立即数逻辑运算指令
            3'b001:alucontrol <= 5'b00000;//andi
			3'b010:alucontrol <= 5'b00100;//lui
			3'b011:alucontrol <= 5'b00001;//ori
			3'b100:alucontrol <= 5'b00011;//xori
			// 2'b00: alucontrol <= 3'b010;//add (for lw/sw/addi)
			// 2'b01: alucontrol <= 3'b110;//sub (for beq)
			default : case (funct)
				// 6'b100000:alucontrol <= 3'b010; //add
				// 6'b100010:alucontrol <= 3'b110; //sub
				// 6'b100100:alucontrol <= 3'b000; //and
				// 6'b100101:alucontrol <= 3'b001; //or
				// 6'b101010:alucontrol <= 3'b111; //slt
				
				//八条逻辑运算指令
				//前四条R-type指令
				6'b100100:alucontrol <= 5'b00000; //and
				6'b100101:alucontrol <= 5'b00001; //or
				6'b100111:alucontrol <= 5'b00010; //nor
				6'b100110:alucontrol <= 5'b00011; //xor

				//六条逻辑运算指令
				6'b000100:alucontrol <= 5'b00101; //SLLV
				6'b000000:alucontrol <= 5'b00110; //SLL
				6'b000111:alucontrol <= 5'b00111; //SRAV
				6'b000011:alucontrol <= 5'b01000; //SRA
				6'b000110:alucontrol <= 5'b01001; //SRLV
				6'b000010:alucontrol <= 5'b01010; //SRL

				default:  alucontrol <= 5'b00000;
			endcase
		endcase
	
	end
endmodule
