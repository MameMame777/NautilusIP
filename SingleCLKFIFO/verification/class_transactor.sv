class fifo_transactor;
  rand logic  [31:0] data;
  //constructor
  function new();
  endfunction

  constraint data_range {
    data >= 32'h0000_0000;
    data <= 32'hFFFF_FFFF;
  }
endclass