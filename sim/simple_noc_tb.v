`include "define.h"
`timescale 1ns/10ps


module simple_noc_tb; 

parameter STEP  = 5.0; 
reg clk, rst_n, ready; 

/* n0 */ 
reg     [`DATAW:0]      n0_idata_p0;  
reg                     n0_ivalid_p0; 
reg     [`VCHW:0]       n0_ivch_p0;   
wire    [`VCH:0]        n0_ordy_p0;   
wire    [`DATAW:0]      n0_odata_p0;  
wire                    n0_ovalid_p0; 
integer                 n0_sent, n0_recv;

/* n1 */ 
reg     [`DATAW:0]      n1_idata_p0;  
reg                     n1_ivalid_p0; 
reg     [`VCHW:0]       n1_ivch_p0;   
wire    [`VCH:0]        n1_ordy_p0;   
wire    [`DATAW:0]      n1_odata_p0;  
wire                    n1_ovalid_p0; 
integer                 n1_sent, n1_recv;

/* n2 */ 
reg     [`DATAW:0]      n2_idata_p0;  
reg                     n2_ivalid_p0; 
reg     [`VCHW:0]       n2_ivch_p0;   
wire    [`VCH:0]        n2_ordy_p0;   
wire    [`DATAW:0]      n2_odata_p0;  
wire                    n2_ovalid_p0; 
integer                 n2_sent, n2_recv;

/* n3 */ 
reg     [`DATAW:0]      n3_idata_p0;  
reg                     n3_ivalid_p0; 
reg     [`VCHW:0]       n3_ivch_p0;   
wire    [`VCH:0]        n3_ordy_p0;   
wire    [`DATAW:0]      n3_odata_p0;  
wire                    n3_ovalid_p0; 
integer                 n3_sent, n3_recv;



endmodule 