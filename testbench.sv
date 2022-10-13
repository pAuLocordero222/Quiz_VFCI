`include "uvm_macros.svh"
import uvm_pkg::*;
`include "dut.sv"
`include "driver.sv"
`include "interface.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "Agent.sv"
`include "sequence.sv"
`include "environment"
`include "test.sv"

module testbench;
    reg clk;

    always #10 clk = ~clk;
    dut_if _if (clk);

    det_1011 u0 (.clk(clk), .rstn(_if.rstn), .in(_if.in), .out(_if.out));


    initial begin
        clk <= 0;
        uvm_config_db #(virtual dut_if)::set(null, "uvm_test_top", "dut_if", _if);
        run_test("test1");

    end

endmodule