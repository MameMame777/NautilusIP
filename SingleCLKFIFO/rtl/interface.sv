interface fifo_if (input clk, input rst);
  logic        wr_en;
  logic [31:0] wr_data;
  logic        rd_en;
  logic [31:0] rd_data;
  logic        valid;
  logic        empty;
  logic        full;
  logic        almost_full;

  //default clocking procedure
  default clocking cb @(posedge clk);endclocking

  modport sender (
    input  wr_en,wr_data,
    output rd_en, rd_data, valid,empty, full, almost_full
  );

  modport receiver (
    output  wr_en,wr_data,
    input   rd_en, rd_data, valid,empty, full, almost_full
  );

endinterface