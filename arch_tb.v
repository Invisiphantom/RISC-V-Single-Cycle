`timescale 1ns / 1ns
module arch_tb ();
	reg clk  ;
	reg PCrst;

	initial begin
		clk = 1'b0;
		forever
			#10 clk = ~clk;
	end

	initial begin
		#5 PCrst = 1'b1;
		#15 PCrst = 1'b0;
	end

	initial begin
		#1000 $finish;
	end



	arch u_arch(
		.clk   (clk   ),
		.PCrst (PCrst )
	);



	initial begin
		$dumpfile("wave.vcd");
		$dumpvars;
	end
endmodule