`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.05.2018 00:03:36
// Design Name: 
// Module Name: led_blink_top
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
////////////////////////////////////////////////////////
//
//  Name: led_blink_top.value
//  Author : Tamer Gudu
//  Date   : 25.04.17
//
////////////////////////////////////////////////////////

module led_blink_top (
input        clk,
input        reset,
output     [3:0]led_out);

wire	[11:0]	address;
wire	[17:0]	instruction;
wire			bram_enable;
wire	[7:0]	port_id;
wire	[7:0]	out_port;
wire	[7:0]   in_port;
wire			write_strobe;
wire			k_write_strobe;
wire			read_strobe;
wire            interrupt;            //See note above
wire			interrupt_ack;
wire			kcpsm6_sleep;         //See note above
wire			kcpsm6_reset;         //See note above
reg             led_out_0;
reg             led_out_1;
reg             led_out_2;
reg             led_out_3;
wire            rdl;


  kcpsm6 #(
	.interrupt_vector	(12'h3FF),
	.scratch_pad_memory_size(64),
	.hwbuild		(8'h00))
  processor (
	.address 		(address),
	.instruction 	(instruction),
	.bram_enable 	(bram_enable),
	.port_id 		(port_id),
	.write_strobe 	(write_strobe),
	.k_write_strobe (k_write_strobe),
	.out_port 		(out_port),
	.read_strobe 	(read_strobe),
	.in_port 		(in_port),
	.interrupt 		(interrupt),
	.interrupt_ack 	(interrupt_ack),
	.reset 		    (kcpsm6_reset),
	.sleep		    (kcpsm6_sleep),
	.clk 			(clk)); 

 led_blink #(
	.C_FAMILY		   ("7S"),   	//Family 'S6' or 'V6'
	.C_RAM_SIZE_KWORDS	(1),  	//Program size '1', '2' or '4'
	.C_JTAG_LOADER_ENABLE	(0))  	//Include JTAG Loader when set to '1' 
  program_rom (    				//Name to match your PSM file
 	.rdl 			(rdl),
	.enable 		(bram_enable),
	.address 		(address),
	.instruction 	(instruction),
	.clk 			(clk));

  assign kcpsm6_sleep = 1'b0;
  assign interrupt = 1'b0;
  assign kcpsm6_reset = reset;
  assign led_out[0] = led_out_0;
  assign led_out[1] = led_out_1;
  assign led_out[2] = led_out_2;
  assign led_out[3] = led_out_3;
  assign in_port = 8'b0;
  

  always @ (posedge clk)
  begin

      // 'write_strobe' is used to qualify all writes to general output ports.
      if (write_strobe == 1'b1) begin

        // Write to output_port_w at port address 01 hex
        if (port_id == 8'b0) begin
          led_out_0 <= out_port[0];
          led_out_1 <= out_port[1];
          led_out_2 <= out_port[2];
          led_out_3 <= out_port[3];
        end
		
      end

  end
endmodule
