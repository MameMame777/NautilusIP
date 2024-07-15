virtual class test_base_t ;
  import pkg_definitions::*;
  int op_sequence[];
  int index;

  extern         function      new();
  pure virtual   function void start();
  extern         function void setup_sequence(input int op[]);
  extern virtual function simple_item_t next_item();
  extern virtual function simple_item_t make_item(input int op);

endclass

function test_base_t::new();

endfunction

function void test_base_t::setup_sequence(input int op[]);
  op_sequence = op;
  index = 0;
endfunction 


function simple_item_t test_base_t::next_item( );
  if(index < op_sequence.size())begin 
    next_item = make_item(op_sequence[index++]);
  end else 
    next_item = null;
endfunction


function simple_item_t test_base_t::make_item(input int op);
  make_item = new();
  case (op)
    RESET : make_item.rst = 1;
    WRITE:begin
            make_item.wr_en = 1;
            make_item.rd_en = 0;
            make_item.wr_data = $urandom;
          end
    READ: begin
            make_item.wr_en = 0;
            make_item.rd_en = 1;
          end
    FULL_WRITE: begin
            make_item.all_write = 1;
            make_item.all_read  = 0;
            make_item.wr_data   = 0;
            for(int i =0; i<255; i++)begin
              make_item.wr_data_256[i] = $urandom;
            end
          end
    ALL_READ : begin
            make_item.all_write = 0;
            make_item.all_read  = 1;
          end
    NOP : begin
            make_item.wr_en = 0;
            make_item.rd_en = 0;
          end
    default: make_item.rst  = 0;
  endcase
endfunction

