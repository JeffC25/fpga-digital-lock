`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2022 06:25:48 PM
// Design Name: 
// Module Name: seg_display
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


module seg_display(
    input clk,
    input rst,
    input [6:0] seg0,
    input [6:0] seg1,
    input [6:0] seg2,
    input [6:0] seg3,
    input [6:0] segStatus,
    output reg [6:0] display,
    output reg [7:0] digit
    );

    

    always @(posedge clk)
    begin
        if (rst == 1'b1)
        begin
            digit <= 8'b11111110;
            display <= 7'b1111111;

        end
        else
        case (digit)
            8'b11111110: 
            begin
                display <= seg0;
                digit <= 8'b11111101;
            end
            8'b11111101:
            begin
                display <= seg1;
                digit <= 8'b11111011;
            end
            8'b11111011:
            begin
                display <= seg2;
                digit <= 8'b11110111;
            end
            8'b11110111:
            begin
                display <= seg3;
                digit <= 8'b11101111;
            end
            8'b11101111:
            begin
                display <= segStatus;
                digit <= 8'b11011111;
            end
            8'b11011111:
            begin
                display <= 7'b1111111;
                digit <= 8'b10111111;
            end
            8'b10111111:
            begin
                display <= 7'b1111111;
                digit <= 8'b01111111;
            end
            8'b01111111:
            begin
                display <= 7'b1111111;
                digit <= 8'b11111110;
            end
            default: digit <= 8'b11111110;
        endcase
    end
           
endmodule
