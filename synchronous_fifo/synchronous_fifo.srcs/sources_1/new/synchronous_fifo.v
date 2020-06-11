`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2020 10:30:53 PM
// Design Name: 
// Module Name: synchronous_fifo
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


module synchronous_fifo(clk,reset,read_en,write_en,data_in,data_out,occupancy,empty,full);

parameter DATA_SIZE = 32;
parameter DEPTH  = 256;

input clk,reset,read_en,write_en;
input [DATA_SIZE - 1 : 0]data_in;
output reg [DATA_SIZE - 1 : 0]data_out;
output reg [$clog2(DEPTH) - 1 : 0]occupancy;
output reg empty,full;


endmodule
