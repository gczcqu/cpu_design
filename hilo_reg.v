`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/12/12 11:26:03
// Design Name: 
// Module Name: hilo_reg
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
module hilo_reg(
	input  wire clk,rst,we,re,
	input  wire [4:0] alucontrol,
	input  wire [31:0] hilo_in,
	output wire [31:0] hilo_out
    );
	
	reg [31:0] hi, lo;
	always @(negedge clk) begin
		if(rst) begin
			hi <= 0;
			lo <= 0;
		end else if (we) begin
			if (alucontrol == `MTHI_CONTROL) hi <= hilo_in;
			else if (alucontrol == `MTLO_CONTROL) lo <= hilo_in;
		end
	end
	assign hilo_out = (alucontrol == `MFHI_CONTROL)?hi:lo;
	// always @(posedge clk) begin
	// 	if(rst) begin
	// 		hilo_out <= 0;
	// 	end else if (re) begin
	// 		if (alucontrol == `MFHI_CONTROL) hilo_out <= hi;
	// 		else if (alucontrol == `MFLO_CONTROL) hilo_out <= lo;
	// 	end
	// end
	
endmodule
