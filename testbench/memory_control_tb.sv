`include "cache_control_if.vh"
`include "cpu_ram_if.vh"

`timescale 1 ns / 1 ns

module memory_control_tb;

   parameter PERIOD = 10;

   logic CLK = 0, nRST;

   always #(PERIOD) CLK++;
   
   //interface
   cache_control_if ccif();
   cpu_ram_if prif();

   //MAP MEM CONTROL SIGNALS TO RAM
   assign ccif.ramstate = prif.ramstate;
   assign ccif.ramload = prif.ramload;
   assign prif.ramstore = ccif.ramstore;
   assign prif.ramaddr = ccif.ramaddr;
   assign prif.ramREN = ccif.ramREN;
   assign prif.ramWEN = ccif.ramWEN;
   

   //test PROGRAM
   test PROG(
	     .CLK,
	     .nRST,
	     .ccif,
	     .prif
	     );

`ifndef MAPPED
   memory_control DUT(CLK, nRST, ccif);
   //RAM INSTANCE
   ram DAT(CLK, nRST, prif);
`endif // !`ifndef MAPPED

endmodule // memory_control_tb

program test(input logic CLK, output logic nRST, cache_control_if.tb ccif, cpu_ram_if prif);
   initial
     begin
	import cpu_types_pkg::*;
	
	//INITIAL
	nRST = 1;
	ccif.iREN = 0;
	ccif.iaddr = '0;
	ccif.dstore = '0;
	ccif.dREN = 0;
	ccif.dWEN = 0;
	ccif.daddr = '0;

	@(posedge CLK);
	nRST = 0;
	@(posedge CLK);                    //Test iREN
	nRST = 1;
	ccif.iREN = 1;
	ccif.iaddr = 32'd8;
	@(posedge CLK);
	@(posedge CLK);
	ccif.iREN = 0;                     //TEST dWEN
	ccif.daddr = 32'd16;
	ccif.dstore = 32'hcaadc005;
	ccif.dWEN = 1;
	@(posedge CLK);
	@(posedge CLK);                    //TEST dREN
	ccif.dWEN = 0;
	ccif.dREN = 1;
	ccif.daddr = 32'd12;
	@(posedge CLK);
	@(posedge CLK);                    //dWEN and iWEN together
	ccif.dREN = 0;
	ccif.daddr = 32'd20;
	ccif.dstore = 32'h12345678;
	ccif.iaddr = 32'd16;
	ccif.dWEN = 1;
	ccif.iREN = 1;
	@(posedge CLK);
	@(posedge CLK);
	ccif.dWEN = 0;
	@(posedge CLK);
	@(posedge CLK);
	ccif.dREN = 1;
	ccif.daddr = 32'd20;
	ccif.iaddr = 32'd8;
	@(posedge CLK);
	@(posedge CLK);
	ccif.dREN = 0;
	@(posedge CLK);
	@(posedge CLK);
	
     end

   /*task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;
    
    syif.tbCTRL = 1;
    syif.addr = 0;
    syif.WEN = 0;
    syif.REN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      syif.addr = i << 2;
      syif.REN = 1;
      repeat (2) @(posedge CLK);
      if (syif.load === 0)
        continue;
      values = {8'h04,16'(i),8'h00,syif.load};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),syif.load,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      syif.tbCTRL = 0;
      syif.REN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask*/
   
   
   //end
endprogram // test

   
