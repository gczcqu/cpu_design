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

`include "defines2.vh"
module maindec(
	input wire[5:0] op,
	input wire[5:0]funct,
	output wire memtoreg,memwrite,
	output wire branch,alusrc,
	output wire regdst,regwrite,
	output wire jump,
	output wire[3:0] aluop
    );
	reg[10:0] controls;
	assign {regwrite,regdst,alusrc,branch,memwrite,memtoreg,jump,aluop} = controls;
	always @(*) begin
		case (op)
			// 6'b000000:controls <= 9'b1100000100;//R-TYRE
			// 6'b100011:controls <= 9'b101001000;//LW
			// 6'b101011:controls <= 9'b001010000;//SW
			// 6'b000100:controls <= 9'b000100001;//BEQ
			// 6'b001100:controls <= 9'b101000000;//ADDI
			//8鏉￠?昏緫杩愮畻鎸囦护
			//鍓嶅洓鏉′负R-type鍨嬫寚浠?
			// `R_TYPE:controls <= {7'b1100000,`R_TYPE_OP};//R-TYRE
			//4鏉＄珛鍗虫暟閫昏緫杩愮畻鎸囦护
			`ANDI:controls <= {7'b1010000,`ANDI_OP};//ANDI
			`XORI:controls <= {7'b1010000,`XORI_OP};//LUI锛堣繖涓笉澶竴鏍凤紝鍚庨潰瑕佸鐞嗕竴涓嬶級
			`ORI:controls <= {7'b1010000,`ORI_OP};//ORI
			`LUI:controls <= {7'b1010000,`LUI_OP};//XORI
			
			// 6'b000010:controls <= 9'b000000100;//J
			`R_TYPE : case (funct)
				`MTHI: controls <= {7'b0000000,`R_TYPE_OP};
				`MTLO: controls <= {7'b0000000,`R_TYPE_OP};
				default:  controls <= {7'b1100000,`R_TYPE_OP};
			endcase
			default:  controls <= 10'b0000000000;//illegal op
		endcase
	end
endmodule
