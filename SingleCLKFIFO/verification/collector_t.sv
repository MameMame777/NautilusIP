class collector_t extends component_base_t;
import pkg_definitions::*;
  extern task run();
  extern task collect_response();
  extern task collect_reset();
  extern function void print(string msg="");
endclass

task collector_t::run();
  
  $display("  TIME reset  wr_en, wr_data , rd_en , rd_data , valid , empty , full , almost_full command");
   
  fork
    collect_response;
    collect_reset;
  join
endtask


task collector_t::collect_response();
  string msg;
  forever begin
    @(vif.cb);
    if(vif.wr_en)
      msg = "WRITE";
    else if (vif.rd_en)
      msg = "READ";
    else
      msg = "NOP";
    print(msg);
    if($time > 10000) $fatal(0,"TESTCASE is Timeout");
  end
endtask

task collector_t::collect_reset();
  forever begin
    @(vif.cbr);
    if(vif.rst)
      print("RESET");
  end
endtask

function void collector_t::print(string msg="");
  $display("@%3t:  %04b    %04b  %08x  %04b  %08x  %04b  %04b %04b %04b %s", 
            $time, vif.rst, vif.wr_en, vif.wr_data, vif.rd_en, vif.rd_data, vif.valid,vif.empty,vif.full,vif.almost_full, msg);
endfunction 