class test1_t extends test_base_t;
  int op[] = '{
    RESET,
    WRITE,WRITE,WRITE,WRITE,
    WRITE,WRITE,WRITE,WRITE,
    WRITE,WRITE,WRITE,WRITE,
    READ,READ,READ,READ,
    READ,READ,READ,READ,
    READ,READ,READ,READ
  };
  function new();
    super.new();
  endfunction

  function void start();
    setup_sequence(op); 
  endfunction 
endclass