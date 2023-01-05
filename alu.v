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
			5'b00000: y <= a & b;   //and,andi
			5'b00001: y <= a | b;   //or,ori
			5'b00010: y <= ~(a | b);//nor
			5'b00011: y <= a^b;     // xor,xori
			5'b00100:begin          //lui
				y <= b<<16;
			end
			5'b00101:begin          //SLLV(逻辑左移)
				y <= b<<a[4:0];         
			end
			5'b00110:begin			//SLL(立即数逻辑左移)
				y <= b<<sa;				
			end
			5'b00111:begin          //SRAV(算数右移)
				y <= $signed(b)>>>a[4:0];
			end
			5'b01000:begin			//SRA(立即数算数右移)
				y <= $signed(b)>>>sa;
			end
			5'b01001:begin			//SRLV(逻辑右移)
				y <= b>>a[4:0]; 
			end
			5'b01010:begin			//SRL(立即数逻辑右移)
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
