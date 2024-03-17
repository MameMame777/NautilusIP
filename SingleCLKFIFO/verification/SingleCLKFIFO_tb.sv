`timescale 1ns/1ps

module SingleCLKFIFO_tb;

  logic clk;
  logic reset;
  logic wr_en;
  logic rd_en;
  logic [31:0] wr_data;
  logic [31:0] rd_data;
  logic empty;
  logic full;
  logic valid;
  logic almost_full;

  clocking cb @(posedge clk);endclocking


  // Instantiate the SingleCLKFIFO
  fifo_if fifo_dut(clk,reset);

  SingleCLKFIFO u_SingleCLKFIFO(fifo_dut);
  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Test sequence
  initial begin
    $dumpfile("waveform.vcd");      
    $dumpvars(0, SingleCLKFIFO_tb); 
    // Initialize signals
    fifo_dut.wr_en = 0;
    fifo_dut.rd_en = 0;
    fifo_dut.wr_data = 0;

    // Apply reset
    #10 reset = 1;
    #10 reset = 0;

    // Write to FIFO
    #10 fifo_dut.wr_en = 1; fifo_dut.rd_en = 1;
    for (int i = 0; i < 255; i++) begin
      #10 fifo_dut.wr_data = i; fifo_dut.wr_en = 1;
    end
    fifo_dut.wr_en = 0;

    #2560;  // Wait for all data to be read
    // End of test
    $finish;
  end

endmodule