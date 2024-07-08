module top;
  driver_t driver; 
  collector_t collector;
  bit clk;


  sample_interface SIF(clk);
  sample_pdff DUT(.clk(SIF.clk),.reset(SIF.reset),.d(SIF.d),.q(SIF.q));
  //generate clock  
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    //generate class instances and connect them to the interface by Virtual Interface
    driver = new();
    driver.set_vif(SIF);
    collector = new();  
    collector.set_vif(SIF);
    fork
      driver.run(10);
      collector.run();  
    join_any
    $finish;
  end
endmodule