module top;
  driver_t driver; 
  collector_t collector;

  driver_t driver_2; 
  collector_t collector_2;
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
    disable fork;
    $display("change driver and collector");
    driver_2 = new();
    driver_2.set_vif(SIF);
    collector_2 = new();  
    collector_2.set_vif(SIF);
    fork
      driver_2.run(10);
      collector_2.run();  
    join_any
    $finish;
  end
endmodule