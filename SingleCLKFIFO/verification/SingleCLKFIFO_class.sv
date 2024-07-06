class fifo_test_driver;
  virtual fifo_if ifc;

  function new(virtual fifo_if ifc);
    this.ifc = ifc;
  endfunction
  
  task setwren( input logic en);
    ifc.wr_en = en;
  endtask
  
  task setrden( input logic en);
    ifc.rd_en = en;
  endtask

endclass 

