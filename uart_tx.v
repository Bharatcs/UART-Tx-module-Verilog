/*
Copyright 2021 Bharat

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


*/


module uart_tx(
input clk,            // System Clock 
input  baud_clk,      // Baud Clock   
input  txd_start,     // Set bit to start 
input [7:0] byte_in,  // Byte to transmit
output bit_out,       // UART TX-bit 
output reg done =1'b1 // UART transmission status   1--- done ; 0 -- Busy 
);


reg [3:0] state; // state variable
reg tx_bit;



always @(posedge baud_clk)
begin
if(~done) begin   
            case (state)
                4'b0000: state <=4'b0100;
                4'b0100:state <=4'b1000; // start bit
                4'b1000:state <=4'b1001; // bit 0
                4'b1001:state <=4'b1010; // bit 1
                4'b1010:state <=4'b1011; // bit 2
                4'b1011:state <=4'b1100; // bit 3
                4'b1100:state <=4'b1101; // bit 4
                4'b1101:state <=4'b1110; // bit 5
                4'b1110:state <=4'b1111; // bit 6
                4'b1111:state <=4'b0001; // bit 7
                4'b0001:state <=4'b0010; // 1 stop bit  
                4'b0010:begin  state <=4'b0000;
                    done <=1;
                end //  stop bit 2
                default:state <=4'b0000;
            endcase
end  
else if(txd_start) begin
    done <=1'b0;
end
  


end


always @(posedge clk)
begin
case (state)
    4'b0000: tx_bit <=1;
    4'b0100: tx_bit <=0;          // start bit
    4'b1000: tx_bit <=byte_in[0]; // bit 0
    4'b1001: tx_bit <=byte_in[1]; // bit 1
    4'b1010: tx_bit <=byte_in[2]; // bit 2
    4'b1011: tx_bit <=byte_in[3]; // bit 3
    4'b1100: tx_bit <=byte_in[4]; // bit 4
    4'b1101: tx_bit <=byte_in[5]; // bit 5
    4'b1110: tx_bit <=byte_in[6]; // bit 6
    4'b1111: tx_bit <=byte_in[7]; // bit 7
    4'b0001: tx_bit <=1;          // 1 stop bit  
    4'b0010: tx_bit <=1;
    default: tx_bit <=1;
endcase
end


assign bit_out =  tx_bit  ;  
endmodule