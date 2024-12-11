task print();
  $display("Hello from task");
endtask

task reset();
    ARESETN = 0;
    axi.AWVALID = 0;
    axi.WVALID = 0;
    axi.BREADY = 0;
    axi.ARVALID = 0;
    axi.RREADY = 0;
    repeat(20) begin @(cb);end
    ARESETN = 1;
    
endtask

task axi4lite_write(input [31:0] addr, input [31:0] data);
  const int timeout=10;
  int timecount=0;
  @(cb);
  axi.AWADDR = addr;
  axi.AWVALID = 1;
  @(cb);
  timecount=0;
  while (!axi.AWREADY)begin
    @(cb);
    timecount++;
    if(timecount>timeout)begin
      $display("Timeout in axi4lite_write AWchannel");
      break;
    end
  end
  @(cb);
  axi.AWVALID = 0;

  axi.WDATA = data;
  axi.WVALID = 1;
  @(cb);
  timecount=0;
  while (!axi.WREADY) begin
    @(cb);
    timecount++;
    if(timecount>timeout)begin
      $display("Timeout in axi4lite_write Wchannel");
      break;
    end
  end
  @(cb);
  axi.WVALID = 0;

  axi.BREADY = 1;
  timecount=0;
  while (!axi.BVALID)begin
    @(cb);
    timecount++;
    if(timecount>timeout)begin
      $display("Timeout in axi4lite_write Bready");
      break;
    end
  end
  @(cb);
  axi.BREADY = 0;
endtask


task axi4lite_read(input [31:0] addr, output [31:0] data);
  const int timeout=10;
  int timecount=0;
  @(cb);
  axi.ARADDR = addr;
  axi.ARVALID = 1;
  @(cb);
  timecount=0;
  while (!axi.ARREADY) begin
    @(cb);
    timecount++;
    if(timecount>timeout)begin
      $display("Timeout in axi4lite_read ARchannel");
      break;
    end
  end
  @(cb);
  axi.ARVALID = 0;

  axi.RREADY = 1;
  timecount=0;
  while (!axi.RVALID) begin
    @(cb);
    timecount++;
    if(timecount>timeout)begin
      $display("Timeout in axi4lite_read Rchannel");
      break;
    end
  end
  @(cb);
  data = axi.RDATA;
  axi.RREADY = 0;
endtask
