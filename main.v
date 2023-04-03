module main(
    input clk,
    input master_rst,
    input enter,
    input set_button,
    input change,
    input [3:0] switch,
    input clear,
//    output reg [1:0] status, //00 intitial, 01 locked, 10 unlocke
    output clk_slow,
    output [6:0] display,
    output [7:0] index
//    output [15:0] password,
//    output reg [15:0] master_password,
//    output reg [15:0] check_password,
//    output isSet,
//    output reg lock_rst
    );
    
    wire isSet;
    reg lock_set;
    reg lock_rst;
    
    wire [15:0] password;
    reg [15:0] master_password;
    reg [15:0] check_password;
    
    reg [1:0] status;
    
    wire clk_out;
    
    wire [6:0] seg0;
    wire [6:0] seg1;
    wire [6:0] seg2;
    wire [6:0] seg3;
    wire [6:0] segStatus;
    
    wire enter_clean;
    wire set_clean;
    
    clk_divider clock(clk, master_rst, clk_slow);   // clock divider
    clk_divider_faster clock2(clk, master_rst, clk_out); 
    
    lock locker(clk_slow, lock_rst, enter, set_clean, switch, password, isSet);
    debouncer enter_deb(clk_slow, master_rst, enter, enter_clean);     // debouncer for enter button
    //debouncer set_deb(clk_slow, master_rst, set_button, set_clean);           // debouncer for set button
    
    seg_digit display0(.digit(password[3:0]), .seg(seg0));
    seg_digit display1(.digit(password[7:4]), .seg(seg1));
    seg_digit display2(.digit(password[11:8]), .seg(seg2));
    seg_digit display3(.digit(password[15:12]), .seg(seg3));
    seg_status display4(status, segStatus);
    
    seg_display displayMain(clk_out, master_rst, seg0, seg1, seg2, seg3, segStatus, display, index);
    
    always @(posedge clk_slow or negedge master_rst)
    begin
        if (master_rst == 1'b1)
        begin
            lock_rst <= 1'b1;
            status <= 2'b00;
        end
        else
        begin
            case (status)
                2'b00:  //initial
                begin
                    lock_rst <= clear;
                    //lock_rst <= master_rst;   //starts lock
                    //lock_set <= set_clean;
                    if (set_button == 1'b1)
                    begin
                        master_password <= password;    // sets master password
                        lock_rst <= 1'b1;   // resets lock
                        status <= 2'b01;    // locks system
                    end       
                end
                2'b01:  //locked
                begin
                    if (lock_rst == 1'b0)
                        check_password <= password; // inputs password  
                    lock_rst <= 1'b0;   //starts lock         
                    if (clear == 1'b1)
                        lock_rst <= 1'b1;
                    if (check_password == master_password)  // checks inputted password with master password
                    begin
                        status <= 2'b10; //unlocks system
                        lock_rst <= 1'b1;
                    end
                end
                2'b10:  // unlocked
                begin
                    lock_rst <= 1'b0;
                    if (change == 1'b1)
                    begin
                        lock_rst <= 1'b1;   // reset lock
                        status <= 2'b00; // back to initial status
                    end
                    else if (set_button == 1'b1)
                    begin
                        check_password <= 16'b0000000000000000;
                        status <= 2'b01; // locks system again
                    end
                end
            endcase
        end
    end
    
endmodule