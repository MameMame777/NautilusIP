program SingleCLKFIFO_Assertion(input clk, fifo_if.sender fifoif);

  property test; @(posedge clk) 
    (fifoif.wr_en && !fifoif.full) |-> (fifoif.wr_en && !fifoif.full) ;    
  endproperty
  assert property (test); 
endprogram

bind SingleCLKFIFO SingleCLKFIFO_Assertion u_SingleCLKFIFO_Assertion(clk,fifo);