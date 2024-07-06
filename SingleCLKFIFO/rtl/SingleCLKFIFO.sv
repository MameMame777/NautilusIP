// ----------------------------------------------------------------------------
// File        : SingleCLKFIFO.sv
// Author      : MameMame
// Description : a single clock FIFO  width 32 and depth 256;
//               and can be write and read by debug interface 
// ----------------------------------------------------------------------------

module SingleCLKFIFO(fifo_if fifo); 
  
  //FIFO memory
  logic [31:0] mem [255:0];
  //FIFO pointer
  logic [8:0] wr_ptr; //carry bit for detect full
  logic [8:0] rd_ptr; //carry bit for detect full
  logic [7:0] diff_ptr;
  //FIFO status
  logic [7:0] cnt;
  //FIFO logic
  always_ff @(posedge fifo.clk )
  begin
    if(fifo.rst) begin
      wr_ptr <= 9'd0;
    end
    else begin
      if(fifo.wr_en && !fifo.full)
      begin
        mem[wr_ptr[7:0]] <= fifo.wr_data;
        wr_ptr <= wr_ptr + 1;
      end
    end
  end
  always_ff @(posedge fifo.clk) begin
    if(fifo.rst) begin
      rd_ptr <= 9'd0;
    end else begin
      if(fifo.rd_en && !fifo.empty)
      begin
        fifo.rd_data <= mem[rd_ptr[7:0]];
        rd_ptr <= rd_ptr + 1;
        fifo.valid <= 1;
      end
    end
  end
  //fifo status logic 
  always_comb begin
      fifo.empty = (rd_ptr == wr_ptr);
      fifo.full  = ((rd_ptr[7:0] == wr_ptr[7:0]) && (rd_ptr[8] != wr_ptr[8]));
  end
  //fifo almost full logic
  always_ff @(posedge fifo.clk) begin
    if(fifo.rst) begin
      cnt[7:0] <= 8'd0;
    end else begin
      case ({ fifo.wr_en, (cnt[7:0]==8'd255),fifo.rd_en,(cnt[7:0]==8'd0) }) inside
        4'b1000:begin cnt[7:0] <= cnt[7:0] + 1 ;end
        4'b1100:begin cnt[7:0] <= cnt[7:0]     ;end
        4'b0010:begin cnt[7:0] <= cnt[7:0] - 1 ;end
        4'b0011:begin cnt[7:0] <= cnt[7:0]     ;end
        4'b1?1?:begin cnt[7:0] <= cnt[7:0]     ;end
        default:begin cnt[7:0] <= cnt[7:0]     ;end
      endcase
    end
  end
  
endmodule

