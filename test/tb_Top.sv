`timescale 1ns/1ps

module tb_Top;

    // Clock and reset
    logic clk = 0;
    logic reset = 1;

    // Instantiate your top-level CPU
    Top uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation: 100 MHz (10 ns period)
    always #5 clk = ~clk;

    initial begin
        // Generate VCD dump for GTKWave
        $dumpfile("build/wave.vcd");   // VCD file
        $dumpvars(0, tb_Top);          // Dump everything in tb_Top recursively

        // Reset pulse
        #20 reset = 0;

        // Run simulation for 1000 ns
        #1000 $finish;
    end

endmodule
