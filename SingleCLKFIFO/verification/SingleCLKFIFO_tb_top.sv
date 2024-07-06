`timescale 1ns/1ps



module SingleCLKFIFO_tb;

  logic clk=0;
  logic reset;
  logic wr_en;
  logic rd_en;
  logic [31:0] wr_data;
  logic [31:0] rd_data;
  logic empty;
  logic full;
  logic valid;
  logic almost_full;

  // Instantiate the SingleCLKFIFO
  fifo_if fifo_dut(clk,reset);
  SingleCLKFIFO u_SingleCLKFIFO(fifo_dut);

  fifo_test_driver driver=new(fifo_dut);
  // Clock generation
  always begin
    #5 clk = ~clk;
  end
  //default clocking procedure
  default clocking cb @(posedge clk);endclocking

  // Test sequence
  initial begin
    // Initialize signals
    fifo_dut.wr_en = 0;
    fifo_dut.rd_en = 0;
    fifo_dut.wr_data = 0;

    // Apply reset
    ##1   reset = 1;
    ##3   reset = 0;
    // Write to FIFO
    ##5 
    driver.setwren(1); driver.setrden(1);
    for (int i = 0; i < 255; i++) begin
      ##1 fifo_dut.wr_data = i; fifo_dut.wr_en = 1;
    end
    driver.setwren(0); 

    ##500;  // Wait for all data to be read
    driver.setrden(0);
    // End of test
    $finish;
  end
  `ifndef DSIM
  //=========================
  // Waves
  //-------------------------
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, u_top);
  end
  `endif 

endmodule