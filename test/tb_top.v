`timescale 1ns/1ps

module tb_top;

    // Clock and reset
    reg clk = 0;
    reg reset = 1;

    // Instantiate your top-level CPU
    top uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation: 100 MHz (period = 10ns)
    always #5 clk = ~clk;

    initial begin
        // Generate VCD dump for GTKWave
        $dumpfile("build/wave.vcd");   // VCD file
        $dumpvars(0, tb_top);          // Dump everything in tb_top recursively

        // Reset pulse
        #20 reset = 0;

        // Run simulation for 1000 ns (adjust as needed)
        #1000 $finish;
    end

endmodule
