class simple_item_t;
import pkg_definitions::*;
  logic             wr_en;
  logic [NBITS-1:0] wr_data;
  logic             rd_en;
  logic [NBITS-1:0] rd_data;
  logic             rst;   //FIFO reset
  logic             write; //FIFO write operation
  logic             read;  //FIFO read operation
  logic             nop;   //No operation
function  new();
  init();
endfunction


function void init();
  //op
  rst      = '0;
  write    = '0;
  read     = '0; 
  nop      = '0;
  //data
  wr_en    = '0;
  rd_en    = '0;
  wr_data  = '0;
  rd_data  = '0;
endfunction
endclass