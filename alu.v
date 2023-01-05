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

	// wire[31:0] s,bout;
	// assign bout = op[2] ? ~b : b;
	// assign s = a + bout + op[2];
	always @(*) begin
		case (op[4:0])
			// 2'b00: y <= a & bout;
			// 2'b01: y <= a | bout;
			// 2'b10: y <= s;
			// 2'b11: y <= s[31];
			`AND_CONTROL: y <= a & b;   //and,andi
			`OR_CONTROL: y <= a | b;   //or,ori
			`NOR_CONTROL: y <= ~(a | b);//nor
			`XOR_CONTROL: y <= a^b;     // xor,xori
			`LUI_CONTROL:begin          //lui
				y <= b<<16;
			end
			`SLLV_CONTROL:begin          //SLLV(逻辑左移)
				y <= b<<a[4:0];         
			end
			`SLL_CONTROL:begin			//SLL(立即数逻辑左移)
				y <= b<<sa;				
			end
			`SRAV_CONTROL:begin          //SRAV(算数右移)
				y <= $signed(b)>>>a[4:0];
			end
			`SRA_CONTROL:begin			//SRA(立即数算数右移)
				y <= $signed(b)>>>sa;
			end
			`SRLV_CONTROL:begin			//SRLV(逻辑右移)
				y <= b>>a[4:0]; 
			end
			`SRL_CONTROL:begin			//SRL(立即数逻辑右移)
				y <= b>>sa;
			end
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
