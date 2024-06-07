/* test module for noc.v */ 
`include "define.h"     
`timescale 1ns/10ps 

module noc_test; 

parameter STEP  = 5.0; 
parameter ARRAY = 2; 

integer counter, stop, total_sent, total_recv; 
reg clk, rst_, ready; 

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

noc noc ( 
        /* n0 */ 
        .n0_idata_p0 ( n0_idata_p0  ), 
        .n0_ivalid_p0( n0_ivalid_p0 ), 
        .n0_ivch_p0  ( n0_ivch_p0   ), 
        .n0_ordy_p0  ( n0_ordy_p0   ), 
        .n0_odata_p0 ( n0_odata_p0  ), 
        .n0_ovalid_p0( n0_ovalid_p0 ), 

        /* n1 */ 
        .n1_idata_p0 ( n1_idata_p0  ), 
        .n1_ivalid_p0( n1_ivalid_p0 ), 
        .n1_ivch_p0  ( n1_ivch_p0   ), 
        .n1_ordy_p0  ( n1_ordy_p0   ), 
        .n1_odata_p0 ( n1_odata_p0  ), 
        .n1_ovalid_p0( n1_ovalid_p0 ), 

        /* n2 */ 
        .n2_idata_p0 ( n2_idata_p0  ), 
        .n2_ivalid_p0( n2_ivalid_p0 ), 
        .n2_ivch_p0  ( n2_ivch_p0   ), 
        .n2_ordy_p0  ( n2_ordy_p0   ), 
        .n2_odata_p0 ( n2_odata_p0  ), 
        .n2_ovalid_p0( n2_ovalid_p0 ), 

        /* n3 */ 
        .n3_idata_p0 ( n3_idata_p0  ), 
        .n3_ivalid_p0( n3_ivalid_p0 ), 
        .n3_ivch_p0  ( n3_ivch_p0   ), 
        .n3_ordy_p0  ( n3_ordy_p0   ), 
        .n3_odata_p0 ( n3_odata_p0  ), 
        .n3_ovalid_p0( n3_ovalid_p0 ), 

        .clk ( clk  ), 
        .rst_( rst_ )  
); 

always #( STEP / 2) begin      
        clk <= ~clk;           
end                            
always #(STEP) begin           
        counter = counter + 1; 
end                            

