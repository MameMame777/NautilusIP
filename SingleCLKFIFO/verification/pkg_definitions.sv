package pkg_definitions;
  parameter NBITS = 32;
  typedef enum {RESET, //FIFO reset operation
                WRITE, //FIFO write operation
                READ,  //FIFO read operation
                NOP   //No operation
                } FIFO_op_e;
endpackage
