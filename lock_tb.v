`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2022 04:12:33 PM
// Design Name: 
// Module Name: lock_tb
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


module lock_tb();
    
    reg clk;
    reg rst;
    reg enter;
    reg set;
    reg [3:0] switch;
    wire [15:0] password;
    wire isSet;
    
    always #25 clk = ~clk;
    lock locking(clk, rst, enter, set, switch, password, isSet);
    
    initial begin
        rst = 1;
        clk = 0;
        #50 rst = 0;
        #50 switch = 4'b0101; enter = 1;
        #50 switch = 4'b1001;
        #50 switch = 4'b1010;
        #50 switch = 4'b0001;
        #50 set = 1;
        #50 set = 0;// enter = 0;
        #450 rst = 1;
    end
    
endmodule
