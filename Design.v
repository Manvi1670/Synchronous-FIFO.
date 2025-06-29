module synchronous_fifo #(
    parameter DEPTH = 8,
    parameter DATA_WIDTH = 8
)(
    input clk, rst_n,
    input w_en, r_en,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output full, empty
);

    // Initialize pointers to avoid 'x' states in simulation
    reg [$clog2(DEPTH):0] w_ptr = 0;
    reg [$clog2(DEPTH):0] r_ptr = 0;
    reg [DATA_WIDTH-1:0] fifo [0:DEPTH-1];

    always @(posedge clk) begin
        if (!rst_n) begin
            w_ptr <= 0;
            r_ptr <= 0;
            data_out <= 0;
        end else begin
            if (w_en && !full) begin
                fifo[w_ptr[$clog2(DEPTH)-1:0]] <= data_in;
                w_ptr <= w_ptr + 1;
            end
            if (r_en && !empty) begin
                data_out <= fifo[r_ptr[$clog2(DEPTH)-1:0]];
                r_ptr <= r_ptr + 1;
            end
        end
    end

    assign full = (w_ptr[$clog2(DEPTH)-1:0] == r_ptr[$clog2(DEPTH)-1:0]) &&
                  (w_ptr[$clog2(DEPTH)] != r_ptr[$clog2(DEPTH)]);
    assign empty = (w_ptr == r_ptr);

endmodule
