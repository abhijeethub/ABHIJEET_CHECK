`timescale 1ps / 1ps
module tb_synchronous_fifo();

`define TIMEOUT 40000
parameter DATA_SIZE = 32;
parameter DEPTH  = 16; //Keeping depth less to see rollover early

reg tb_clk,tb_reset,tb_read_en,tb_write_en;
reg [DATA_SIZE-1 : 0]tb_data_in;

wire [DATA_SIZE-1:0]tb_data_out;
wire tb_data_out_valid;
wire [$clog2(DEPTH):0]tb_available_entries;
wire tb_empty,tb_full; 

reg [DATA_SIZE -1 : 0]write_array[0:1000];
reg [DATA_SIZE -1 : 0]read_array[0:1000];
integer write_index = 0;
integer read_index = 0;
integer errors = 0;
reg [4*8-1:0] status; //Storing a string - each character takes 8-bits (PASS - takes 4*8 bits)
						//string always stored as reg in verilog, there is no key word string.


synchronous_fifo inst (.clk(tb_clk),.reset(tb_reset),
.read_en(tb_read_en),.write_en(tb_write_en),
.data_in(tb_data_in),.data_out(tb_data_out),.data_out_valid(tb_data_out_valid),
.available_entries(tb_available_entries),.empty(tb_empty),
.full(tb_full));

initial
begin
 tb_clk = 0;
 tb_reset = 1;
 tb_read_en = 0;
 tb_write_en = 0;
 tb_data_in = 0;
end 
 
always #5 tb_clk = !tb_clk;

initial
    begin
     #20 tb_reset = 0;
     
	 repeat(5000)  // write_fifo will be called 16 times.
	 begin
	   @(posedge tb_clk);  //this line is added after declaration of task write_fifo, coz in delclrn. tb_write_en signal of
                             //	   first repeat is '0' and that signal is being '1' in second repeat at same edge. so to 
							 //differentiate this, we added clock-delay.
		if($random%2 == 0)			 		 
		if(tb_full != 1)				   
			write_fifo($random);  //task call; NOTE:-task call can conain argument, but task declaration can't.
	 end
	end 
	 //#100; //read after certain delay
	 
	 initial
	  begin
	    @(!tb_reset); //Block till I am not out of reset
		repeat (5000) //read_fifo will be called 5 times.	
		begin
		@(posedge tb_clk); //this line is added after declaration of task write_fifo, coz in delclrn. tb_write_en signal of first 
	                       //repeat is '0' and that signal is being '1' in second repeat at same edge. so to differentiate 
						    //this, we added clock-delay.
		if($random%2 == 0)	
		read_fifo; //here no need of argument; coz we are not giving external input.
		end
	  end
	 /*repeat (10)
	 begin
	   @(posedge tb_clk);  //this line is added after declaration of task write_fifo, coz in delclrn. tb_write_en signal of first repeat is '0' and that signal
		if(tb_full != 1)				   //is being '1' in second repeat at same edge. so to differentiate this, we added clock-delay.
			write_fifo($random);
	 end*/
	 
	
   
 
task write_fifo; //we can't give argument in task declaration.
	input [DATA_SIZE-1:0]data; //we use this(input/output declaration) , instead of giving argument.
    begin
        tb_data_in = data;     //TASK DECLARATION IS DOING 2 THINGS:- 1.giving data given by argument of task-call to tb_data_in.
		                                                               //2.enabeling the write signal.
        $display("Write TB data is %h",tb_data_in);
        if(tb_full != 1)
		begin
			write_array[write_index] = data;
			write_index = write_index+ 1;
            tb_write_en = 1'b1;
		end	
        @(posedge tb_clk); //v. imp.  means.. wait for 1 posedge, we also used semicolon here ..coz its independt statement.
        tb_write_en = 0; //Down this signal after 1 clock edge. We are putting it down... coz we want to observe individual
		                  //observation of every write, if we would keep it always 1..we cant observe indivdly.
    end
endtask

task read_fifo;
    begin
       // $display("input TB data is %h",tb_data_in);
        if(tb_empty != 1)
            tb_read_en = 1'b1;
		else
			$display("FIFO empty !!!");
        
		@(posedge tb_clk);
        tb_read_en = 0;
		@(posedge tb_clk);
		if(tb_data_out_valid)  //we want to observe our output , only at valid-bit = 1..
			begin
				$display("Read value is %h",tb_data_out);
				read_array[read_index] = tb_data_out;
				read_index = read_index + 1;
			end
    end
endtask 
 initial
	begin
	   #(`TIMEOUT-2)
		$display("Reached here - Summing up !");
		for(integer i = 0;i< read_index;i = i + 1)
		 begin			
			if (write_array[i] == read_array[i])
				status = "PASS";
			else
			begin
				status = "FAIL";
				errors = errors + 1;
			end
			
			$display("write data = %h,read data = %h,%s",write_array[i],read_array[i],status);
		 end
		
		
	end
/*  initial
 while(1)
 $display("Time = %t",$time); */
 
 initial 
   begin
    #(`TIMEOUT)
	$display("Total errors:%d/%d",errors,read_index);
	$display("Time = %t,Reached here - finishing !",$time);
	$finish;
   end   

endmodule
