proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  debug::add_scope template.lib 1
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir /home/s1786991/DSD4/VGA_interface/VGA_interface.cache/wt [current_project]
  set_property parent.project_path /home/s1786991/DSD4/VGA_interface/VGA_interface.xpr [current_project]
  set_property ip_repo_paths /home/s1786991/DSD4/VGA_interface/VGA_interface.cache/ip [current_project]
  set_property ip_output_repo /home/s1786991/DSD4/VGA_interface/VGA_interface.cache/ip [current_project]
  add_files -quiet /home/s1786991/DSD4/VGA_interface/VGA_interface.runs/synth_1/VGA_Sig_Gen.dcp
  read_xdc /home/s1786991/DSD4/VGA_interface/VGA_interface.srcs/constrs_1/new/vga_constraints.xdc
  link_design -top VGA_Sig_Gen -part xc7a35tcpg236-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force VGA_Sig_Gen_opt.dcp
  catch {report_drc -file VGA_Sig_Gen_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file VGA_Sig_Gen.hwdef}
  place_design 
  write_checkpoint -force VGA_Sig_Gen_placed.dcp
  catch { report_io -file VGA_Sig_Gen_io_placed.rpt }
  catch { report_utilization -file VGA_Sig_Gen_utilization_placed.rpt -pb VGA_Sig_Gen_utilization_placed.pb }
  catch { report_control_sets -verbose -file VGA_Sig_Gen_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force VGA_Sig_Gen_routed.dcp
  catch { report_drc -file VGA_Sig_Gen_drc_routed.rpt -pb VGA_Sig_Gen_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file VGA_Sig_Gen_timing_summary_routed.rpt -rpx VGA_Sig_Gen_timing_summary_routed.rpx }
  catch { report_power -file VGA_Sig_Gen_power_routed.rpt -pb VGA_Sig_Gen_power_summary_routed.pb }
  catch { report_route_status -file VGA_Sig_Gen_route_status.rpt -pb VGA_Sig_Gen_route_status.pb }
  catch { report_clock_utilization -file VGA_Sig_Gen_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

