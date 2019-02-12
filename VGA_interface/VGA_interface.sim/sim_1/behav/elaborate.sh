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
ExecStep $xv_path/bin/xelab -wto f8131012b01441448954a38a4b38ce3c -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot VGA_Sig_Gen_TB_behav xil_defaultlib.VGA_Sig_Gen_TB xil_defaultlib.glbl -log elaborate.log
