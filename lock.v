`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2022 02:58:16 PM
// Design Name: 
// Module Name: lock
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


module lock(
    input clk,
    input rst,
    input enter,
    input set_button,
    input [3:0] switch,
    output reg [15:0] password,
    output reg isSet
    );
    
    reg [4:0] state;
    
    always @(posedge clk)
        begin       
        if (rst == 1'b1)
            begin
            state <= 3'b000; //initial state
            password <= 16'b0000000000000000;  // high impedance password
            //isSet <= 1'b0;     // no password set
            end           
        else 
            case (state)            
            3'b000: // initial state (no input)
                begin
                    //password <= 16'b0000000000000000;
                    if (enter == 1'b1) 
                        begin
                        password[3:0] <= switch;
                        state <= 3'b001;
                        end
                    else
                        state <= 3'b000; 
                end                 
            3'b001: // 1 digit set
                if (enter == 1'b1)
                    begin
                    password[7:4] <= switch;
                    state <= 3'b010;
                    end
                else
                    state <= 3'b001;                    
            3'b010: // 2 digits set
                if (enter == 1'b1)
                    begin
                    password[11:8] <= switch;
                    state <= 3'b011;
                    end
                else
                    state <= 3'b010;             
            3'b011: // 3 digits set
                if (enter == 1'b1)
                    begin
                    password[15:12] <= switch;
                    state <= 3'b100;
                    end
                else
                    state <= 3'b011;   
            //3'b100:
                //isSet <= (set_button) ? 1'b1 : 1'b0;
                /*if (set_button == 1'b1)
                begin
                    isSet <= 1'b1;
                    state <= 3'b000;
                end      
                else
                    state <= 3'b100;   */  
            default: state <= 3'b100; 
            endcase
                 
        end    
     
endmodule
