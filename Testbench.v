module sync_fifo_TB;

  parameter DATA_WIDTH = 8;

  reg clk, rst_n;
  reg w_en, r_en;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;
  wire full, empty;

  // Verilog memory array
  reg [DATA_WIDTH-1:0] wdata_mem [0:255];  // max 256 values
  integer write_idx = 0;
  integer read_idx = 0;

  synchronous_fifo s_fifo (
    .clk(clk), .rst_n(rst_n),
    .w_en(w_en), .r_en(r_en),
    .data_in(data_in),
    .data_out(data_out),
    .full(full), .empty(empty)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Write process
  initial begin
    clk = 1'b0;
    rst_n = 1'b0;
    w_en = 1'b0;
    data_in = 8'b0;

    // Reset for some cycles
    repeat(10) @(posedge clk);
    rst_n = 1'b1;

    repeat(2) begin
      integer i;
      for (i = 0; i < 30; i = i + 1) begin
        @(posedge clk);
        w_en = (i % 2 == 0) ? 1'b1 : 1'b0;
        if (w_en && !full) begin
          data_in = $random;
          wdata_mem[write_idx] = data_in;
          write_idx = write_idx + 1;
        end
      end
      #50;
    end
  end

  // Read process
  initial begin
    r_en = 1'b0;
    // Delay to start reading after some writes
    repeat(20) @(posedge clk);
    rst_n = 1'b1;

    repeat(2) begin
      integer i;
      for (i = 0; i < 30; i = i + 1) begin
        @(posedge clk);
        r_en = (i % 2 == 0) ? 1'b1 : 1'b0;
        if (r_en && !empty) begin
          #1;  // small delay to ensure data is valid
          if (data_out !== wdata_mem[read_idx]) begin
            $display("ERROR at time %0t: Expected = %h, Got = %h", $time, wdata_mem[read_idx], data_out);
          end else begin
            $display("PASS at time %0t: Data = %h", $time, data_out);
          end
          read_idx = read_idx + 1;
        end
      end
      #50;
    end

    $finish;
  end

  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end

endmodule