initial begin                   
        /* Initialization */    
        #0                      
        counter = 0;            
        stop    = 200;          
        clk     <= `High;       
        ready   <= `Disable;    
        /* Send/recv counters */
        n0_sent = 0; n0_recv = 0; 
        n1_sent = 0; n1_recv = 0; 
        n2_sent = 0; n2_recv = 0; 
        n3_sent = 0; n3_recv = 0; 
        #(STEP / 2)             
        noc_reset;              
        /* Now we can start simulation! */
        ready   <= `Enable;     

        /* Waiting for the end of the simulation */ 
        while (counter < stop) begin
                #(STEP);        
        end                     

        /* Statistics */ 
        total_sent = n0_sent + n1_sent + n2_sent + n3_sent;
        total_recv = n0_recv + n1_recv + n2_recv + n3_recv;
        $write("\n\n");    
        $write("*** statistics (%d) *** \n", counter); 
        $write("n0_sent %d \t n0_recv %d \n", n0_sent, n0_recv);
        $write("n1_sent %d \t n1_recv %d \n", n1_sent, n1_recv);
        $write("n2_sent %d \t n2_recv %d \n", n2_sent, n2_recv);
        $write("n3_sent %d \t n3_recv %d \n", n3_sent, n3_recv);
        $write("total_sent %d \t total_recv %d \n", total_sent, total_recv);
        $write("\n\n");    
        $finish;               
end                             

/* packet generator for n0 */ 
initial begin 
        #(STEP / 2); 
        #(STEP * 10); 
        while (~ready) begin 
                #(STEP); 
        end 

        $write("*** send (src: 0 dst: 3 vch: 0 len: 4) *** \n");
        send_packet_0(3, 0, 4);
        $write("*** send (src: 0 dst: 2 vch: 1 len: 5) *** \n");
        send_packet_0(2, 1, 5);
        $write("*** send (src: 0 dst: 2 vch: 1 len: 2) *** \n");
        send_packet_0(2, 1, 2);
        $write("*** send (src: 0 dst: 3 vch: 1 len: 3) *** \n");
        send_packet_0(3, 1, 3);
        $write("*** send (src: 0 dst: 1 vch: 1 len: 4) *** \n");
        send_packet_0(1, 1, 4);
        $write("*** send (src: 0 dst: 1 vch: 0 len: 4) *** \n");
        send_packet_0(1, 0, 4);
        $write("*** send (src: 0 dst: 3 vch: 0 len: 2) *** \n");
        send_packet_0(3, 0, 2);
        $write("*** send (src: 0 dst: 3 vch: 0 len: 1) *** \n");
        send_packet_0(3, 0, 1);
        $write("*** send (src: 0 dst: 3 vch: 0 len: 4) *** \n");
        send_packet_0(3, 0, 4);
        $write("*** send (src: 0 dst: 2 vch: 0 len: 5) *** \n");
        send_packet_0(2, 0, 5);
        $write("*** send (src: 0 dst: 3 vch: 0 len: 4) *** \n");
        send_packet_0(3, 0, 4);
        $write("*** send (src: 0 dst: 3 vch: 1 len: 4) *** \n");
        send_packet_0(3, 1, 4);
        $write("*** send (src: 0 dst: 1 vch: 0 len: 3) *** \n");
        send_packet_0(1, 0, 3);
        $write("*** send (src: 0 dst: 2 vch: 1 len: 5) *** \n");
        send_packet_0(2, 1, 5);
        $write("*** send (src: 0 dst: 1 vch: 0 len: 3) *** \n");
        send_packet_0(1, 0, 3);
        $write("*** send (src: 0 dst: 2 vch: 1 len: 5) *** \n");
        send_packet_0(2, 1, 5);
        $write("*** send (src: 0 dst: 1 vch: 1 len: 3) *** \n");
        send_packet_0(1, 1, 3);
        $write("*** send (src: 0 dst: 1 vch: 0 len: 2) *** \n");
        send_packet_0(1, 0, 2);
        $write("*** send (src: 0 dst: 3 vch: 0 len: 2) *** \n");
        send_packet_0(3, 0, 2);
        $write("*** send (src: 0 dst: 3 vch: 1 len: 1) *** \n");
        send_packet_0(3, 1, 1);
        $write("*** send (src: 0 dst: 3 vch: 0 len: 5) *** \n");
        send_packet_0(3, 0, 5);
        $write("*** send (src: 0 dst: 1 vch: 1 len: 5) *** \n");
        send_packet_0(1, 1, 5);
        $write("*** send (src: 0 dst: 3 vch: 1 len: 4) *** \n");
        send_packet_0(3, 1, 4);
        $write("*** send (src: 0 dst: 1 vch: 0 len: 5) *** \n");
        send_packet_0(1, 0, 5);
        $write("*** send (src: 0 dst: 3 vch: 1 len: 2) *** \n");
        send_packet_0(3, 1, 2);
        $write("*** send (src: 0 dst: 3 vch: 0 len: 2) *** \n");
        send_packet_0(3, 0, 2);
        $write("*** send (src: 0 dst: 1 vch: 1 len: 2) *** \n");
        send_packet_0(1, 1, 2);
        $write("*** send (src: 0 dst: 2 vch: 1 len: 2) *** \n");
        send_packet_0(2, 1, 2);
        $write("*** send (src: 0 dst: 3 vch: 1 len: 1) *** \n");
        send_packet_0(3, 1, 1);
        $write("*** send (src: 0 dst: 1 vch: 0 len: 1) *** \n");
        send_packet_0(1, 0, 1);
        $write("*** send (src: 0 dst: 1 vch: 0 len: 1) *** \n");
        send_packet_0(1, 0, 1);
        $write("*** send (src: 0 dst: 3 vch: 0 len: 4) *** \n");
        send_packet_0(3, 0, 4);
end 

/* packet generator for n1 */ 
initial begin 
        #(STEP / 2); 
        #(STEP * 10); 
        while (~ready) begin 
                #(STEP); 
        end 

        $write("*** send (src: 1 dst: 2 vch: 1 len: 1) *** \n");
        send_packet_1(2, 1, 1);
        $write("*** send (src: 1 dst: 2 vch: 0 len: 4) *** \n");
        send_packet_1(2, 0, 4);
        $write("*** send (src: 1 dst: 3 vch: 1 len: 2) *** \n");
        send_packet_1(3, 1, 2);
        $write("*** send (src: 1 dst: 0 vch: 0 len: 4) *** \n");
        send_packet_1(0, 0, 4);
        $write("*** send (src: 1 dst: 0 vch: 0 len: 5) *** \n");
        send_packet_1(0, 0, 5);
        $write("*** send (src: 1 dst: 2 vch: 0 len: 1) *** \n");
        send_packet_1(2, 0, 1);
        $write("*** send (src: 1 dst: 2 vch: 0 len: 2) *** \n");
        send_packet_1(2, 0, 2);
        $write("*** send (src: 1 dst: 3 vch: 0 len: 5) *** \n");
        send_packet_1(3, 0, 5);
        $write("*** send (src: 1 dst: 0 vch: 1 len: 4) *** \n");
        send_packet_1(0, 1, 4);
        $write("*** send (src: 1 dst: 3 vch: 0 len: 4) *** \n");
        send_packet_1(3, 0, 4);
        $write("*** send (src: 1 dst: 3 vch: 1 len: 2) *** \n");
        send_packet_1(3, 1, 2);
        $write("*** send (src: 1 dst: 2 vch: 0 len: 3) *** \n");
        send_packet_1(2, 0, 3);
        $write("*** send (src: 1 dst: 2 vch: 0 len: 4) *** \n");
        send_packet_1(2, 0, 4);
        $write("*** send (src: 1 dst: 2 vch: 0 len: 3) *** \n");
        send_packet_1(2, 0, 3);
        $write("*** send (src: 1 dst: 2 vch: 1 len: 3) *** \n");
        send_packet_1(2, 1, 3);
        $write("*** send (src: 1 dst: 2 vch: 0 len: 1) *** \n");
        send_packet_1(2, 0, 1);
        $write("*** send (src: 1 dst: 3 vch: 0 len: 2) *** \n");
        send_packet_1(3, 0, 2);
        $write("*** send (src: 1 dst: 2 vch: 0 len: 2) *** \n");
        send_packet_1(2, 0, 2);
        $write("*** send (src: 1 dst: 0 vch: 1 len: 5) *** \n");
        send_packet_1(0, 1, 5);
        $write("*** send (src: 1 dst: 0 vch: 1 len: 1) *** \n");
        send_packet_1(0, 1, 1);
        $write("*** send (src: 1 dst: 3 vch: 1 len: 4) *** \n");
        send_packet_1(3, 1, 4);
        $write("*** send (src: 1 dst: 2 vch: 1 len: 2) *** \n");
        send_packet_1(2, 1, 2);
        $write("*** send (src: 1 dst: 0 vch: 0 len: 4) *** \n");
        send_packet_1(0, 0, 4);
        $write("*** send (src: 1 dst: 3 vch: 0 len: 3) *** \n");
        send_packet_1(3, 0, 3);
        $write("*** send (src: 1 dst: 3 vch: 0 len: 1) *** \n");
        send_packet_1(3, 0, 1);
        $write("*** send (src: 1 dst: 0 vch: 1 len: 2) *** \n");
        send_packet_1(0, 1, 2);
        $write("*** send (src: 1 dst: 2 vch: 0 len: 1) *** \n");
        send_packet_1(2, 0, 1);
        $write("*** send (src: 1 dst: 0 vch: 1 len: 4) *** \n");
        send_packet_1(0, 1, 4);
        $write("*** send (src: 1 dst: 2 vch: 0 len: 5) *** \n");
        send_packet_1(2, 0, 5);
        $write("*** send (src: 1 dst: 0 vch: 0 len: 3) *** \n");
        send_packet_1(0, 0, 3);
        $write("*** send (src: 1 dst: 0 vch: 0 len: 4) *** \n");
        send_packet_1(0, 0, 4);
        $write("*** send (src: 1 dst: 0 vch: 0 len: 2) *** \n");
        send_packet_1(0, 0, 2);
end 

/* packet generator for n2 */ 
initial begin 
        #(STEP / 2); 
        #(STEP * 10); 
        while (~ready) begin 
                #(STEP); 
        end 

        $write("*** send (src: 2 dst: 0 vch: 0 len: 1) *** \n");
        send_packet_2(0, 0, 1);
        $write("*** send (src: 2 dst: 3 vch: 0 len: 4) *** \n");
        send_packet_2(3, 0, 4);
        $write("*** send (src: 2 dst: 0 vch: 1 len: 1) *** \n");
        send_packet_2(0, 1, 1);
        $write("*** send (src: 2 dst: 1 vch: 0 len: 2) *** \n");
        send_packet_2(1, 0, 2);
        $write("*** send (src: 2 dst: 3 vch: 0 len: 5) *** \n");
        send_packet_2(3, 0, 5);
        $write("*** send (src: 2 dst: 0 vch: 1 len: 2) *** \n");
        send_packet_2(0, 1, 2);
        $write("*** send (src: 2 dst: 3 vch: 0 len: 5) *** \n");
        send_packet_2(3, 0, 5);
        $write("*** send (src: 2 dst: 0 vch: 0 len: 1) *** \n");
        send_packet_2(0, 0, 1);
        $write("*** send (src: 2 dst: 0 vch: 1 len: 4) *** \n");
        send_packet_2(0, 1, 4);
        $write("*** send (src: 2 dst: 3 vch: 1 len: 2) *** \n");
        send_packet_2(3, 1, 2);
        $write("*** send (src: 2 dst: 3 vch: 1 len: 3) *** \n");
        send_packet_2(3, 1, 3);
        $write("*** send (src: 2 dst: 1 vch: 0 len: 1) *** \n");
        send_packet_2(1, 0, 1);
        $write("*** send (src: 2 dst: 1 vch: 1 len: 4) *** \n");
        send_packet_2(1, 1, 4);
        $write("*** send (src: 2 dst: 3 vch: 0 len: 2) *** \n");
        send_packet_2(3, 0, 2);
        $write("*** send (src: 2 dst: 1 vch: 1 len: 4) *** \n");
        send_packet_2(1, 1, 4);
        $write("*** send (src: 2 dst: 0 vch: 1 len: 3) *** \n");
        send_packet_2(0, 1, 3);
        $write("*** send (src: 2 dst: 1 vch: 1 len: 2) *** \n");
        send_packet_2(1, 1, 2);
        $write("*** send (src: 2 dst: 1 vch: 0 len: 1) *** \n");
        send_packet_2(1, 0, 1);
        $write("*** send (src: 2 dst: 1 vch: 0 len: 5) *** \n");
        send_packet_2(1, 0, 5);
        $write("*** send (src: 2 dst: 3 vch: 1 len: 4) *** \n");
        send_packet_2(3, 1, 4);
        $write("*** send (src: 2 dst: 0 vch: 0 len: 5) *** \n");
        send_packet_2(0, 0, 5);
        $write("*** send (src: 2 dst: 3 vch: 0 len: 5) *** \n");
        send_packet_2(3, 0, 5);
        $write("*** send (src: 2 dst: 1 vch: 0 len: 4) *** \n");
        send_packet_2(1, 0, 4);
        $write("*** send (src: 2 dst: 3 vch: 0 len: 2) *** \n");
        send_packet_2(3, 0, 2);
        $write("*** send (src: 2 dst: 0 vch: 1 len: 3) *** \n");
        send_packet_2(0, 1, 3);
        $write("*** send (src: 2 dst: 3 vch: 1 len: 1) *** \n");
        send_packet_2(3, 1, 1);
        $write("*** send (src: 2 dst: 3 vch: 1 len: 2) *** \n");
        send_packet_2(3, 1, 2);
        $write("*** send (src: 2 dst: 0 vch: 0 len: 5) *** \n");
        send_packet_2(0, 0, 5);
        $write("*** send (src: 2 dst: 3 vch: 0 len: 2) *** \n");
        send_packet_2(3, 0, 2);
        $write("*** send (src: 2 dst: 0 vch: 0 len: 4) *** \n");
        send_packet_2(0, 0, 4);
        $write("*** send (src: 2 dst: 3 vch: 1 len: 5) *** \n");
        send_packet_2(3, 1, 5);
        $write("*** send (src: 2 dst: 1 vch: 1 len: 1) *** \n");
        send_packet_2(1, 1, 1);
end 

/* packet generator for n3 */ 
initial begin 
        #(STEP / 2); 
        #(STEP * 10); 
        while (~ready) begin 
                #(STEP); 
        end 

        $write("*** send (src: 3 dst: 2 vch: 0 len: 2) *** \n");
        send_packet_3(2, 0, 2);
        $write("*** send (src: 3 dst: 2 vch: 0 len: 1) *** \n");
        send_packet_3(2, 0, 1);
        $write("*** send (src: 3 dst: 0 vch: 1 len: 5) *** \n");
        send_packet_3(0, 1, 5);
        $write("*** send (src: 3 dst: 1 vch: 0 len: 5) *** \n");
        send_packet_3(1, 0, 5);
        $write("*** send (src: 3 dst: 1 vch: 0 len: 2) *** \n");
        send_packet_3(1, 0, 2);
        $write("*** send (src: 3 dst: 1 vch: 0 len: 5) *** \n");
        send_packet_3(1, 0, 5);
        $write("*** send (src: 3 dst: 2 vch: 1 len: 3) *** \n");
        send_packet_3(2, 1, 3);
        $write("*** send (src: 3 dst: 1 vch: 0 len: 3) *** \n");
        send_packet_3(1, 0, 3);
        $write("*** send (src: 3 dst: 0 vch: 1 len: 5) *** \n");
        send_packet_3(0, 1, 5);
        $write("*** send (src: 3 dst: 2 vch: 0 len: 5) *** \n");
        send_packet_3(2, 0, 5);
        $write("*** send (src: 3 dst: 0 vch: 0 len: 4) *** \n");
        send_packet_3(0, 0, 4);
        $write("*** send (src: 3 dst: 1 vch: 0 len: 2) *** \n");
        send_packet_3(1, 0, 2);
        $write("*** send (src: 3 dst: 2 vch: 0 len: 4) *** \n");
        send_packet_3(2, 0, 4);
        $write("*** send (src: 3 dst: 1 vch: 1 len: 3) *** \n");
        send_packet_3(1, 1, 3);
        $write("*** send (src: 3 dst: 2 vch: 1 len: 3) *** \n");
        send_packet_3(2, 1, 3);
        $write("*** send (src: 3 dst: 0 vch: 1 len: 3) *** \n");
        send_packet_3(0, 1, 3);
        $write("*** send (src: 3 dst: 0 vch: 0 len: 4) *** \n");
        send_packet_3(0, 0, 4);
        $write("*** send (src: 3 dst: 0 vch: 0 len: 5) *** \n");
        send_packet_3(0, 0, 5);
        $write("*** send (src: 3 dst: 0 vch: 0 len: 2) *** \n");
        send_packet_3(0, 0, 2);
        $write("*** send (src: 3 dst: 0 vch: 1 len: 3) *** \n");
        send_packet_3(0, 1, 3);
        $write("*** send (src: 3 dst: 2 vch: 0 len: 5) *** \n");
        send_packet_3(2, 0, 5);
        $write("*** send (src: 3 dst: 0 vch: 0 len: 5) *** \n");
        send_packet_3(0, 0, 5);
        $write("*** send (src: 3 dst: 1 vch: 0 len: 2) *** \n");
        send_packet_3(1, 0, 2);
        $write("*** send (src: 3 dst: 1 vch: 1 len: 1) *** \n");
        send_packet_3(1, 1, 1);
        $write("*** send (src: 3 dst: 1 vch: 1 len: 1) *** \n");
        send_packet_3(1, 1, 1);
        $write("*** send (src: 3 dst: 0 vch: 1 len: 4) *** \n");
        send_packet_3(0, 1, 4);
        $write("*** send (src: 3 dst: 1 vch: 1 len: 5) *** \n");
        send_packet_3(1, 1, 5);
        $write("*** send (src: 3 dst: 1 vch: 0 len: 1) *** \n");
        send_packet_3(1, 0, 1);
        $write("*** send (src: 3 dst: 0 vch: 0 len: 5) *** \n");
        send_packet_3(0, 0, 5);
        $write("*** send (src: 3 dst: 1 vch: 0 len: 3) *** \n");
        send_packet_3(1, 0, 3);
        $write("*** send (src: 3 dst: 0 vch: 0 len: 2) *** \n");
        send_packet_3(0, 0, 2);
        $write("*** send (src: 3 dst: 2 vch: 1 len: 2) *** \n");
        send_packet_3(2, 1, 2);
end 



/* Send/recv event monitor */ 
always @ (posedge clk) begin 
        if ( n0_ivalid_p0 == `Enable ) begin 
                $write("%d n0 send %x \n", counter, n0_idata_p0); 
                n0_sent = n0_sent + 1;
        end 
        if ( n1_ivalid_p0 == `Enable ) begin 
                $write("%d n1 send %x \n", counter, n1_idata_p0); 
                n1_sent = n1_sent + 1;
        end 
        if ( n2_ivalid_p0 == `Enable ) begin 
                $write("%d n2 send %x \n", counter, n2_idata_p0); 
                n2_sent = n2_sent + 1;
        end 
        if ( n3_ivalid_p0 == `Enable ) begin 
                $write("%d n3 send %x \n", counter, n3_idata_p0); 
                n3_sent = n3_sent + 1;
        end 
end 

always @ (posedge clk) begin 
        if ( n0_ovalid_p0 == `Enable ) begin 
                $write("        %d n0 recv %x \n", counter, n0_odata_p0); 
                n0_recv = n0_recv + 1; 
                stop     = counter + 200;
        end 
        if ( n1_ovalid_p0 == `Enable ) begin 
                $write("        %d n1 recv %x \n", counter, n1_odata_p0); 
                n1_recv = n1_recv + 1; 
                stop     = counter + 200;
        end 
        if ( n2_ovalid_p0 == `Enable ) begin 
                $write("        %d n2 recv %x \n", counter, n2_odata_p0); 
                n2_recv = n2_recv + 1; 
                stop     = counter + 200;
        end 
        if ( n3_ovalid_p0 == `Enable ) begin 
                $write("        %d n3 recv %x \n", counter, n3_odata_p0); 
                n3_recv = n3_recv + 1; 
                stop     = counter + 200;
        end 
end 

/* Port 0 */ 
always @ (posedge clk) begin    
	if ( noc.n0.ovalid_0 == `Enable ) $write("                %d n0(0 %d) go thru %x \n", counter, noc.n0.ovch_0, noc.n0.odata_0); 
	if ( noc.n1.ovalid_0 == `Enable ) $write("                %d n1(0 %d) go thru %x \n", counter, noc.n1.ovch_0, noc.n1.odata_0); 
	if ( noc.n2.ovalid_0 == `Enable ) $write("                %d n2(0 %d) go thru %x \n", counter, noc.n2.ovch_0, noc.n2.odata_0); 
	if ( noc.n3.ovalid_0 == `Enable ) $write("                %d n3(0 %d) go thru %x \n", counter, noc.n3.ovch_0, noc.n3.odata_0); 
end 
/* Port 1 */ 
always @ (posedge clk) begin    
	if ( noc.n0.ovalid_1 == `Enable ) $write("                %d n0(1 %d) go thru %x \n", counter, noc.n0.ovch_1, noc.n0.odata_1); 
	if ( noc.n1.ovalid_1 == `Enable ) $write("                %d n1(1 %d) go thru %x \n", counter, noc.n1.ovch_1, noc.n1.odata_1); 
	if ( noc.n2.ovalid_1 == `Enable ) $write("                %d n2(1 %d) go thru %x \n", counter, noc.n2.ovch_1, noc.n2.odata_1); 
	if ( noc.n3.ovalid_1 == `Enable ) $write("                %d n3(1 %d) go thru %x \n", counter, noc.n3.ovch_1, noc.n3.odata_1); 
end 
/* Port 2 */ 
always @ (posedge clk) begin    
	if ( noc.n0.ovalid_2 == `Enable ) $write("                %d n0(2 %d) go thru %x \n", counter, noc.n0.ovch_2, noc.n0.odata_2); 
	if ( noc.n1.ovalid_2 == `Enable ) $write("                %d n1(2 %d) go thru %x \n", counter, noc.n1.ovch_2, noc.n1.odata_2); 
	if ( noc.n2.ovalid_2 == `Enable ) $write("                %d n2(2 %d) go thru %x \n", counter, noc.n2.ovch_2, noc.n2.odata_2); 
	if ( noc.n3.ovalid_2 == `Enable ) $write("                %d n3(2 %d) go thru %x \n", counter, noc.n3.ovch_2, noc.n3.odata_2); 
end 
/* Port 3 */ 
always @ (posedge clk) begin    
	if ( noc.n0.ovalid_3 == `Enable ) $write("                %d n0(3 %d) go thru %x \n", counter, noc.n0.ovch_3, noc.n0.odata_3); 
	if ( noc.n1.ovalid_3 == `Enable ) $write("                %d n1(3 %d) go thru %x \n", counter, noc.n1.ovch_3, noc.n1.odata_3); 
	if ( noc.n2.ovalid_3 == `Enable ) $write("                %d n2(3 %d) go thru %x \n", counter, noc.n2.ovch_3, noc.n2.odata_3); 
	if ( noc.n3.ovalid_3 == `Enable ) $write("                %d n3(3 %d) go thru %x \n", counter, noc.n3.ovch_3, noc.n3.odata_3); 
end 

initial begin                     
        $dumpfile("dump.vcd"); 
        $dumpvars(0,noc_test);   
        `ifdef __POST_PR__        
        $sdf_annotate("router.sdf", noc_test.noc.n0, , "sdf.log", "MAXIMUM");
        $sdf_annotate("router.sdf", noc_test.noc.n1, , "sdf.log", "MAXIMUM");
        $sdf_annotate("router.sdf", noc_test.noc.n2, , "sdf.log", "MAXIMUM");
        $sdf_annotate("router.sdf", noc_test.noc.n3, , "sdf.log", "MAXIMUM");
        `endif                    
end                               

/* send_packet_0(dst, vch, len): send a packet from n0 to destination. */ 
task send_packet_0; 
input [31:0] dst; 
input [31:0] vch; 
input [31:0] len; 
reg [`DATAW:0]  packet [0:63]; 
integer id; 
begin      
        n0_ivalid_p0 <= `Disable;
        for ( id = 0; id < len; id = id + 1 ) 
                packet[id] <= 0; 
        #(STEP) 
        if (len == 1) 
                packet[0][`TYPE_MSB:`TYPE_LSB] <= `TYPE_HEADTAIL; 
        else 
                packet[0][`TYPE_MSB:`TYPE_LSB] <= `TYPE_HEAD; 
        packet[0][`DST_MSB:`DST_LSB] <= dst;    /* Dest ID (4-bit)   */ 
        packet[0][`SRC_MSB:`SRC_LSB] <= 0;     /* Source ID (4-bit) */ 
        packet[0][`VCH_MSB:`VCH_LSB] <= vch;    /* Vch ID (4-bit)    */ 
        for ( id = 1; id < len; id = id + 1 ) begin 
                if ( id == len - 1 )
                        packet[id][`TYPE_MSB:`TYPE_LSB] <= `TYPE_TAIL; 
                else 
                        packet[id][`TYPE_MSB:`TYPE_LSB] <= `TYPE_DATA; 
                packet[id][15:12] <= id;	/* Flit ID   (4-bit) */ 
                packet[id][31:16] <= counter;	/* Enqueue time (16-bit) */ 
        end 
        id = 0;                                 
        while ( id < len ) begin                
                #(STEP)                         
                /* Packet level flow control */ 
                if ( (id == 0 && n0_ordy_p0[vch]) || id > 0 ) begin 
                        n0_idata_p0 <= packet[id]; n0_ivalid_p0 <= `Enable; n0_ivch_p0 <= vch; id = id + 1; 
                end else begin    
                        n0_idata_p0 <= `DATAW_P1'b0; n0_ivalid_p0 <= `Disable;  
                end 
        end 
        #(STEP) 
        n0_ivalid_p0 <= `Disable;   
end             
endtask         

/* send_packet_1(dst, vch, len): send a packet from n1 to destination. */ 
task send_packet_1; 
input [31:0] dst; 
input [31:0] vch; 
input [31:0] len; 
reg [`DATAW:0]  packet [0:63]; 
integer id; 
begin      
        n1_ivalid_p0 <= `Disable;
        for ( id = 0; id < len; id = id + 1 ) 
                packet[id] <= 0; 
        #(STEP) 
        if (len == 1) 
                packet[0][`TYPE_MSB:`TYPE_LSB] <= `TYPE_HEADTAIL; 
        else 
                packet[0][`TYPE_MSB:`TYPE_LSB] <= `TYPE_HEAD; 
        packet[0][`DST_MSB:`DST_LSB] <= dst;    /* Dest ID (4-bit)   */ 
        packet[0][`SRC_MSB:`SRC_LSB] <= 1;     /* Source ID (4-bit) */ 
        packet[0][`VCH_MSB:`VCH_LSB] <= vch;    /* Vch ID (4-bit)    */ 
        for ( id = 1; id < len; id = id + 1 ) begin 
                if ( id == len - 1 )
                        packet[id][`TYPE_MSB:`TYPE_LSB] <= `TYPE_TAIL; 
                else 
                        packet[id][`TYPE_MSB:`TYPE_LSB] <= `TYPE_DATA; 
                packet[id][15:12] <= id;	/* Flit ID   (4-bit) */ 
                packet[id][31:16] <= counter;	/* Enqueue time (16-bit) */ 
        end 
        id = 0;                                 
        while ( id < len ) begin                
                #(STEP)                         
                /* Packet level flow control */ 
                if ( (id == 0 && n1_ordy_p0[vch]) || id > 0 ) begin 
                        n1_idata_p0 <= packet[id]; n1_ivalid_p0 <= `Enable; n1_ivch_p0 <= vch; id = id + 1; 
                end else begin    
                        n1_idata_p0 <= `DATAW_P1'b0; n1_ivalid_p0 <= `Disable;  
                end 
        end 
        #(STEP) 
        n1_ivalid_p0 <= `Disable;   
end             
endtask         

/* send_packet_2(dst, vch, len): send a packet from n2 to destination. */ 
task send_packet_2; 
input [31:0] dst; 
input [31:0] vch; 
input [31:0] len; 
reg [`DATAW:0]  packet [0:63]; 
integer id; 
begin      
        n2_ivalid_p0 <= `Disable;
        for ( id = 0; id < len; id = id + 1 ) 
                packet[id] <= 0; 
        #(STEP) 
        if (len == 1) 
                packet[0][`TYPE_MSB:`TYPE_LSB] <= `TYPE_HEADTAIL; 
        else 
                packet[0][`TYPE_MSB:`TYPE_LSB] <= `TYPE_HEAD; 
        packet[0][`DST_MSB:`DST_LSB] <= dst;    /* Dest ID (4-bit)   */ 
        packet[0][`SRC_MSB:`SRC_LSB] <= 2;     /* Source ID (4-bit) */ 
        packet[0][`VCH_MSB:`VCH_LSB] <= vch;    /* Vch ID (4-bit)    */ 
        for ( id = 1; id < len; id = id + 1 ) begin 
                if ( id == len - 1 )
                        packet[id][`TYPE_MSB:`TYPE_LSB] <= `TYPE_TAIL; 
                else 
                        packet[id][`TYPE_MSB:`TYPE_LSB] <= `TYPE_DATA; 
                packet[id][15:12] <= id;	/* Flit ID   (4-bit) */ 
                packet[id][31:16] <= counter;	/* Enqueue time (16-bit) */ 
        end 
        id = 0;                                 
        while ( id < len ) begin                
                #(STEP)                         
                /* Packet level flow control */ 
                if ( (id == 0 && n2_ordy_p0[vch]) || id > 0 ) begin 
                        n2_idata_p0 <= packet[id]; n2_ivalid_p0 <= `Enable; n2_ivch_p0 <= vch; id = id + 1; 
                end else begin    
                        n2_idata_p0 <= `DATAW_P1'b0; n2_ivalid_p0 <= `Disable;  
                end 
        end 
        #(STEP) 
        n2_ivalid_p0 <= `Disable;   
end             
endtask         

/* send_packet_3(dst, vch, len): send a packet from n3 to destination. */ 
task send_packet_3; 
input [31:0] dst; 
input [31:0] vch; 
input [31:0] len; 
reg [`DATAW:0]  packet [0:63]; 
integer id; 
begin      
        n3_ivalid_p0 <= `Disable;
        for ( id = 0; id < len; id = id + 1 ) 
                packet[id] <= 0; 
        #(STEP) 
        if (len == 1) 
                packet[0][`TYPE_MSB:`TYPE_LSB] <= `TYPE_HEADTAIL; 
        else 
                packet[0][`TYPE_MSB:`TYPE_LSB] <= `TYPE_HEAD; 
        packet[0][`DST_MSB:`DST_LSB] <= dst;    /* Dest ID (4-bit)   */ 
        packet[0][`SRC_MSB:`SRC_LSB] <= 3;     /* Source ID (4-bit) */ 
        packet[0][`VCH_MSB:`VCH_LSB] <= vch;    /* Vch ID (4-bit)    */ 
        for ( id = 1; id < len; id = id + 1 ) begin 
                if ( id == len - 1 )
                        packet[id][`TYPE_MSB:`TYPE_LSB] <= `TYPE_TAIL; 
                else 
                        packet[id][`TYPE_MSB:`TYPE_LSB] <= `TYPE_DATA; 
                packet[id][15:12] <= id;	/* Flit ID   (4-bit) */ 
                packet[id][31:16] <= counter;	/* Enqueue time (16-bit) */ 
        end 
        id = 0;                                 
        while ( id < len ) begin                
                #(STEP)                         
                /* Packet level flow control */ 
                if ( (id == 0 && n3_ordy_p0[vch]) || id > 0 ) begin 
                        n3_idata_p0 <= packet[id]; n3_ivalid_p0 <= `Enable; n3_ivch_p0 <= vch; id = id + 1; 
                end else begin    
                        n3_idata_p0 <= `DATAW_P1'b0; n3_ivalid_p0 <= `Disable;  
                end 
        end 
        #(STEP) 
        n3_ivalid_p0 <= `Disable;   
end             
endtask         

/* noc_reset(): Reset all routers. */ 
task noc_reset; 
begin           
        rst_    <= `Enable_;   
        #(STEP)                
        n0_idata_p0 <= `DATAW_P1'h0; n0_ivalid_p0 <= `Disable; n0_ivch_p0 <= `VCHW_P1'h0;
        n1_idata_p0 <= `DATAW_P1'h0; n1_ivalid_p0 <= `Disable; n1_ivch_p0 <= `VCHW_P1'h0;
        n2_idata_p0 <= `DATAW_P1'h0; n2_ivalid_p0 <= `Disable; n2_ivch_p0 <= `VCHW_P1'h0;
        n3_idata_p0 <= `DATAW_P1'h0; n3_ivalid_p0 <= `Disable; n3_ivch_p0 <= `VCHW_P1'h0;
        #(STEP)                
        rst_    <= `Disable_;  

end             
endtask         

endmodule 
