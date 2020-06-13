`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/13/2020 10:52:01 AM
// Design Name: 
// Module Name: tb_synchronous_fifo
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


module tb_synchronous_fifo();

reg tb_clk,tb_reset,tb_read_en,tb_write_en;
reg [31 : 0]tb_data_in;

wire [31:0]tb_data_out;
wire [15:0]tb_occupancy;
wire tb_empty,tb_full; 

synchronous_fifo inst (.clk(tb_clk),.reset(tb_reset),.read_en(tb_read_en),.write_en(tb_write_en),.data_in(tb_data_in),.data_out(tb_data_out),.occupancy(tb_occupancy),.empty(tb_empty),.full(tb_full));

initial
begin
 tb_clk = 0;
 tb_reset = 1;
end 
 
always #5 tb_clk = !tb_clk;

initial
    begin
        #5 tb_reset = 0;
        tb_write_en = 1; 
        tb_read_en  = 1;
        
    end
    
 initial 
   begin
    tb_data_in = 8'hFF;
   end   

endmodule
