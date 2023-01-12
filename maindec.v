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
	output reg [2:0]l_s_type,
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
			
			//八条访存指令
			`LB:controls <= {8'b11010010,`ADDI_OP};//LB
			`LBU:controls <= {8'b11010010,`ADDI_OP};//LBU
			`LH:controls <= {8'b11010010,`ADDI_OP};//LH
			`LHU:controls <= {8'b11010010,`ADDI_OP};//LHU
			`LW:controls <= {8'b11010010,`ADDI_OP};//LW
			`SB:controls <= {8'b10010100,`ADDI_OP};//SB
			`SH:controls <= {8'b10010100,`ADDI_OP};//SH
			`SW:controls <= {8'b10010100,`ADDI_OP};//SW

			// 6'b000010:controls <= 9'b000000100;//J
			`R_TYPE : case (funct)
				`MTHI: controls <= {8'b00000000,`R_TYPE_OP};
				`MTLO: controls <= {8'b00000000,`R_TYPE_OP};
				default:  controls <= {8'b01100000,`R_TYPE_OP};
			endcase
			default:  controls <= 12'b000000000000;//illegal op
		endcase
	end

	always @(*) begin
		case (op)
			`LB:l_s_type <= `LB_TYPE;//LB
			`LBU:l_s_type <= `LBU_TYPE;//LBU
			`LH:l_s_type <= `LH_TYPE;//LH
			`LHU:l_s_type <= `LHU_TYPE;//LHU
			`LW:l_s_type <= `LW_TYPE;//LW
			`SB:l_s_type <= `SB_TYPE;//SB
			`SH:l_s_type <= `SH_TYPE;//SH
			`SW:l_s_type <= `SW_TYPE;//SW
			default:l_s_type <= 3'b000;
		endcase
	end
endmodule
