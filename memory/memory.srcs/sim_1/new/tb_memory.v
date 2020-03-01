`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2020 11:57:58 AM
// Design Name: 
// Module Name: tb_memory
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


module tb_memory();


reg t_clk,t_rst,t_rd_wr_n,t_chip_sel_n;
reg [15 : 0]t_data_in;
reg [10 : 0 ]t_adress;

wire [15:0]t_data_out;

memory inst(.clk(t_clk),.rst(t_rst),.data_in(t_data_in),.adress(t_adress),.rd_wr_n(t_rd_wr_n),.chip_sel_n(t_chip_sel_n),.data_out(t_data_out));

initial
    begin
        t_rst = 1;
        t_chip_sel_n = 1;
        t_clk = 0;
     #2 t_rst = 0;  
     #2 t_chip_sel_n = 0;       
    end

initial 
    begin
     t_data_in = 16'h11;
   #7 t_data_in = 16'h44;
   #5 t_data_in = 16'h66;
   #2 t_data_in = 0;
   end
   
initial 
    begin
     t_adress = 11'h211;
   #7 t_adress = 11'h144;
   #5 t_adress = 11'h166;
   #3 t_adress = 11'h211;
   #5 t_adress = 11'h144;
   #5 t_adress = 11'h166;
   end
  
 initial
  begin
   t_rd_wr_n = 0;
   #14  t_rd_wr_n = 1;
  end  
 always
    #1 t_clk = !t_clk;   
 endmodule
