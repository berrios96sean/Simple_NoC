/* Common definitions */           
`define Enable          1'b1       
`define Disable         1'b0       
`define Enable_         1'b0       
`define Disable_        1'b1       
`define High            1'b1       
`define Low             1'b0       
`define Write           1'b1       
`define Read            1'b0       
`define NULL            0          

/* Data width (32-bit data + 3-bit type) */ 
`define DATAW           34                  
`define DATAW_P1        35                  
`define DST_LSB         0                   
`define DST_MSB         1                  
`define SRC_LSB         2                  
`define SRC_MSB         3                  
`define VCH_LSB         4                  
`define VCH_MSB         5                  
`define TYPE_LSB        32                  
`define TYPE_MSB        34                  

/* Flit type */                 
`define TYPEW           2       
`define TYPEW_P1        3       
`define TYPE_NONE       3'b000  
`define TYPE_HEAD       3'b001  
`define TYPE_TAIL       3'b010  
`define TYPE_HEADTAIL   3'b011  
`define TYPE_DATA       3'b100  

/* Input FIFO (4-element) */ 
`define FIFO            4 
`define FIFO_P1         5 
`define FIFOD           2 
`define FIFOD_P1        3 
`define PKTLEN          4 
`define PKTLEN_P1       5 

/* Port number (5-port) */        
`define PORT            4         
`define PORT_P1         5         
`define PORTW           2         
`define PORTW_P1        3         

/* Vch number (2-VC) */   
`define VCH             1 
`define VCH_P1          2 
`define VCHW            0 
`define VCHW_P1         1 

/* Node number (4-node) */        
`define NODE            3         
`define NODE_P1         4         
`define NODEW           1         
`define NODEW_P1        2         

/* Dimenion-order routing */
`define ENTRYW          1         
`define ENTRYW_P1       2         
`define ARRAYW          0         
`define ARRAYW_P1       1         
`define DSTX_LSB        0          
`define DSTX_MSB        0         
`define DSTY_LSB        1         
`define DSTY_MSB        1         
`define ARRAY_DIV2      1         

