proc fpga_init {} {
  global fpga_last_nonce
  global fpga_name

  set fpga [find_miner_fpga]

  if {$fpga == -1} {
    return -1
  }

  set hardware_name [lindex $fpga 0]
  set device_name [lindex $fpga 1]

  start_insystem_source_probe -hardware_name $hardware_name -device_name $device_name

  set fpga_last_nonce [read_instance GNON]
  set fpga_name "$hardware_name $device_name"

  return 0
}

proc push_work_to_fpga {workl} {
  global fpga_last_nonce
  array set work $workl

  write_instance "STAT" [reverseHex $work(midstate)]
  write_instance "DAT2" [string range [reverseHex $work(data)] 64 127]

  # Reset the last seen nonce, since we've just given the FPGA new work
  set fpga_last_nonce [read_instance GNON]
}

# Return the current nonce the FPGA is on.
# This can be sampled to calculate how fast the FPGA is running.
# Returns -1 if that information is not available.
proc get_current_fpga_nonce {} {
  if { [instance_exists NONC] } {
    set nonce [read_instance NONC]
    return [expr 0x$nonce]
  } else {
    return -1
  }
}


