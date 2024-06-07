`include "define.h" 
module noc ( 

        /* n0 */ 
        n0_idata_p0,  
        n0_ivalid_p0, 
        n0_ivch_p0,   
        n0_ordy_p0,   
        n0_odata_p0,  
        n0_ovalid_p0, 

        /* n1 */ 
        n1_idata_p0,  
        n1_ivalid_p0, 
        n1_ivch_p0,   
        n1_ordy_p0,   
        n1_odata_p0,  
        n1_ovalid_p0, 

        /* n2 */ 
        n2_idata_p0,  
        n2_ivalid_p0, 
        n2_ivch_p0,   
        n2_ordy_p0,   
        n2_odata_p0,  
        n2_ovalid_p0, 

        /* n3 */ 
        n3_idata_p0,  
        n3_ivalid_p0, 
        n3_ivch_p0,   
        n3_ordy_p0,   
        n3_odata_p0,  
        n3_ovalid_p0, 

        clk, 
        rst_ 
);   

/* n0 */ 
input   [`DATAW:0]      n0_idata_p0;  
input                   n0_ivalid_p0; 
input   [`VCHW:0]       n0_ivch_p0;   
output  [`VCH:0]        n0_ordy_p0;   
output  [`DATAW:0]      n0_odata_p0;  
output                  n0_ovalid_p0; 

/* n1 */ 
input   [`DATAW:0]      n1_idata_p0;  
input                   n1_ivalid_p0; 
input   [`VCHW:0]       n1_ivch_p0;   
output  [`VCH:0]        n1_ordy_p0;   
output  [`DATAW:0]      n1_odata_p0;  
output                  n1_ovalid_p0; 

/* n2 */ 
input   [`DATAW:0]      n2_idata_p0;  
input                   n2_ivalid_p0; 
input   [`VCHW:0]       n2_ivch_p0;   
output  [`VCH:0]        n2_ordy_p0;   
output  [`DATAW:0]      n2_odata_p0;  
output                  n2_ovalid_p0; 

/* n3 */ 
input   [`DATAW:0]      n3_idata_p0;  
input                   n3_ivalid_p0; 
input   [`VCHW:0]       n3_ivch_p0;   
output  [`VCH:0]        n3_ordy_p0;   
output  [`DATAW:0]      n3_odata_p0;  
output                  n3_ovalid_p0; 

input clk, rst_; 

/* n0 --> n1 */ 
wire    [`DATAW:0]      n0_odata_1;  
wire                    n0_ovalid_1; 
wire    [`VCH:0]        n1_oack_3;   
wire    [`VCH:0]        n1_olck_3;   
wire    [`VCHW:0]       n1_ovch_3;   
/* n0 --> n2 */ 
wire    [`DATAW:0]      n0_odata_2;  
wire                    n0_ovalid_2; 
wire    [`VCH:0]        n2_oack_0;   
wire    [`VCH:0]        n2_olck_0;   
wire    [`VCHW:0]       n2_ovch_0;   
/* n1 --> n0 */ 
wire    [`DATAW:0]      n1_odata_3;  
wire                    n1_ovalid_3; 
wire    [`VCH:0]        n0_oack_1;   
wire    [`VCH:0]        n0_olck_1;   
wire    [`VCHW:0]       n0_ovch_1;   
/* n1 --> n3 */ 
wire    [`DATAW:0]      n1_odata_2;  
wire                    n1_ovalid_2; 
wire    [`VCH:0]        n3_oack_0;   
wire    [`VCH:0]        n3_olck_0;   
wire    [`VCHW:0]       n3_ovch_0;   
/* n2 --> n0 */ 
wire    [`DATAW:0]      n2_odata_0;  
wire                    n2_ovalid_0; 
wire    [`VCH:0]        n0_oack_2;   
wire    [`VCH:0]        n0_olck_2;   
wire    [`VCHW:0]       n0_ovch_2;   
/* n2 --> n3 */ 
wire    [`DATAW:0]      n2_odata_1;  
wire                    n2_ovalid_1; 
wire    [`VCH:0]        n3_oack_3;   
wire    [`VCH:0]        n3_olck_3;   
wire    [`VCHW:0]       n3_ovch_3;   
/* n3 --> n1 */ 
wire    [`DATAW:0]      n3_odata_0;  
wire                    n3_ovalid_0; 
wire    [`VCH:0]        n1_oack_2;   
wire    [`VCH:0]        n1_olck_2;   
wire    [`VCHW:0]       n1_ovch_2;   
/* n3 --> n2 */ 
wire    [`DATAW:0]      n3_odata_3;  
wire                    n3_ovalid_3; 
wire    [`VCH:0]        n2_oack_1;   
wire    [`VCH:0]        n2_olck_1;   
wire    [`VCHW:0]       n2_ovch_1;   

router #( 0 ) n0 ( 
        .idata_4 ( n0_idata_p0  ), 
        .ivalid_4( n0_ivalid_p0 ), 
        .ivch_4  ( n0_ivch_p0   ), 
        .ordy_4  ( n0_ordy_p0   ), 
        .odata_4 ( n0_odata_p0  ), 
        .ovalid_4( n0_ovalid_p0 ), 
        .iack_4  ( `VCH_P1'hff  ),  
        .ilck_4  ( `VCH_P1'h00  ),  

        .idata_0 ( `DATAW_P1'b0 ),  
        .ivalid_0( 1'b0         ),  
        .ivch_0  ( `VCHW_P1'b0  ),  
        .iack_0  ( `VCH_P1'b0   ),  
        .ilck_0  ( `VCH_P1'b0   ),  

        .idata_1 ( n1_odata_3   ), 
        .ivalid_1( n1_ovalid_3  ), 
        .ivch_1  ( n1_ovch_3    ), 
        .oack_1  ( n0_oack_1    ), 
        .olck_1  ( n0_olck_1    ), 
        .odata_1 ( n0_odata_1   ), 
        .ovalid_1( n0_ovalid_1  ), 
        .ovch_1  ( n0_ovch_1    ), 
        .iack_1  ( n1_oack_3    ), 
        .ilck_1  ( n1_olck_3    ), 

        .idata_2 ( n2_odata_0   ), 
        .ivalid_2( n2_ovalid_0  ), 
        .ivch_2  ( n2_ovch_0    ), 
        .oack_2  ( n0_oack_2    ), 
        .olck_2  ( n0_olck_2    ), 
        .odata_2 ( n0_odata_2   ), 
        .ovalid_2( n0_ovalid_2  ), 
        .ovch_2  ( n0_ovch_2    ), 
        .iack_2  ( n2_oack_0    ), 
        .ilck_2  ( n2_olck_0    ), 

        .idata_3 ( `DATAW_P1'b0 ),  
        .ivalid_3( 1'b0         ),  
        .ivch_3  ( `VCHW_P1'b0  ),  
        .iack_3  ( `VCH_P1'b0   ),  
        .ilck_3  ( `VCH_P1'b0   ),  

        .my_xpos ( 0 ), 
        .my_ypos ( 0 ), 

        .clk ( clk  ), 
        .rst_( rst_ )  
); 

router #( 1 ) n1 ( 
        .idata_4 ( n1_idata_p0  ), 
        .ivalid_4( n1_ivalid_p0 ), 
        .ivch_4  ( n1_ivch_p0   ), 
        .ordy_4  ( n1_ordy_p0   ), 
        .odata_4 ( n1_odata_p0  ), 
        .ovalid_4( n1_ovalid_p0 ), 
        .iack_4  ( `VCH_P1'hff  ),  
        .ilck_4  ( `VCH_P1'h00  ),  

        .idata_0 ( `DATAW_P1'b0 ),  
        .ivalid_0( 1'b0         ),  
        .ivch_0  ( `VCHW_P1'b0  ),  
        .iack_0  ( `VCH_P1'b0   ),  
        .ilck_0  ( `VCH_P1'b0   ),  

        .idata_1 ( `DATAW_P1'b0 ),  
        .ivalid_1( 1'b0         ),  
        .ivch_1  ( `VCHW_P1'b0  ),  
        .iack_1  ( `VCH_P1'b0   ),  
        .ilck_1  ( `VCH_P1'b0   ),  

        .idata_2 ( n3_odata_0   ), 
        .ivalid_2( n3_ovalid_0  ), 
        .ivch_2  ( n3_ovch_0    ), 
        .oack_2  ( n1_oack_2    ), 
        .olck_2  ( n1_olck_2    ), 
        .odata_2 ( n1_odata_2   ), 
        .ovalid_2( n1_ovalid_2  ), 
        .ovch_2  ( n1_ovch_2    ), 
        .iack_2  ( n3_oack_0    ), 
        .ilck_2  ( n3_olck_0    ), 

        .idata_3 ( n0_odata_1   ), 
        .ivalid_3( n0_ovalid_1  ), 
        .ivch_3  ( n0_ovch_1    ), 
        .oack_3  ( n1_oack_3    ), 
        .olck_3  ( n1_olck_3    ), 
        .odata_3 ( n1_odata_3   ), 
        .ovalid_3( n1_ovalid_3  ), 
        .ovch_3  ( n1_ovch_3    ), 
        .iack_3  ( n0_oack_1    ), 
        .ilck_3  ( n0_olck_1    ), 

        .my_xpos ( 1 ), 
        .my_ypos ( 0 ), 

        .clk ( clk  ), 
        .rst_( rst_ )  
); 

router #( 2 ) n2 ( 
        .idata_4 ( n2_idata_p0  ), 
        .ivalid_4( n2_ivalid_p0 ), 
        .ivch_4  ( n2_ivch_p0   ), 
        .ordy_4  ( n2_ordy_p0   ), 
        .odata_4 ( n2_odata_p0  ), 
        .ovalid_4( n2_ovalid_p0 ), 
        .iack_4  ( `VCH_P1'hff  ),  
        .ilck_4  ( `VCH_P1'h00  ),  

        .idata_0 ( n0_odata_2   ), 
        .ivalid_0( n0_ovalid_2  ), 
        .ivch_0  ( n0_ovch_2    ), 
        .oack_0  ( n2_oack_0    ), 
        .olck_0  ( n2_olck_0    ), 
        .odata_0 ( n2_odata_0   ), 
        .ovalid_0( n2_ovalid_0  ), 
        .ovch_0  ( n2_ovch_0    ), 
        .iack_0  ( n0_oack_2    ), 
        .ilck_0  ( n0_olck_2    ), 

        .idata_1 ( n3_odata_3   ), 
        .ivalid_1( n3_ovalid_3  ), 
        .ivch_1  ( n3_ovch_3    ), 
        .oack_1  ( n2_oack_1    ), 
        .olck_1  ( n2_olck_1    ), 
        .odata_1 ( n2_odata_1   ), 
        .ovalid_1( n2_ovalid_1  ), 
        .ovch_1  ( n2_ovch_1    ), 
        .iack_1  ( n3_oack_3    ), 
        .ilck_1  ( n3_olck_3    ), 

        .idata_2 ( `DATAW_P1'b0 ),  
        .ivalid_2( 1'b0         ),  
        .ivch_2  ( `VCHW_P1'b0  ),  
        .iack_2  ( `VCH_P1'b0   ),  
        .ilck_2  ( `VCH_P1'b0   ),  

        .idata_3 ( `DATAW_P1'b0 ),  
        .ivalid_3( 1'b0         ),  
        .ivch_3  ( `VCHW_P1'b0  ),  
        .iack_3  ( `VCH_P1'b0   ),  
        .ilck_3  ( `VCH_P1'b0   ),  

        .my_xpos ( 0 ), 
        .my_ypos ( 1 ), 

        .clk ( clk  ), 
        .rst_( rst_ )  
); 

router #( 3 ) n3 ( 
        .idata_4 ( n3_idata_p0  ), 
        .ivalid_4( n3_ivalid_p0 ), 
        .ivch_4  ( n3_ivch_p0   ), 
        .ordy_4  ( n3_ordy_p0   ), 
        .odata_4 ( n3_odata_p0  ), 
        .ovalid_4( n3_ovalid_p0 ), 
        .iack_4  ( `VCH_P1'hff  ),  
        .ilck_4  ( `VCH_P1'h00  ),  

        .idata_0 ( n1_odata_2   ), 
        .ivalid_0( n1_ovalid_2  ), 
        .ivch_0  ( n1_ovch_2    ), 
        .oack_0  ( n3_oack_0    ), 
        .olck_0  ( n3_olck_0    ), 
        .odata_0 ( n3_odata_0   ), 
        .ovalid_0( n3_ovalid_0  ), 
        .ovch_0  ( n3_ovch_0    ), 
        .iack_0  ( n1_oack_2    ), 
        .ilck_0  ( n1_olck_2    ), 

        .idata_1 ( `DATAW_P1'b0 ),  
        .ivalid_1( 1'b0         ),  
        .ivch_1  ( `VCHW_P1'b0  ),  
        .iack_1  ( `VCH_P1'b0   ),  
        .ilck_1  ( `VCH_P1'b0   ),  

        .idata_2 ( `DATAW_P1'b0 ),  
        .ivalid_2( 1'b0         ),  
        .ivch_2  ( `VCHW_P1'b0  ),  
        .iack_2  ( `VCH_P1'b0   ),  
        .ilck_2  ( `VCH_P1'b0   ),  

        .idata_3 ( n2_odata_1   ), 
        .ivalid_3( n2_ovalid_1  ), 
        .ivch_3  ( n2_ovch_1    ), 
        .oack_3  ( n3_oack_3    ), 
        .olck_3  ( n3_olck_3    ), 
        .odata_3 ( n3_odata_3   ), 
        .ovalid_3( n3_ovalid_3  ), 
        .ovch_3  ( n3_ovch_3    ), 
        .iack_3  ( n2_oack_1    ), 
        .ilck_3  ( n2_olck_1    ), 

        .my_xpos ( 1 ), 
        .my_ypos ( 1 ), 

        .clk ( clk  ), 
        .rst_( rst_ )  
); 

endmodule 
