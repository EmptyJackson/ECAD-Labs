module tlight(input logic clk,
              output logic r,
              output logic a,
              output logic g);

logic [2:0] state;

always_ff @(posedge clk)
  if(state[2])
    if(state[1])
      state <= 3'b001;
    else
      state <= 3'b110;
  else
    if(state[1])
      state <= 3'b100;
    else
      state <= 3'b010;

assign g = state[0];  
assign a = state[1];  
assign r = state[2]; 
endmodule // tlights
