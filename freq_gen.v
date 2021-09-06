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




module frequency_generator(clk_in,clk_out);

input clk_in; // 24Mhz Clock 
output clk_out;




reg [16:0] acc;

always @(posedge clk_in)

    acc <= acc +  2520; //460800 baud
wire clk_out= acc[16];
endmodule

