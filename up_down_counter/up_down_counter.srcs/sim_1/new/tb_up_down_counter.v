`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/01/2020 10:15:38 PM
// Design Name: 
// Module Name: tb_up_down_counter
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


module tb_up_down_counter();
reg  t_clk, t_rst,t_up_down_n;
wire [3:0]t_count_out;

//instatntiate
up_down_counter inst(.clk(t_clk),.rst(t_rst),.up_down_n(t_up_down_n),.count_out(t_count_out));

initial
begin
    t_clk = 0;
    t_rst = 0;
 #15 t_rst = 1;
 #2 t_rst = 0;
 end  
 
initial
begin
     t_up_down_n = 1;
  #10 t_up_down_n = 0;
end
    
always
 #1 t_clk = !t_clk;
 
endmodule
