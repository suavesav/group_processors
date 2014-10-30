/*
  Eric Villasenor
  evillase@gmail.com

  holds datapath and cache interface signals
*/
`ifndef DATAPATH_CACHE_IF_VH
`define DATAPATH_CACHE_IF_VH

// types
`include "cpu_types_pkg.vh"

interface datapath_cache_if;
  // import types
  import cpu_types_pkg::*;

// datapath signals
  // stop processing
  logic               halt;

// Icache signals
  // hit and enable
  logic               ihit, imemREN, pcRST;
  // instruction addr
  word_t             imemload, imemaddr;

// Dcache signals
  // hit, atomic and enables
  logic               dhit, datomic, dmemREN, dmemWEN, flushed;
  // data and address
  word_t              dmemload, dmemstore, dmemaddr;

  // datapath ports
  modport dp (
    input   ihit, imemload, dhit, dmemload,
    output  halt, imemREN, imemaddr, dmemREN, dmemWEN, datomic,
            dmemstore, dmemaddr, pcRST
  );

   modport tb (
	       input halt, imemREN, imemaddr, dmemREN, dmemWEN, datomic, dmemstore, dmemaddr,
	       output ihit, imemload, dhit, dmemload
	       );
   

  // cache block ports
  modport cache (
    input   halt, imemREN, dmemREN, dmemWEN, datomic,
            dmemstore, dmemaddr, imemaddr, pcRST,
    output  ihit, dhit, imemload, dmemload, flushed
  );

  // icache ports
  modport icache (
    input   imemREN, imemaddr, pcRST,
    output  ihit, imemload
  );

  // dcache ports
  modport dcache (
    input   halt, dmemREN, dmemWEN,
            datomic, dmemstore, dmemaddr,
    output  dhit, dmemload, flushed
  );

   //icache tb
   modport itb (
		input ihit, imemload,
		output imemREN, imemaddr
		);

   modport dtb (
		input dhit, dmemload, flushed,
		output dmemREN, dmemWEN, dmemstore, dmemaddr, halt, datomic
		);
   
   
endinterface

`endif //DATAPATH_CACHE_IF_VH
