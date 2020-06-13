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

parameter data_size = 8;
parameter depth  = 16;

reg [31:0]mem[0:15];

input clk,reset,read_en,write_en;
input [data_size - 1 : 0]data_in;
output reg [data_size - 1 : 0]data_out ;
output reg [$clog2(depth) - 1 : 0]occupancy ;
output reg empty ;
output reg full;

wire write_permitted;
wire read_permitted;
reg [3:0]write_pointer;
reg [3:0]read_pointer;

assign write_permitted = (write_en && !full) || (write_en && full && read_en);
assign read_permitted = (read_en && !empty) || (read_en && empty && write_en);

always@(posedge clk,reset)
if (reset)
    begin
        data_out = 0;
        occupancy  = 0;
        empty  = 0;
        full = 0;
 end
else
    begin
        if(write_permitted)
            begin
                write_pointer = write_pointer + 1;
                empty = 0;
                mem[write_pointer] <= data_in; 
            end
        if(read_permitted)
            begin
             read_pointer = read_pointer + 1;
            end
         
        occupancy = depth - write_pointer;
        
    end 
endmodule
