`timescale 1ns / 1ps

`include "defines2.vh"
module mem_control(
    input wire [2:0] l_s_typeM,
    input wire [1:0] addr, //偏移量

    input wire [31:0] data_wdataM,  //要写入的数据
    output reg [31:0] mem_wdataM,  //处理后的写数据
    output reg [3:0] mem_wenM,     //字节写使能

    input wire [31:0] mem_rdataM,   //从存储器中读出的数据
    output reg [31:0] data_rdataM //处理后的数据

    // output wire addr_error_sw, addr_error_lw
);
    always @(*) begin
		case (l_s_typeM)
        `LB_TYPE:begin  //LB
            mem_wenM <= 4'b0000;
            case(addr)
                2'b00:data_rdataM <= {{24{mem_rdataM[31]}},mem_rdataM[31:24]};
                2'b01:data_rdataM <= {{24{mem_rdataM[23]}},mem_rdataM[23:16]};
                2'b10:data_rdataM <= {{24{mem_rdataM[15]}},mem_rdataM[15:8]};
                2'b11:data_rdataM <= {{24{mem_rdataM[7]}},mem_rdataM[7:0]};
            endcase
        end
        `LBU_TYPE:begin  //LBU
            mem_wenM <= 4'b0000;
            case(addr)
                2'b00:data_rdataM <= {{24{1'b0}},mem_rdataM[31:24]};
                2'b01:data_rdataM <= {{24{1'b0}},mem_rdataM[23:16]};
                2'b10:data_rdataM <= {{24{1'b0}},mem_rdataM[15:8]};
                2'b11:data_rdataM <= {{24{1'b0}},mem_rdataM[7:0]};
            endcase
        end
        `LH_TYPE:begin  //LH
            mem_wenM <= 4'b0000;
            case(addr)
                2'b00:data_rdataM <= {{15{mem_rdataM[31]}},mem_rdataM[31:16]};
                2'b10:data_rdataM <= {{15{mem_rdataM[15]}},mem_rdataM[15:0]};
            endcase
        end
        `LHU_TYPE:begin  //LHU
            mem_wenM <= 4'b0000;
            case(addr)
                2'b00:data_rdataM <= {{15{1'b0}},mem_rdataM[31:16]};
                2'b10:data_rdataM <= {{15{1'b0}},mem_rdataM[15:0]};
            endcase
        end
        `LW_TYPE:begin  //LB
            mem_wenM <= 4'b0000;
            data_rdataM <= mem_rdataM;
        end
        `SB_TYPE:begin  //LB
            case(addr)
                2'b00:begin
                mem_wdataM <= {data_wdataM[7:0],{24{1'b0}}};
                mem_wenM <= 4'b1000;
                end
                2'b01:begin
                mem_wdataM <= {{8{1'b0}},data_wdataM[7:0],{16{1'b0}}};
                mem_wenM <= 4'b0100;
                end
                2'b10:begin
                mem_wdataM <= {{16{1'b0}},data_wdataM[7:0],{8{1'b0}}};
                mem_wenM <= 4'b0010;
                end
                2'b11:begin
                mem_wdataM <= {{24{1'b0}},data_wdataM[7:0]};
                mem_wenM <= 4'b0001;
                end
            endcase
        end
        `SH_TYPE:begin  //LB
             case(addr)
                2'b00:begin
                mem_wdataM <= {data_wdataM[15:0],{16{1'b0}}};
                mem_wenM <= 4'b1100;
                end
                2'b10:begin
                mem_wdataM <= {{16{1'b0}},data_wdataM[15:0]};
                mem_wenM <= 4'b0011;
                end
            endcase
        end
        `SW_TYPE:begin  //LB
            mem_wdataM <= data_wdataM;
            mem_wenM <= 4'b1111;
        end
        default:mem_wenM <= 4'b0000;
		endcase
	end
endmodule