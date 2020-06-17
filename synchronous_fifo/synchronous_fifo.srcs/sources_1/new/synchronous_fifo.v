//`timescale 1ns / 1ns

module synchronous_fifo(clk,reset,read_en,write_en,data_in,data_out,data_out_valid,available_entries,empty,full);


parameter DATA_SIZE = 32;
parameter DEPTH  = 16; //Keeping depth less to see rollover early


input clk,reset;

//Write clock domain
input write_en;
input [DATA_SIZE - 1 : 0]data_in;
output  full;

//Read clock domain
input read_en;
output reg [DATA_SIZE - 1 : 0]data_out;
output reg data_out_valid;
output  [$clog2(DEPTH) : 0]available_entries; //Great use of clog2
output  empty;


reg [DATA_SIZE-1:0]mem[0:DEPTH-1];

wire write_permitted;
wire read_permitted;
reg [$clog2(DEPTH)-1:0]write_pointer;
reg [$clog2(DEPTH)-1:0]read_pointer;
reg roll_over;

//extra code for status register
/*reg [7:0]status_register;

// 7 - Full
// 6 - Empty
// 5 - x
// 4:0 - Available entries
assign status_register[7] = full;
assign status_register[6] = empty;
assign status_register[4:0] = available_entries;*/

assign write_permitted = (write_en && !full);// || (write_en && full && read_en);
assign read_permitted = (read_en && !empty);// || (read_en && empty && write_en);
assign available_entries = roll_over ? (read_pointer - write_pointer) : (DEPTH - (write_pointer - read_pointer)); 
                                                        //write_pointer - read_pointer will give occupied region.

                   //it will not come inside always block; coz it should be clock independent,
				   //so that available_entries would be independent
				   //of clock
//Empty and Full flags
assign empty = (write_pointer - read_pointer ==0) && !roll_over; //visualize and draw...take time
assign full =  (write_pointer - read_pointer ==0) && roll_over; //visualize and draw..take time
                                                            //read cant lead by write pointer even in roll-over condition.

always@(posedge clk,posedge reset)
if (reset)
    begin
        data_out <= 0;
		data_out_valid <= 0;
        write_pointer <=0;
        read_pointer <=0;
		roll_over <= 1'b0;
    end
else
    begin
		//Read-Write in same cycle
		if(write_permitted && read_permitted)
			begin
				write_pointer <= write_pointer + 1;
                mem[write_pointer] <= data_in;
				read_pointer <= read_pointer + 1;
                data_out <= mem[read_pointer];
				data_out_valid <= 1'b1; //Akshay
				
				if(write_pointer == DEPTH-1 && read_pointer != (DEPTH-1) )//way to handel roll-over.
					roll_over <= 1'b1; //above if contain only this statement, coz we didnt use 'begin-end'.
					
				if(read_pointer == DEPTH-1 && write_pointer !=(DEPTH-1)) //
					roll_over <= 1'b0;//above if contain only this statement, coz we didnt use 'begin-end'.
					                   //its not possbl that, read will roll_over and write will not roll-over.
					
                                      //if both read and write pointer will roll over, we will set rol_over = 0;
									   //coz its like original condition.

			end
        //Exclusive Write section
		else if(write_permitted && !read_permitted)
            begin
				
                write_pointer <= write_pointer + 1;
                mem[write_pointer] <= data_in; 
				if(write_pointer == DEPTH-1)//way to handel roll-over.
					roll_over <= 1'b1; //above if contain only this statement, coz we didnt use 'begin-end'.
				data_out_valid <= 1'b0; 	                     
            end
		//Exclusive Read Section
        else if(read_permitted && !write_permitted)
			begin
			if(read_pointer == DEPTH-1) //
					roll_over <= 1'b0;//above if contain only this statement, coz we didnt use 'begin-end'.
					                   //its not possbl that, read will roll_over and write will not roll-over.
					
                                      //if both read and write pointer will roll over, we will set rol_over = 0;
									   //coz its like original condition.
			 read_pointer <= read_pointer + 1;
             data_out <= mem[read_pointer];
			 data_out_valid <= 1'b1; //whenever there is data_out we use valid-bit to differentiate between 'actual data'
										//and 'null data' or 'unwanted previous data' .
            end
		else
			data_out_valid <= 1'b0; 
    end 

endmodule
