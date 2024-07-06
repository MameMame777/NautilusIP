program SingleCLKFIFO_Assertion(fifo_if fifo);

  property test; @(posedge fifo.clk) 
    (fifo.wr_en && !fifo.full) |-> (fifo.wr_en && !fifo.full) ;    
  endproperty
  assert property (test); 
endprogram

bind SingleCLKFIFO SingleCLKFIFO_Assertion u_SingleCLKFIFO_Assertion(fifo);