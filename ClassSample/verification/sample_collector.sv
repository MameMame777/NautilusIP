class collector_t;
  virtual sample_interface vif;
  
  function new();
  endfunction

  function void set_vif(virtual sample_interface sif);
    vif = sif;
  endfunction

  task run();
    $display(" reset d q");
    fork
      forever@vif.cbr $display("%5d %1b %1b  *reset ",vif.reset,vif.d,vif.q);
      forever@vif.cb  $display("%5d %1b %1b         ",vif.reset,vif.d,vif.q);
    join
  endtask
endclass