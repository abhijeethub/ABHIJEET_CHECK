`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2020 09:53:51 PM
// Design Name: 
// Module Name: up_down_counter
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


module up_down_counter(clk,rst,up_down_n,count_out);

parameter N = 4;
input clk,rst,up_down_n;
output reg [N - 1 : 0]count_out;
initial count_out = 4'b0000;
//logic
always@(posedge clk, posedge rst)
begin
    if(rst)
        count_out <= 0;
    else if(up_down_n)
        count_out <= count_out + 1;
    else
        count_out <= count_out - 1;
end
endmodule
