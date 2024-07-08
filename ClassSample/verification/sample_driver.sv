class driver_t;
  virtual sample_interface vif;
  sample_item item;
  
  function new();
    item = new;
  endfunction

  function void set_vif(virtual sample_interface sif);
    vif = sif;
  endfunction 

  task run(int max_item);
    repeat(max_item) begin
      @(negedge vif.clk);
      assert(item.randomize());
      vif.reset <= item.reset;
      vif.d     <= item.d;
      vif.reset  =#1 0;
    end
  endtask
endclass