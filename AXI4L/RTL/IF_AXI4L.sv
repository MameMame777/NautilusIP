interface IF_AXI4L (
  input  logic        ACLK,
  input  logic        ARESETN
);
  // Write Address Channel
  logic [31:0] AWADDR;
  logic [2:0]  AWPROT;
  logic        AWVALID;
  logic        AWREADY;

  // Write Data Channel
  logic [31:0] WDATA;
  logic [3:0]  WSTRB;
  logic        WVALID;
  logic        WREADY;

  // Write Response Channel
  logic [1:0]  BRESP;
  logic        BVALID;
  logic        BREADY;

  // Read Address Channel
  logic [31:0] ARADDR;
  logic [2:0]  ARPROT;
  logic        ARVALID;
  logic        ARREADY;

  // Read Data Channel
  logic [31:0] RDATA;
  logic [1:0]  RRESP;
  logic        RVALID;
  logic        RREADY;
  
  modport master (
    input  ACLK, ARESETN,
    output AWADDR, AWPROT, AWVALID, WDATA, WSTRB, WVALID, BREADY, ARADDR, ARPROT, ARVALID, RREADY,
    input  AWREADY, WREADY, BRESP, BVALID, ARREADY, RDATA, RRESP, RVALID
  );

  modport slave (
    input  ACLK, ARESETN,
    input  AWADDR, AWPROT, AWVALID, WDATA, WSTRB, WVALID, BREADY, ARADDR, ARPROT, ARVALID, RREADY,
    output AWREADY, WREADY, BRESP, BVALID, ARREADY, RDATA, RRESP, RVALID
  );

endinterface