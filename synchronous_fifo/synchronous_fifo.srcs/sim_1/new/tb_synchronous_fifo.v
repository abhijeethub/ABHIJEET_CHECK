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

parameter DATA_SIZE = 8;
parameter DEPTH  = 16; //Keeping depth less to see rollover early

reg tb_clk,tb_reset,tb_read_en,tb_write_en;
reg [DATA_SIZE-1 : 0]tb_data_in;

wire [DATA_SIZE-1:0]tb_data_out;
wire [$clog2(DEPTH):0]tb_occupancy;
wire tb_empty,tb_full; 

synchronous_fifo inst (.clk(tb_clk),.reset(tb_reset),
.read_en(tb_read_en),.write_en(tb_write_en),
.data_in(tb_data_in),.data_out(tb_data_out),
.occupancy(tb_occupancy),.empty(tb_empty),
.full(tb_full));

initial
begin
 tb_clk = 0;
 tb_reset = 1;
end 
 
always #5 tb_clk = !tb_clk;

initial
    begin
     #20 tb_reset = 0;
     
	 repeat (4)
	 begin
	   @(posedge tb_clk);
	   write_fifo($random);
	 end
	 #100;
	 repeat (2)
	 begin
	   @(posedge tb_clk);
	   read_fifo;
	 end
	
   end
 
task write_fifo;
	input [DATA_SIZE-1:0]data;
    begin
        $display("input data is %h",data); 
        tb_data_in = data;
        $display("input TB data is %h",tb_data_in);
        if(tb_full != 1)
            tb_write_en = 1'b1;
        @(posedge tb_clk);
        tb_write_en = 0;
    end
endtask

task read_fifo;
    begin
        $display("input TB data is %h",tb_data_in);
        if(tb_empty != 1)
            tb_read_en = 1'b1;
		else
			$display("FIFO empty !!!");
        
		@(posedge tb_clk);
        tb_read_en = 0;
		@(posedge tb_clk);
		$display("Read value is %h",tb_data_out);
    end
endtask 
 
 
 
 initial 
   begin
    #400 $finish;
   end   

endmodule
