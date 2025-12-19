
`timescale 1ns / 1ps

module fifo_tb;

    parameter DEPTH = 8;
    parameter DATA_WIDTH = 8;

    reg clk;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;
    wire full;
    wire empty;

    // Instantiate FIFO
    fifo #(
        .DEPTH(DEPTH),
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 0;
        wr_en = 0;
        rd_en = 0;
        data_in = 0;

        // Reset
        #10 rst = 1;

        // Write data into FIFO
        repeat (DEPTH) begin
            @(posedge clk);
            wr_en = 1;
            data_in = data_in + 8'h1;
        end
        wr_en = 0;

        // Read data from FIFO
        repeat (DEPTH) begin
            @(posedge clk);
            rd_en = 1;
        end
        rd_en = 0;

        // Finish simulation
        #20 $finish;
    end

endmodule