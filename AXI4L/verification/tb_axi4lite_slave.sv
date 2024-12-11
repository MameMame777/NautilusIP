module tb_top;
  //signal declaration
  logic        ACLK;
  logic        ARESETN;
  logic [31:0] reg_data;
  IF_AXI4L  axi(ACLK, ARESETN);
  clocking cb @(posedge ACLK);
  endclocking

  //task include
  `include "task_axi4Lite.sv"

  AXI4L_slave uut (
    .ACLK(ACLK),
    .ARESETN(ARESETN),
    .axi(axi)
  );

  // Clock generation
  initial begin
    ACLK = 0;
    forever #5 ACLK = ~ACLK;
  end


  // Test sequence
  initial begin
    reset();
    // Write transaction
    axi4lite_write(32'h00000004, 32'hDEADBEEF);
    axi4lite_write(32'h00000008, 32'hCAFEBABE);
    //// Read transaction
    axi4lite_read(32'h00000004, reg_data);
    $display("reg_data = %h", reg_data);  
    axi4lite_read(32'h00000008, reg_data);
    $display("reg_data = %h", reg_data);
    #100;
    $finish;
  end

endmodule