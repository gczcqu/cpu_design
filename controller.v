`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/10/23 15:21:30
// Design Name: 
// Module Name: controller
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
module controller(
	input wire clk,rst,
	//decode stage
	input wire[5:0] opD,functD,
	output wire pcsrcD,branchD,equalD,jumpD,
	
	//execute stage
	input wire flushE,
	output wire memtoregE,alusrcE,
	output wire regdstE,regwriteE,	
	output wire[4:0] alucontrolE,
	output wire hiloregwriteE,hiloregreadE,hiloregreadW,signimmnextD,
	//mem stage
	output wire memtoregM,memwriteM,regwriteM,
	output wire [2:0]l_s_typeM,
	//write back stage
	output wire memtoregW,regwriteW

    );
	
	//decode stage
	wire[3:0] aluopD;
	wire memtoregD,memwriteD,alusrcD,
		regdstD,regwriteD,hiloregwriteD,hiloregreadD;
	wire[4:0] alucontrolD;
	wire [2:0]l_s_typeD;
	//execute stage
	wire memwriteE;
	wire [2:0]l_s_typeE;
	//M stage
	wire hiloregreadM;

	maindec md(
		opD,
		functD,
		l_s_typeD,
		signimmnextD,
		memtoregD,memwriteD,
		branchD,alusrcD,
		regdstD,regwriteD,
		jumpD,
		aluopD
		);
	aludec ad(functD,aluopD,alucontrolD);
	assign hiloregwriteD = (alucontrolD==`MTHI_CONTROL)|(alucontrolD==`MTLO_CONTROL)?1:0;
	assign hiloregreadD = (alucontrolD==`MFHI_CONTROL)|(alucontrolD==`MFLO_CONTROL)?1:0;
	assign pcsrcD = branchD & equalD;

	//pipeline registers
	floprc #(15) regE(
		clk,
		rst,
		flushE,
		{l_s_typeD,hiloregreadD,hiloregwriteD,memtoregD,memwriteD,alusrcD,regdstD,regwriteD,alucontrolD},
		{l_s_typeE,hiloregreadE,hiloregwriteE,memtoregE,memwriteE,alusrcE,regdstE,regwriteE,alucontrolE}
		);
	flopr #(7) regM(
		clk,rst,
		{l_s_typeE,hiloregreadE,memtoregE,memwriteE,regwriteE},
		{l_s_typeM,hiloregreadM,memtoregM,memwriteM,regwriteM}
		);
	flopr #(3) regW(
		clk,rst,
		{hiloregreadM,memtoregM,regwriteM},
		{hiloregreadW,memtoregW,regwriteW}
		);
endmodule
