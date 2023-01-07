`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/02 14:52:16
// Design Name: 
// Module Name: alu
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
module alu(
	input wire[31:0] a,b,
	input wire[4:0] sa,
	input wire[4:0] op,
	output reg[31:0] y,
	output reg overflow,
	output wire zero
    );
	reg[31:0] mult_result;
	reg[31:0] div_result;
	reg[31:0] commont_reult;
	wire [63:0] alu_out_signed_mult, alu_out_unsigned_mult;
	// wire[31:0] s,bout;
	// assign bout = op[2] ? ~b : b;
	// assign s = a + bout + op[2];
	always @(*) begin
		case (op[4:0])
			// 2'b00: y <= a & bout;
			// 2'b01: y <= a | bout;
			// 2'b10: y <= s;
			// 2'b11: y <= s[31];
			`AND_CONTROL: y <= a & b;     //and,andi
			`OR_CONTROL: y <= a | b;      //or,ori
			`NOR_CONTROL: y <= ~(a | b);  //nor
			`XOR_CONTROL: y <= a^b;       // xor,xori
			`LUI_CONTROL: y <= b<<16;     //lui
			`SLLV_CONTROL: y <= b<<a[4:0];//SLLV(逻辑左移)
			`SLL_CONTROL: y <= b<<sa;	  //SLL(立即数逻辑左移)				
			`SRAV_CONTROL: y <= $signed(b)>>>a[4:0];//SRAV(算数右移)
			`SRA_CONTROL: y <= $signed(b)>>>sa;//SRA(立即数算数右移)
			`SRLV_CONTROL:y <= b>>a[4:0]; //SRLV(逻辑右移)
			`SRL_CONTROL: y <= b>>sa;	 //SRL(立即数逻辑右移)
			//算数指令（包含十条指令乘除法除外）
			`ADD_CONTROL: y<=a+b;		 //ADD(考虑溢出)，ADDI
			`ADDU_CONTROL: y<=a+b;	     //ADDU,ADDIU
			`SUB_CONTROL: y<=a-b;	     //SUB(考虑溢出)
			`SUBU_CONTROL: y<=a-b;	     //SUBU
			`SLT_CONTROL: y<= $signed(a)<$signed(b)?1:0;//SLT（有符号比较）,SLTI
			`SLTU_CONTROL: y<= a<b?1:0;	 //SLTU,SLTUI
			default : y <= 32'b0;
		endcase	
	end


	assign zero = (y == 32'b0);

//	always @(*) begin
//		case (op[2:1])
//			2'b01:overflow <= a[31] & b[31] & ~s[31] |
//							~a[31] & ~b[31] & s[31];
//			2'b11:overflow <= ~a[31] & b[31] & s[31] |
//							a[31] & ~b[31] & ~s[31];
//			default : overflow <= 1'b0;
//		endcase	
//	end
endmodule
