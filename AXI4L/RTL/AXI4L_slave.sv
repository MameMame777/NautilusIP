module AXI4L_slave (
  input  logic        ACLK,
  input  logic        ARESETN,
  output logic [31:0] reg_data1,
  output logic [31:0] reg_data2,
  
  IF_AXI4L.slave  axi
  
);
  logic aw_handshake;
  logic w_handshake;
  logic [31:0] reg_adrs;
  // Write Address Channel
  always_ff @(posedge ACLK or negedge ARESETN) begin
    if (!ARESETN) begin
      axi.AWREADY <= 0;
      aw_handshake <= 0;
      w_handshake <= 0;
    end else begin
      if (axi.AWVALID && !axi.AWREADY) begin
        axi.AWREADY <= 1;
        reg_adrs[31:0] <= axi.AWADDR;
        aw_handshake <= 1;
      end else if (axi.AWVALID && axi.AWREADY) begin
        axi.AWREADY <= 0;
      end
    end
  end

  // Write Data Channel
  always_ff @(posedge ACLK or negedge ARESETN) begin
    if (!ARESETN) begin
      axi.WREADY <= 0;
      w_handshake <= 0;
    end else begin
      if (axi.WVALID && !axi.WREADY) begin
        axi.WREADY <= 1;
        w_handshake <= 1;
        case (reg_adrs)
          `reg_addr1: reg_data1 <= axi.WDATA;
          `reg_addr2: reg_data2 <= axi.WDATA;
        endcase
      end else if (axi.WVALID && axi.WREADY) begin
        axi.WREADY <= 0;
      end
    end
  end

  // Write Response Channel
  always_ff @(posedge ACLK or negedge ARESETN) begin
    if (!ARESETN) begin
      axi.BVALID <= 0;
      axi.BRESP <= 2'b00;
    end else begin
      if (aw_handshake && w_handshake) begin
        axi.BVALID <= 1;
        axi.BRESP <= 2'b00; // OKAY response
        aw_handshake <= 0;
        w_handshake <= 0;
      end else if (axi.BREADY && axi.BVALID) begin
        axi.BVALID <= 0;
      end
    end
  end

  // Read Address Channel
  always_ff @(posedge ACLK or negedge ARESETN) begin
    if (!ARESETN) begin
      axi.ARREADY <= 0;
    end else begin
      if (axi.ARVALID && !axi.ARREADY) begin
        axi.ARREADY <= 1;
      end else if (axi.ARVALID && axi.ARREADY) begin
        axi.ARREADY <= 0; // デアサート
      end
    end
  end

  // Read Data Channel
  always_ff @(posedge ACLK or negedge ARESETN) begin
    if (!ARESETN) begin
      axi.RVALID <= 0;
      axi.RRESP <= 2'b00;
      axi.RDATA <= 32'b0;
    end else begin
      if (axi.ARREADY && axi.ARVALID) begin
        axi.RVALID <= 1;
        axi.RRESP <= 2'b00; // OKAY response
        case (axi.ARADDR)
          `reg_addr1: axi.RDATA <= reg_data1;
          `reg_addr2: axi.RDATA <= reg_data2;
        endcase
      end else if (axi.RREADY && axi.RVALID) begin
        axi.RVALID <= 0;
      end
    end
  end

endmodule