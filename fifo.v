`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.12.2025 13:16:45
// Design Name: 
// Module Name: fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps

module fifo #(
    parameter DEPTH = 8,
    parameter DATA_WIDTH = 8
)(
    input  clk,
    input  rst,          // Active-low reset
    input  wr_en,
    input  rd_en,
    input  [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output full,
    output empty
);

    // Memory array (DEPTH )
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Read & Write pointers
    reg [$clog2(DEPTH):0] w_ptr, r_ptr;

    // Status flags
    assign empty = (w_ptr == r_ptr);
    assign full  = ((w_ptr - r_ptr) == DEPTH);

    // Write operation
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            w_ptr <= 0;
        end
        else if (wr_en && !full) begin
            mem[w_ptr % DEPTH] <= data_in;
            w_ptr <= w_ptr + 1;
        end
    end

    // Read operation
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            r_ptr    <= 0;
            data_out <= 0;
        end
        else if (rd_en && !empty) begin
            data_out <= mem[r_ptr % DEPTH];
            r_ptr <= r_ptr + 1;
        end
    end

endmodule
