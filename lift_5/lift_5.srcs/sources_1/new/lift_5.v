`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2020 11:19:35 PM
// Design Name: 
// Module Name: lift_5
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


module lift_5(clk,rst,flr1,flr2,flr3,flr4,flr5,up1,up2,up3,up4,dw5,dw4,dw3,dw2,counter_out,out);
       
       input clk,rst,flr1,flr2,flr3,flr4,flr5,up1,up2,up3,up4,dw5,dw4,dw3,dw2;
       //output [3:0]COUNT_TIMEOUT;
       output [3:0]counter_out;
       output [2:0]out;
       
       reg [3:0]state;
       reg [3:0]out;
       reg [3:0]counter_out;
       reg rst_count;
       reg [3:0]COUNT_TIMEOUT;
       initial out = 4'b0000;
       initial counter_out = 3'b000;
       initial COUNT_TIMEOUT = 4'b0011;
     //  integer COUNT_TIMEOUT;
       `define OPEN1  4'b0000 // don't use semicolon in define,and better keep capial letter
       `define CLOSE1 4'b0001
       `define CLOSE2 4'b0010
       `define OPEN2  4'b0011
       `define CLOSE3 4'b0100
       `define OPEN3  4'b0101
       `define CLOSE4 4'b0110
       `define OPEN4  4'b0111
       `define CLOSE5 4'b1000
       `define OPEN5  4'b1001
       `define COUNT_TIMEOUT 4'b0011
       
       //reset lift
     always@(posedge clk, posedge rst) 
      begin
       if(rst)
            begin
                state <= `OPEN1; //use non-blockng statmnt for sequential and don't mix blocking and non-blocking
                out <= `OPEN1;
         //        $display("check1");
            end 
            
       //different floor conditions
       else
          //   $display("check2");  
        begin
         case(state)//lift is in first floor
     `OPEN1: 
       begin
        //$monitor($time ,"check3");
           if(rst_count) // counter start for delay
                begin
                 counter_out <= 0;
                 rst_count <= 0;
                  state <= `CLOSE1;// dleay end,entered into next state i.e close1
                  out <= `CLOSE1;
                 end
           else
                counter_out <= counter_out + 1;
                
            if(counter_out == COUNT_TIMEOUT)
            rst_count <= 1;
            //$display("check");
         //state <= 3'b001;// delay end, entered into next state i.e close1
           //out <= 3'b001;
             //$display("check2");
                     
            if(flr1 || flr2 || flr3 || flr4 || flr5 || up1 || up2 || up3 || up4 || dw5 || dw4 || dw3 || dw2 )
                begin
                    state <= `OPEN1;
                    out <= `OPEN1;
                end
           
            end
     `CLOSE1:
         begin
            if(flr1 || up1 )
                begin
                    state <= `OPEN1;
                    out <= `OPEN1;
                end
            else if(flr2 || flr3 || flr4 || flr5 || up2 || up3 || up4 || dw5 || dw4 || dw3 || dw2)
                begin
                 state <= `CLOSE2;
                 out <= `CLOSE2;
                end
            end
           
    `CLOSE2:
         begin
            if(flr2 || up2 || dw2 )
                begin
                    state <= `OPEN2;
                    out <= `OPEN2;
                end
            else if(flr1 || up1)
                begin
                 state <= `CLOSE1;
                 out <= `CLOSE1;
                end
             else if(flr3 || flr4 || flr5 || up3 || up4 || dw5 || dw4 || dw3)
                begin
                 state <= `CLOSE3;
                 out <= `CLOSE3;
                end
            end     
        
     `OPEN2:
       begin
        if(rst_count) // counter start for delay
           begin
                 counter_out <= 0;
                 rst_count <= 0;
                  state <= `CLOSE2;// dleay end,entered into next state i.e close1
                  out <= `CLOSE2;
                  end
           else 
               counter_out <= counter_out + 1;
             
          if(COUNT_TIMEOUT )
              rst_count <= 1;
         
          if(flr1 || flr2 || flr3 || flr4 || flr5 || up1 || up2 || up3 || up4 || dw5 || dw4 || dw3 || dw2 )
                begin
                    state <= `OPEN2;
                    out <= `OPEN2;
                end  
     end
     
     `CLOSE3:
         begin
            if(flr3 || up3 || dw3 )
                begin
                    state <= `OPEN3;
                    out <= `OPEN3;
                end
           else if(flr2 || flr1 || up1 || up2 || dw2)
                begin
                 state <= `CLOSE2;
                 out <= `CLOSE2;
                end
            else if( flr4 || flr5 ||  up4 || dw5 || dw4 )
                begin
                 state <= `CLOSE4;
                 out <= `CLOSE4;
                end     
      end
      
     `OPEN3:
       begin
        if(rst_count) // counter start for delay
           begin
                 counter_out <= 0;
                 rst_count <= 0;
                  state <= `CLOSE3;// dleay end,entered into next state i.e close1
                  out <= `CLOSE3;
                  end
           else 
               counter_out <= counter_out + 1;
             
          if(COUNT_TIMEOUT )
              rst_count <= 1;
         
            if(flr1 || flr2 || flr3 || flr4 || flr5 || up1 || up2 || up3 || up4 || dw5 || dw4 || dw3 || dw2 )
                begin
                    state <= `OPEN3;
                    out <= `OPEN3;
                end
     
     end
      
      `CLOSE4:
            begin
            if(flr4 || up4 || dw4 )
                begin
                    state <= `OPEN4;
                    out <= `OPEN4;
                end
            else if( flr1 || flr2 || flr3 || up1 || up2 || up3)
                begin
                 state <= `CLOSE3;
                 out <= `CLOSE3;
                end
             else if( flr5 ||  dw5 )
                begin
                 state <= `CLOSE5;
                 out <= `CLOSE5;
                end    
      end
      
     `OPEN4:
       begin
        if(rst_count) // counter start for delay
           begin
                 counter_out <= 0;
                 rst_count <= 0;
                  state <= `CLOSE4;
                  out <= `CLOSE4;
                  end
           else 
               counter_out <= counter_out + 1;
             
          if(COUNT_TIMEOUT )
              rst_count <= 1;
         
             if(flr1 || flr2 || flr3 || flr4 || flr5 || up1 || up2 || up3 || up4 || dw5 || dw4 || dw3 || dw2 )
                begin
                    state <= `OPEN4;
                    out <= `OPEN4;
                end
     
     end
          
      `CLOSE5:
         begin
            if( flr5 || dw5 )
                begin
                    state <= `OPEN5;
                    out <= `OPEN5;
                end
                
            else if(flr1 || flr2 || flr3 || flr4 || up1 || up2 || up3 || up4|| dw4 || dw3 || dw2)    
                begin
                 state <= `CLOSE4;
                 out <= `CLOSE4;
                end     
      end
      
     `OPEN5:
       begin
        if(rst_count) // counter start for delay
           begin
                 counter_out <= 0;
                 rst_count <= 0;
                  state <= `CLOSE5;// dleay end,entered into next state i.e close1
                  out <= `CLOSE5;
                  end
           else 
               counter_out <= counter_out + 1;
             
          if(COUNT_TIMEOUT )
              rst_count <= 1;
         
             if(flr1 || flr2 || flr3 || flr4 || flr5 || up1 || up2 || up3 || up4 || dw5 || dw4 || dw3 || dw2 )
                begin
                    state <= `OPEN5;
                    out <= `OPEN5;
                end
        end
       endcase
      end
   end        
    endmodule
    
