class fifo_test_driver;
  virtual fifo_if ifc;
  mailbox mb;

  fifo_transactor transactor=new();
  
  function new(virtual fifo_if ifc );
    this.ifc = ifc;
  endfunction

  task setwren( input logic en);
    ifc.wr_en = en;
  endtask
  
  task setrden( input logic en);
    ifc.rd_en = en;
  endtask

  // データをFIFOに書き込むタスク
  task write(input int size);
    for (int i=0; i<size; i++)begin
      @(posedge ifc.clk);
      transactor.randomize();
      ifc.wr_data = transactor.data;
      ifc.wr_en = 1;
      mb.put(transactor.data);
      $display("Writing data to FIFO: %0h", ifc.wr_data);
    end
    ifc.wr_data = 0;
    ifc.wr_en = 0;
  endtask

  // FIFOからデータを読み出すタスク
  task read(output logic[31:0] data);
    ifc.rd_en = 1;
    #1; //wait for 1 clock cycle
    data = ifc.rd_data;
    $display("Reading data from FIFO: %0h", data);
    ifc.rd_en = 0;
  endtask
endclass 