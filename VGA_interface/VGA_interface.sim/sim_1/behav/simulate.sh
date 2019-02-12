#!/bin/sh -f
xv_path="/opt/Xilinx/Vivado/2015.2"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim VGA_Sig_Gen_TB_behav -key {Behavioral:sim_1:Functional:VGA_Sig_Gen_TB} -tclbatch VGA_Sig_Gen_TB.tcl -log simulate.log
