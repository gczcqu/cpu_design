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
	output wire signimmnext,
	output wire memtoreg,memwrite,
	output wire branch,alusrc,
	output wire regdst,regwrite,
	output wire jump,
	output wire[3:0] aluop
    );
	reg[11:0] controls;
	assign {signimmnext,regwrite,regdst,alusrc,branch,memwrite,memtoreg,jump,aluop} = controls;
	always @(*) begin
		case (op)
			//8鏉￠?昏緫杩愮畻鎸囦护
			//鍓嶅洓鏉′负R-type鍨嬫寚浠?
			//4鏉＄珛鍗虫暟閫昏緫杩愮畻鎸囦护
			`ANDI:controls <= {8'b01010000,`ANDI_OP};//ANDI
			`XORI:controls <= {8'b01010000,`XORI_OP};//LUI锛堣繖涓笉澶竴鏍凤紝鍚庨潰瑕佸鐞嗕竴涓嬶級
			`ORI:controls <= {8'b01010000,`ORI_OP};//ORI
			`LUI:controls <= {8'b01010000,`LUI_OP};//XORI

			//四条立即数运算指令
			`ADDI:controls <= {8'b11010000,`ADDI_OP};//ADDI
			`ADDIU:controls <= {8'b11010000,`ADDIU_OP};//ADDIU
			`SLTI:controls <= {8'b11010000,`SLTI_OP};//SLTI
			`SLTIU:controls <= {8'b11010000,`SLTIU_OP};//SLTIU
			
			// 6'b000010:controls <= 9'b000000100;//J
			`R_TYPE : case (funct)
				`MTHI: controls <= {8'b00000000,`R_TYPE_OP};
				`MTLO: controls <= {8'b00000000,`R_TYPE_OP};
				default:  controls <= {8'b01100000,`R_TYPE_OP};
			endcase
			default:  controls <= 11'b00000000000;//illegal op
		endcase
	end
endmodule
