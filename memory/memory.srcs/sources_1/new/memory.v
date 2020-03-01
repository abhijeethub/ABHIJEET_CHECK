`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2020 10:59:36 AM
// Design Name: 
// Module Name: memory
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


module memory(clk,rst,data_in,adress,rd_wr_n,chip_sel_n,data_out);

parameter  data_width = 16;
parameter adress_width = 11;
parameter total_adress = 2048;

input clk,rst,rd_wr_n,chip_sel_n;
input [data_width - 1 : 0]data_in;
input [adress_width - 1 : 0]adress;
output reg [data_width - 1 : 0]data_out;

reg [data_width - 1 : 0]mem[0 : total_adress - 1]; //define memory(here 1024 x 8 or 1kB), NOTE:- use total no. of adress not adress width

always@(posedge clk,posedge rst)
    begin
        if(rst)
            data_out <= 0;
        else if(chip_sel_n == 0)
            begin
                if(rd_wr_n == 0)
                    mem[adress] <= data_in;// memory write, In to mem
                    
                else
                    data_out <= mem[adress]; //memory read , mem to Out   
            end
    end
endmodule
