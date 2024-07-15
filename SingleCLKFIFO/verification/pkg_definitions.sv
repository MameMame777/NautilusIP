package pkg_definitions;
  parameter NBITS = 32;
  typedef enum {RESET, //FIFO reset operation
                WRITE, //FIFO write operation
                READ,  //FIFO read operation
                FULL_WRITE, //FIFO write operation unitl full
                ALL_READ,   //Read all the data in the FIFO
                NOP   //No operation
                } FIFO_op_e;
endpackage
