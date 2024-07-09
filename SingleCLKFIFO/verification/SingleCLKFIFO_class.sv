package  SingleCLKFIFO_pkg;
`include "../../verification/class_transactor.sv"
`include "../../verification/class_fifo_test_driver.sv"




class fifo_test_monitor;
  virtual fifo_if ifc;
  event write_event;
  event read_event;
  function new(virtual fifo_if ifc);
    this.ifc = ifc;
    ->write_event;
    ->read_event;
  endfunction
  // FIFOの書き込みと読み出しを監視するタスク
  task run();
    int i=0;
    $display("Start monitor\n");
    forever begin
      @(posedge ifc.clk);
      if (ifc.wr_en) -> write_event ; // 書き込みイベントを通知
      if (ifc.rd_en) -> read_event ;  // 読み出しイベントを通知
    end
  endtask
endclass


class fifo_test_scoreboard;
  fifo_test_monitor monitor;
  mailbox mb;
  int  expected_data_queue[$]; // depth 10 期待されるデータのキュー
  int  received_data_queue[$]; // depth 10 受信したデータのキュー

  function new(fifo_test_monitor monitor,mailbox mb);
    this.monitor = monitor;
  endfunction
  // 期待されるデータをキューに追加
  task add_expected_data(logic[31:0] data);
    forever begin
      @(monitor.write_event) begin
        $display("Adding expected data %0h", data);
        expected_data_queue.push_back(data);
      end
    end
  endtask

  // 受信したデータをキューに追加
  task  add_received_data(monitor,logic[31:0] data);
    $display("Received data %0h", data);
    received_data_queue.push_back(data);
  endtask
  // 期待されるデータと受信したデータを比較
  task showmb();
    int data;
    mb.get(data);
    $display("Data in mailbox: %0h", data);
  endtask
  task check_data();
    if (expected_data_queue.size() != received_data_queue.size()) begin
      $display("*****Mismatch in number of data items: expected %0d, received %0d", expected_data_queue.size(), received_data_queue.size());
    end

    foreach (expected_data_queue[i]) begin
      if (expected_data_queue[i] !== received_data_queue[i]) begin
        $display("Data mismatch at index %0d: expected %0h, received %0h", i, expected_data_queue[i], received_data_queue[i]);
      end
    end

    $display("All data matched successfully.Size: expected %0d, received %0d\n ",expected_data_queue.size(), received_data_queue.size());
  endtask
  
endclass

endpackage 