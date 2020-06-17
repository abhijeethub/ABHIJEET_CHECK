`timescale 1ns / 1ps



module experiment(out, a, b);
	
	output out;
	input a,b;
	
	wire out;
	reg a=1,b=1;
	
assign out = a & b;

initial //always keep display inside initial-block.
begin
    $display("output is %b",out);
end
final
begin
$display("Within FINAL block\n");
end

initial
begin
#400 $finish();
end

endmodule
