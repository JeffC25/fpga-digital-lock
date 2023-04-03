`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2022 04:25:42 PM
// Design Name: 
// Module Name: seg_status
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


module seg_status(
    input [1:0] status,
    output reg [6:0] seg
    );
    
    always @ (status)
    begin
        case (status)
        2'b00 : seg = 7'b1001111; // I = Initial
        2'b01 : seg = 7'b1110001; // L = Locked
        2'b10 : seg = 7'b1000001; // U = Unlocked
        default : seg = 7'b1111111;
        endcase
    end
endmodule
