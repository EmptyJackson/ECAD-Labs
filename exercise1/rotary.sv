// rotary decoder template

module rotary
  (
	input  wire clk,
	input  wire rst,
	input  wire [1:0] rotary_in,
	output logic [7:0] rotary_pos,
        output logic rot_cw,
        output logic rot_ccw
   );
	
	reg [1:0] db_in;
	reg active_input;

	debounce db_cw(.clk(clk), .rst(rst), .bouncy_in(rotary_in[0]), .clean_out(db_in[0]));
	debounce db_ccw(.clk(clk), .rst(rst), .bouncy_in(rotary_in[1]), .clean_out(db_in[1]));

	always_ff @(posedge clk or posedge rst)

		if (rst) begin
			rotary_pos <= 0;
			rot_cw <= 0;
			rot_ccw <= 0;
			active_input <= 0;		

		end else if (active_input) begin
			rot_cw <= 0;
			rot_ccw <= 0;
			if (db_in == 0)
				active_input <= 0;

		end else
			if (db_in[0]) begin
				rotary_pos <= rotary_pos + 1;
				rot_cw <= 1;
				active_input <= 1;
			end else if (db_in[1]) begin
				rotary_pos <= rotary_pos - 1;
				rot_ccw <= 1;
				active_input <= 1;
			end

endmodule // rotarydecoder
