`timescale 1ns/1ps

import SingleCLKFIFO_pkg::*;

`define test;
module SingleCLKFIFO_tb;

  mailbox mb;
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

  fifo_test_driver     driver    =new(fifo_dut);
  fifo_test_monitor    monitor   =new(fifo_dut);
  fifo_test_scoreboard scoreboard=new(monitor,mb);
  fifo_transactor      transactor=new();
  
  // Clock generation
  always begin
    #5 clk = ~clk;
  end
  // モニターからのイベントを待機し、スコアボードにデータを追加
  //default clocking procedure
  default clocking cb @(posedge clk);endclocking
  
  // Test sequence
  initial begin
    mb = new (30);
    // Initialize signals
    fifo_dut.wr_en = 0;
    fifo_dut.rd_en = 0;
    fifo_dut.wr_data = 0;
    // Apply reset
    ##1   reset = 1;
    ##3   reset = 0;
    fork
      begin
        monitor.run();
        @(monitor.write_event) $display("det write event\n");//scoreboard.add_expected_data(wr_data);
      end
      driver.write(10); // 書き込み有効化
      // End of test
    join_none
    ##100
    scoreboard.check_data(); // データのチェックを実行
    scoreboard.showmb();
     
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