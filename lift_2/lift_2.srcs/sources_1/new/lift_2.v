    `timescale 1ns / 1ps
    //////////////////////////////////////////////////////////////////////////////////
    // Company: 
    // Engineer: 
    // 
    // Create Date: 01/26/2020 11:47:16 AM
    // Design Name: 
    // Module Name: lift_2
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
    
    module lift_2(clk,rst,flr1,flr2,flr3,up1,up2,dw3,dw2,COUNT_TIMEOUT,out_count,out);
       
       input clk,rst,flr1,flr2,flr3,up1,up2,dw3,dw2;
       output [3:0]COUNT_TIMEOUT;
       output [3:0]out_count;
       output [2:0]out;
       
       reg [2:0]state;
       reg [2:0]out;
       reg [3:0]out_count;
       reg rst_count;
       reg [3:0]COUNT_TIMEOUT;
       initial out = 3'b000;
       initial out_count = 3'b000;
       initial COUNT_TIMEOUT = 3'b0011;
     //  integer COUNT_TIMEOUT;
       `define open1 3'b000 // don't use semicolon in define
       `define close1 3'b001
       `define close2 3'b010
       `define open2 3'b011
       `define close3 3'b100
       `define open3 3'b101
       `define COUNT_TIMEOUT 3'b0011
       
       //reset lift
     always@(posedge clk, posedge rst) //why posedge rst??
      begin
       if(rst)
            begin
                state <= `open1; //use defined variable with "`" i.e tick
                out <= `open1;
         //        $display("check1");
            end 
            
       //different floor conditions
       else
          //   $display("check2");  
        begin
         case(state)//lift is in first floor
     `open1: //open1
   
       begin
        //$monitor($time ,"check3");
           if(rst_count) // counter start for delay
           begin
                 out_count <= 0;
                 rst_count <= 0;
                  state <= `close1;// dleay end,entered into next state i.e close1
                  out <= `close1;
                  end
           else
                out_count <= out_count + 1;
                
            if(out_count == COUNT_TIMEOUT)
            rst_count <= 1;
            //$display("check");
         //state <= 3'b001;// delay end, entered into next state i.e close1
           //out <= 3'b001;
             //$display("check2");
                     
            if(flr1 || flr2 || flr3 || up1 || up2 || dw3 || dw2 )
                begin
                    state <= `open1;
                    out <= `open1;
                end
           
            end
     `close1:
         begin
            begin
            if(flr1 || up1 )
                begin
                    state <= `open1;
                    out <= `open1;
                end
            else if(flr2 || flr3 || up2 || dw3 || dw2)
                begin
                 state <= `close2;
                 out <= `close2;
                end
            end
           end
    `close2:
         begin
            begin
            if(flr2 || up2 || dw2 )
                begin
                    state <= `open2;
                    out <= `open2;
                end
            else if(flr1 || up1)
                begin
                 state <= `close1;
                 out <= `close1;
                end
             else if(flr3 || dw3)
                begin
                 state <= `close3;
                 out <= `close3;
                end
            end     
      end
      
     `open2:
       begin
        if(rst_count) // counter start for delay
           begin
                 out_count <= 0;
                 rst_count <= 0;
                  state <= `close2;// dleay end,entered into next state i.e close1
                  out <= `close2;
                  end
           else 
               out_count <= out_count + 1;
             
          if(COUNT_TIMEOUT )
              rst_count <= 1;
         
             if(flr1 || flr2 || flr3 || up1 || up2 || dw3 || dw2  )
                begin
                    state <= `open2;
                    out <= `open2;
                end
     
     end
     `close3:
            begin    
            if(flr3 || dw3 )
                begin
                    state <= `open3;
                    out <= `open3;
                end
              end
         
       `open3:
         begin
       if(rst_count) // counter start for delay
           begin
                 out_count <= 0;
                 rst_count <= 0;
                  state <= `close3;// dleay end,entered into next state i.e close1
                  out <= `close3;
                  end
           else
               out_count <= out_count + 1;
               
        if(COUNT_TIMEOUT)
         rst_count <= 1;
        
            
            if(flr1 || flr2 || flr3 || up1 || up2 || dw3 || dw2  )
                begin
                    state <= `open3;
                    out <= `open3;
                end
             
             end 
           endcase
          end
        end   
    endmodule
