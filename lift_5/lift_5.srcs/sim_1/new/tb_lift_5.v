`timescale 1ps / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/28/2020 02:01:29 AM
// Design Name: 
// Module Name: tb_lift_5
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


module tb_lift_5;

   reg t_clk,t_rst,t_flr1,t_flr2,t_flr3,t_flr4,t_flr5,t_up1,t_up2,t_up3,t_up4,t_dw5,t_dw4,t_dw3,t_dw2;
    //wire t_COUNT_TIMEOUT;
   wire [3:0]t_counter_out;
   wire [3:0]t_out;
    
    
    lift_5 inst(.clk(t_clk),.rst(t_rst),.flr1(t_flr1),.flr2(t_flr2),.flr3(t_flr3),.flr4(t_flr4),.flr5(t_flr5),.up1(t_up1),.up2(t_up2),.up3(t_up3),.dw5(t_dw5),.dw4(t_dw4),.dw3(t_dw3),.dw2(t_dw2),/*.COUNT_TIMEOUT(t_COUNT_TIMEOUT),*/.counter_out(t_counter_out),.out(t_out));
    
    initial
        begin
            t_clk = 0;
            t_rst = 1;
         #1 t_rst = 0;
         end
       
       initial 
       
        begin 
          t_flr1 = 0 ; t_flr2 = 0 ; t_flr3 = 0 ; t_flr4 = 0; t_flr5 = 0; t_up1 = 0 ; t_up2 = 0 ; t_up3 = 0 ; t_up4 =0 ; t_dw5 = 0 ; t_dw4 = 0 ; t_dw3 = 0 ; t_dw2 = 0; //NOTE: use semicollon, not comma.
          #15 t_flr1 = 1;
          #2 t_flr1 =0 ; 
          #10 t_flr2 =1 ; 
          #1 t_flr2 =0 ; 
          #4 t_flr3 = 1; 
          #2 t_flr3 = 0 ;
          #4 t_dw2 = 1 ; 
          #3 t_dw2 =0 ;
          #5 t_up1 =1 ; 
          #2 t_up1 = 0; 
          #5 t_flr3 = 1;
          #5 t_flr3 = 0;
          #10 t_flr4 = 1;
          #2 t_flr4 = 0;
          #4 t_flr5 = 1;
          #2 t_flr5 = 0;
          #10 t_up2 = 1;
          #6 t_up2 = 0;
          #5 t_dw5 = 1;
          #6 t_dw5 = 0;
          #5 t_up1 = 1;
          #10 t_up1 = 0; 
        end
      
    always
     begin
      #1 t_clk = !t_clk;
     end
    initial begin 
          #500 $finish;
      end
endmodule
