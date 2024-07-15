module top;
  import pkg::*;
  import pkg_definitions::*;
  
  bit clk;
  test_bench_t testbench;  
  fifo_if          sif(clk);
  SingleCLKFIFO    #(.NBITS(NBITS)) DUT(
      .clk(clk),
      .fifo(sif.sender)
    );
  initial begin
    testbench = new();
    testbench.run_test(sif);
  end
  initial forever #5 clk = ~clk;
endmodule 