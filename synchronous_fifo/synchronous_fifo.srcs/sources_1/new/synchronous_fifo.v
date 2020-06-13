`timescale 1ns / 1ps

module synchronous_fifo(clk,reset,read_en,write_en,data_in,data_out,occupancy,empty,full);


parameter DATA_SIZE = 8;
parameter DEPTH  = 16; //Keeping depth less to see rollover early


input clk,reset;

//Write clock domain
input write_en;
input [DATA_SIZE - 1 : 0]data_in;
output reg full;

//Read clock domain
input read_en;
output reg [DATA_SIZE - 1 : 0]data_out;
output reg [$clog2(DEPTH) : 0]occupancy; //Great use of clog2
output reg empty;


reg [DATA_SIZE-1:0]mem[0:DEPTH-1];

wire write_permitted;
wire read_permitted;
reg [$clog2(DEPTH)-1:0]write_pointer;
reg [$clog2(DEPTH)-1:0]read_pointer;

assign write_permitted = (write_en && !full) || (write_en && full && read_en);
assign read_permitted = (read_en && !empty) || (read_en && empty && write_en);

always@(posedge clk,reset)
if (reset)
    begin
        data_out <= 0;
        occupancy  <= 0;
        empty  <= 0;
        full <= 0;
        write_pointer <=0;
        read_pointer <=0;
    end
else
    begin
        if(write_permitted)
            begin
                write_pointer <= write_pointer + 1;
                empty <= 0;
                mem[write_pointer] <= data_in; 
            end
        if(read_permitted)
            begin
             read_pointer <= read_pointer + 1;
             data_out <= mem[read_pointer];
            end
         
        occupancy <= DEPTH - write_pointer;
     
    end 

endmodule
