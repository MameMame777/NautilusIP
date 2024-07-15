interface fifo_if import pkg_definitions::*;  (input clk);
  logic             rst;
  logic             wr_en;
  logic [NBITS-1:0] wr_data;
  logic             rd_en;
  logic [NBITS-1:0] rd_data;
  logic             valid;
  logic             empty;
  logic             full;
  logic             almost_full;

  //default clocking procedure
  clocking cb  @(posedge clk);endclocking
  clocking cbr @(posedge rst);endclocking

  modport sender (
    input  rst,wr_en,wr_data,rd_en,
    output rd_data, valid,empty, full, almost_full
  ); 

  modport receiver (
    output  wr_en,wr_data,rd_en,
    input   rst,rd_data, valid,empty, full, almost_full
  );
  initial begin
    rst        =0;
    wr_en      =0;
    wr_data    =0;
    rd_en      =0;
    almost_full=0;
  end

endinterface