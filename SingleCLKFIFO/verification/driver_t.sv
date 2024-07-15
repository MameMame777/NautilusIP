class driver_t extends component_base_t;
import pkg_definitions::*;
  extern task run(test_base_t test);
  extern task driver_dut(simple_item_t item);
endclass

task driver_t::run(test_base_t test);
  simple_item_t item;
  forever begin
    item = test.next_item();
    if(item==null) break;
    driver_dut(item);
  end
endtask

task driver_t::driver_dut(simple_item_t item);
  if(item.rst) begin
    vif.rst = 1;
    @(vif.cb) vif.rst = 0;
  end else if(item.wr_en) begin
    vif.wr_en   <= 1 ;
    vif.wr_data <= item.wr_data;
    @(negedge vif.clk);
    vif.wr_en   <= 0;
    vif.wr_data <=0;
  end  else if(item.rd_en) begin
    vif.rd_en    <= 1 ;
    //vif.rd_data <= item.d;
    @(negedge vif.clk);
    vif.rd_en    <= 0 ;
  end else if(item.all_write) begin
    for(int i=0; i<255; i++)begin
      vif.wr_en   <= 1 ;
      vif.wr_data <= item.wr_data_256[i];
      vif.rd_en    <= 0 ;
      @(negedge vif.clk);
    end
  end else if(item.all_read) begin
    for(int i=0; i<255; i++)begin
      vif.wr_en   <= 0 ;
      vif.wr_data <= 0;
      vif.rd_en   <= 1 ;
      @(negedge vif.clk);
    end
  end else if(item.nop) begin
    vif.wr_en    <= 0 ;
    vif.rd_en    <= 0 ;
    @(negedge vif.clk);
  end else begin
    vif.wr_en    <= 0 ;
    vif.rd_en    <= 0 ;
    @(negedge vif.clk);
  end 
endtask