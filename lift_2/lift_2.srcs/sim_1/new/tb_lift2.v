`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2020 07:32:00 PM
// Design Name: 
// Module Name: tb_lift2
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


module tb_lift;

    reg t_clk,t_rst,t_flr1,t_flr2,t_flr3,t_up1,t_up2,t_dw3,t_dw2;
    wire t_COUNT_TIMEOUT;
    wire [3:0]t_out_count;
    wire [2:0]t_out;
    
    lift_2 inst(.clk(t_clk),.rst(t_rst),.flr1(t_flr1),.flr2(t_flr2),.flr3(t_flr3),.up1(t_up1),.up2(t_up2),.dw3(t_dw3),.dw2(t_dw2),.COUNT_TIMEOUT(t_COUNT_TIMEOUT),.out_count(t_out_count),.out(t_out));
    
    initial
        begin
            t_clk = 0;
            t_rst = 1;
         #1 t_rst = 0;
         end
       
       initial 
        begin 
          #10 t_flr1 = 1 ; t_flr2 = 0 ; t_flr3 = 0 ; t_up1 = 0 ; t_up2 = 0 ; t_dw3 = 0 ; t_dw2 = 0; //NOTE: use semicollon, not comma.
          #10 t_flr1 =0 ; t_flr2 = 1 ;
          #5 t_flr2 =0 ; t_flr3 = 1;
          #5 t_flr3 = 0; t_up1 = 1;
          #5 t_up1 = 0; t_up2 = 1;
          #5 t_up2 =0; t_dw3 = 1;
          #5 t_dw3 = 0; t_dw2 =1; 
        end
      
    always
     begin
    #1 t_clk = !t_clk;
           // #2 t_rst_count = !t_rst_count ;
     end
    initial begin 
          #1000 $finish;
      end
endmodule
