`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/23 15:21:30
// Design Name: 
// Module Name: maindec
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


module maindec(
	input wire[5:0] op,
	output wire memtoreg,memwrite,
	output wire branch,alusrc,
	output wire regdst,regwrite,
	output wire jump,
	output wire[2:0] aluop
    );
	reg[9:0] controls;
	assign {regwrite,regdst,alusrc,branch,memwrite,memtoreg,jump,aluop} = controls;
	always @(*) begin
		case (op)
			// 6'b000000:controls <= 9'b1100000100;//R-TYRE
			// 6'b100011:controls <= 9'b101001000;//LW
			// 6'b101011:controls <= 9'b001010000;//SW
			// 6'b000100:controls <= 9'b000100001;//BEQ
			// 6'b001100:controls <= 9'b101000000;//ADDI
			//8条�?�辑运算指令
			//前四条为R-type型指�?
			6'b000000:controls <= 10'b1100000000;//R-TYRE
			//4条立即数逻辑运算指令
			6'b001100:controls <= 10'b1010000001;//ANDI
			6'b001111:controls <= 10'b1010000010;//LUI（这个不太一样，后面要处理一下）
			6'b001101:controls <= 10'b1010000011;//ORI
			6'b001110:controls <= 10'b1010000100;//XORI
			
			// 6'b000010:controls <= 9'b000000100;//J
			default:  controls <= 10'b0000000000;//illegal op
		endcase
	end
endmodule
