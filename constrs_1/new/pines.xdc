##Clock signal
set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L12P_T1_MRCC_35 Sch=sysclk
#create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { sysclk }];

##Buttons
set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { rst }]; #IO_L12N_T1_MRCC_35 Sch=btn[0]
set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { start }]; #IO_L24N_T3_34 Sch=btn[1]
#set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports { btn[2] }]; #IO_L10P_T1_AD11P_35 Sch=btn[2]
#set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { btn[3] }]; #IO_L7P_T1_34 Sch=btn[3]


##Pmod Header JD                                                                                                                  
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33     } [get_ports { lcd_db[7] }]; #IO_L5P_T0_34 Sch=jd_p[1]                  
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33     } [get_ports { lcd_db[6] }]; #IO_L5N_T0_34 Sch=jd_n[1]				 
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33     } [get_ports { lcd_db[5] }]; #IO_L6P_T0_34 Sch=jd_p[2]                  
set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33     } [get_ports { lcd_db[4] }]; #IO_L6N_T0_VREF_34 Sch=jd_n[2]             

set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33     } [get_ports { lcd_e }]; #IO_L11P_T1_SRCC_34 Sch=jd_p[3]            
set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33     } [get_ports { lcd_rw }]; #IO_L11N_T1_SRCC_34 Sch=jd_n[3]            
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33     } [get_ports { lcd_rs }]; #IO_L21P_T3_DQS_34 Sch=jd_p[4]             
#set_property -dict { PACKAGE_PIN V18   IOSTANDARD LVCMOS33     } [get_ports { jd[7] }]; #IO_L21N_T3_DQS_34 Sch=jd_n[4]

##Pmod Header JC                                                                                                                  
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33     } [get_ports { rows[3] }]; #IO_L10P_T1_34 Sch=jc_p[1]   			 
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33     } [get_ports { rows[2] }]; #IO_L10N_T1_34 Sch=jc_n[1]		     
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33     } [get_ports { rows[1] }]; #IO_L1P_T0_34 Sch=jc_p[2]              
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33     } [get_ports { rows[0] }]; #IO_L1N_T0_34 Sch=jc_n[2]              
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33     } [get_ports { columns[3] }]; #IO_L8P_T1_34 Sch=jc_p[3]              
set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS33     } [get_ports { columns[2] }]; #IO_L8N_T1_34 Sch=jc_n[3]              
set_property -dict { PACKAGE_PIN T12   IOSTANDARD LVCMOS33     } [get_ports { columns[1] }]; #IO_L2P_T0_34 Sch=jc_p[4]              
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33     } [get_ports { columns[0] }]; #IO_L2N_T0_34 Sch=jc_n[4]



##Pmod Header JE                                                                                                                  
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { rx }]; #IO_L4P_T0_34 Sch=je[1]						 
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { tx }]; #IO_L18N_T2_34 Sch=je[2]                     
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { wave_alert }]; #IO_25_35 Sch=je[3]                          
#set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { je[3] }]; #IO_L19P_T3_35 Sch=je[4]                     
set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { motor_out[0] }]; #IO_L3N_T0_DQS_34 Sch=je[7]                  
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { motor_out[1] }]; #IO_L9N_T1_DQS_34 Sch=je[8]                  
set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { motor_out[2] }]; #IO_L20P_T3_34 Sch=je[9]                     
set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { motor_out[3] }]; #IO_L7N_T1_34 Sch=je[10]
##LEDs
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { s[0] }]; #IO_L23P_T3_35 Sch=led[0]
set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { s[1] }]; #IO_L23N_T3_35 Sch=led[1]
set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33 } [get_ports { s[2] }]; #IO_0_35 Sch=led[2]
set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { s[3] }]; #IO_L3N_T0_DQS_AD1N_35 Sch=led[3]

##RGB LED 6
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { fl }]; #IO_L18P_T2_34 Sch=led6_r




    