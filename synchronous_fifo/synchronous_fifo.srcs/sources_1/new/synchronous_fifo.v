`timescale 1ns / 1ps

module synchronous_fifo(clk,reset,read_en,write_en,data_in,data_out,occupancy,empty,full);

parameter DATA_SIZE = 32;
parameter DEPTH  = 16; //Keeping depth less to see rollover early


input clk,reset;

//Write clock domain
input write_en;
input [DATA_SIZE - 1 : 0]data_in;
output full;

//Read clock domain
input read_en;
output reg [DATA_SIZE - 1 : 0]data_out;
output reg [$clog2(DEPTH) - 1 : 0]occupancy; //Great use of clog2
output reg empty;
//Test
initial
    repeat(10)
    begin
        data= random_data;
        @(posedge clk);
        write(data);
    end
task write(data);
begin
    if(tb_full !=0)
    begin
        tb_wren = 1'b1; //0ps
        data = 8'ha4;
        @(posedge clk);
        tb_wren = 1'b0; //0ps
     $display("Write transaction sent");
     end
     else:


endtask

syncfifo dut_inst(tb_wr);
endmodule
