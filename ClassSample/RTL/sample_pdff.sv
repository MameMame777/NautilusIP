module sample_pdff(
  input  logic clk,
  input  logic reset,
  input  logic d,
  output logic q
);
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 1'b0;
    end else begin
      q <= d;
    end
  end
endmodule