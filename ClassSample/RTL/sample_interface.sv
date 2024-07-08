interface sample_interface(input bit clk);
  logic reset,d,q;

  clocking cb  @(posedge clk);   endclocking
  clocking cbr @(posedge reset); endclocking
  
endinterface