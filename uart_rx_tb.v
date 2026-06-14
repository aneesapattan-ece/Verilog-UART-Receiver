module testbench;

reg clk;
reg reset;
reg rx;

wire [7:0] rx_data;
wire rx_done;

uart_rx uut(
    .clk(clk),
    .reset(reset),
    .rx(rx),
    .rx_data(rx_data),
    .rx_done(rx_done)
);

always #5 clk = ~clk;

initial
begin
    $dumpfile("dump.vcd");
    $dumpvars(0, testbench);

    clk = 0;
    reset = 1;
    rx = 1;       // Idle

    #10 reset = 0;

    // Start bit
    rx = 0; #10;

    // Data bits for 10101010 (LSB First)
    rx = 0; #10;   // D0
    rx = 1; #10;   // D1
    rx = 0; #10;   // D2
    rx = 1; #10;   // D3
    rx = 0; #10;   // D4
    rx = 1; #10;   // D5
    rx = 0; #10;   // D6
    rx = 1; #10;   // D7

    // Stop bit
    rx = 1; #10;

    #20;

    $finish;
end

endmodule