class test2_t extends test_base_t;
  int op[] = '{RESET,FULL_WRITE,ALL_READ};
  function new();
    super.new();
  endfunction

  function void start();
    setup_sequence(op); 
  endfunction 
endclass