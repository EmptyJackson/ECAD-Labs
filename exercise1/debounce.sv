// debounce template

module debounce
  (
	input wire       clk,       // 50MHz clock input
	input wire       rst,       // reset input (positive)
	input wire       bouncy_in, // bouncy asynchronous input
	output reg 		 clean_out  // clean debounced output
   );

        reg prev_bouncy ;
	reg [ 15 : 0 ] counter ;

	always_ff @(posedge clk or posedge rst)
		if (rst) begin
			clean_out <= 0;
			prev_bouncy <=0;
			counter <= 0;
		end else
			if (bouncy_in == prev_bouncy)
				if (counter < (16'd1000000))	// Min number of consecutive constant signals to set clean value;
					counter <= counter + 1;
				else
					clean_out <= bouncy_in;
			else begin
				prev_bouncy <= bouncy_in;
				counter <= 1;
			end
		
   
endmodule // debounce
