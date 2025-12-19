## FIFO_Synchronous
This project implements a parameterized synchronous FIFO (First-In First-Out) buffer in Verilog. The FIFO operates in a single clock domain and is designed for reliable data buffering between producer and consumer logic running on the same clock.


# Features
-> Parameterized FIFO depth and data width
-> Single-clock synchronous design
-> Circular buffer using modulo addressing
-> FULL and EMPTY status flags
-> Safe read/write operations with enable controls


# Parameter
-> DEPTH – Number of data entries the FIFO can store
-> DATA_WIDTH – Width of each data word


# Internal Operation
-> The FIFO uses a memory array of size DEPTH.
-> A write pointer (w_ptr) increments on each successful write.
-> A read pointer (r_ptr) increments on each successful read.
-> FULL is asserted when (w_ptr - r_ptr) == DEPTH.
-> EMPTY is asserted when w_ptr == r_ptr.
-> Data is always read in the same order it was written.


# Timing Diagram (Conceptual)
-> Reset asserted → FIFO becomes empty, pointers cleared.
-> Write operation (wr_en = 1, full = 0) → data stored, write pointer increments.
-> Read operation (rd_en = 1, empty = 0) → data appears on data_out, read pointer increments.
-> Simultaneous read/write → both pointers move, FIFO depth remains constant.


# Applications
-> Data buffering between pipeline stages
-> Producer–consumer interfaces
-> Temporary storage in digital systems
