`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2022 05:09:23 PM
// Design Name: 
// Module Name: main_tb
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


module main_tb();

    reg clk;
    reg master_rst;
    reg enter;
    reg set_button;
    reg change;
    reg [3:0] switch;
    wire [1:0] status;
//    wire [6:0] seg0;
//    wire [6:0] seg1;
//    wire [6:0] seg2;
//    wire [6:0] seg3;
//    wire [6:0] segStatus;
    reg clear;
    wire [15:0] password;
    wire [15:0] master_password;
    wire [15:0] check_password;
    wire isSet;
    wire lock_rst;
    wire clk_slow;
    wire [4:0] index;
    wire [6:0] display;
    
    always #20 clk = ~clk;
    main gregory(clk, master_rst, enter, set_button, change, switch, clear, status, clk_slow, display, index, password, master_password, check_password, isSet, lock_rst);
   //main gregory(clk, master_rst, enter, set, change, switch, clear, status, password, master_password,check_password, isSet);
    
    initial begin
        set_button = 0;
        clk = 0;
        master_rst = 1;
        change = 0;
        clear = 0;
        
        #100 master_rst = 0;
        #75 switch = 4'b0101; enter = 1;
        #25 enter = 0;
        #75 switch = 4'b1001; enter = 1;
        #25 enter = 0;
        #75 switch = 4'b1010; enter = 1;
        #25 enter = 0;
        #75 switch = 4'b0001; enter = 1;
        #50 enter = 0;
        #50 clear = 1'b1;
        #50 clear = 1'b0;
        #75 switch = 4'b0101; enter = 1;
        #25 enter = 0;
        #75 switch = 4'b1001; enter = 1;
        #25 enter = 0;
        #75 switch = 4'b1010; enter = 1;
        #25 enter = 0;
        #75 switch = 4'b0001; enter = 1;
        #25 enter = 0;
        #50 set_button = 1;
        #50 set_button = 0;

        // now locked
        #75 switch = 4'b0101; enter = 1;
        #25 enter = 0;
        #75 switch = 4'b1001; enter = 1;
        #25 enter = 0;
        #75 switch = 4'b1010; enter = 1;
        #25 enter = 0;
        #75 switch = 4'b0001;enter = 1;
        #25 enter = 0;
        // unlocked not

        #50 switch = 4'b1111;
        #100 set_button = 1'b1;
        #100 set_button = 1'b0;
        //changed password
        
        //#250 master_rst = 1;
        #50 master_rst = 0;
 
    end

endmodule
