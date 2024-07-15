class component_base_t;
virtual fifo_if vif;

function void setup_if(virtual fifo_if sif);
  vif = sif;
endfunction 

endclass