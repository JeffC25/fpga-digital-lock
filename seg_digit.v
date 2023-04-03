`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2022 04:17:18 PM
// Design Name: 
// Module Name: seg_digit
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


module seg_digit(
    input [3:0] digit,
    output reg [6:0] seg
    );
    
    always @ (digit)
    begin
        case (digit)
            4'b0000 : seg = 7'b0000001; // 0
            4'b0001 : seg = 7'b1001111; // 1
            4'b0010 : seg = 7'b0010010; // 2
//            4'b0000 : seg = 7'b1001111; // I = Initial
//            4'b0001 : seg = 7'b1110001; // L = Locked
//            4'b0010 : seg = 7'b1000001; // U = Unlocked
            4'b0011 : seg = 7'b0000110; // 3
            4'b0100 : seg = 7'b1001100; // 4
            4'b0101 : seg = 7'b0100100; // 5
            4'b0110 : seg = 7'b0100000; // 6
            4'b0111 : seg = 7'b0001111; // 7
            4'b1000 : seg = 7'b0000000; // 8
            4'b1001 : seg = 7'b0000100; // 9
            4'b1010 : seg = 7'b0001000; // A
            4'b1011 : seg = 7'b1100000; // B
            4'b1100 : seg = 7'b0110001; // C
            4'b1101 : seg = 7'b1000010; // D
            4'b1110 : seg = 7'b0110000; // E
            4'b1111 : seg = 7'b0111000; // F
            default: seg = 7'b1111111;
        endcase
    end
    
endmodule
