#!LD_LIBRARY_PATH=/opt/altera/12.1sp1_243/quartus/linux /opt/altera/12.1sp1_243/quartus/linux/quartus_stp -t

package require cmdline

proc get_selected_list_item {lst idx} {
  # Convert to integer
  if [catch { set idx [expr {int($idx)}] }] {
    set idx -1
  }

  if {$idx < 0 || $idx >= [llength $lst]} {
    set len [llength $lst]
    puts "Invalid number. Please enter a number from 0 to $len"
    exit
  }

  return [lindex $lst $idx]
}


proc get_fpga_name {} {
  global fpga_name
  return $fpga_name
}

set fpga_instances [dict create]
set fpga_last_nonce 0
set fpga_name "Unknown"

# Search the specified FPGA device for all Sources and Probes
proc find_instances {hardware_name device_name} {
  global fpga_instances

  set fpga_instances [dict create]

  if {[catch {

		puts "{<instance Index>, <source width>, <probe width>, <instance name>}"
    foreach instance [get_insystem_source_probe_instance_info -hardware_name $hardware_name -device_name $device_name] {
      puts "instance: $instance"
			dict set fpga_instances [lindex $instance 3] [lindex $instance 0]
    }

  } exc]} {
    #puts stderr "DEV-REMOVE: Error in find_instances: $exc"
    set fpga_instances [dict create]
  }
}

proc write_instance {name value} {
  global fpga_instances
  write_source_data -instance_index [dict get $fpga_instances $name] -value_in_hex -value $value
}

proc read_instance {name} {
  global fpga_instances
  return [read_probe_data -value_in_hex -instance_index [dict get $fpga_instances $name]]
}

proc instance_exists {name} {
  global fpga_instances
  return [dict exists $fpga_instances $name]
}

proc find_our_fpga {} {
  set hardware_names [get_hardware_names]

  set id 0

  # List out all hardware names and the devices connected to them
  foreach hardware_name $hardware_names {
    puts "$id) $hardware_name"
    incr id

    foreach device_name [get_device_names -hardware_name $hardware_name] {
      puts "\t$device_name"
    }
  }

  if {[llength $hardware_names] == 0} {
    puts stderr "ERROR: There are no Altera devices currently connected."
    puts stderr "Please connect an Altera FPGA and re-run this script.\n"
    return -1
  }

  #puts -nonewline "\nWhich USB device would you like to scan? "
  #gets stdin selected_hardware_id
  #puts ""

	#if { $selected_hardware_id == "" } { set selected_hardware_id 0 }

	set selected_hardware_id 0

  set hardware_name [get_selected_list_item $hardware_names $selected_hardware_id]

  puts "Selected USB device: $hardware_name\n\n\n"

  if {[catch { set device_names [get_device_names -hardware_name $hardware_name] } exc]} {
    # below was commented
		puts stderr "DEV-REMOVE: Error on get_device_names: $exc"
    continue
  }

  foreach device_name $device_names {
    if { [check_if_fpga_is_ours $hardware_name $device_name] } {
      return [list $hardware_name $device_name]
    }
  }

  puts stderr "ERROR: There are no Altera FPGAs with correct firmware loaded on them."
  puts stderr "Please program your FPGA with firmware and re-run this script.\n"

  return -1
}

# Check if the specified FPGA is loaded with miner firmware
proc check_if_fpga_is_ours {hardware_name device_name} {
  find_instances $hardware_name $device_name

	return 1

  if {[instance_exists STAT] && [instance_exists DAT2] && [instance_exists GNON]} {
    return 1
  }

  return 0
}

puts "hello"

#get_hardware_names
#get_insystem_source_probe_instance_info -hardware_name "Unknown" -device_name "thing"

#find_our_fpga

proc fpga_init {} {
  global fpga_last_nonce
  global fpga_name

  set fpga [find_our_fpga]

  if {$fpga == -1} {
    return -1
  }

  set hardware_name [lindex $fpga 0]
  set device_name [lindex $fpga 1]

  start_insystem_source_probe -hardware_name $hardware_name -device_name $device_name

  #set fpga_last_nonce [read_instance GNON]
  set fpga_name "$hardware_name $device_name"

	puts "hardware_name\t$hardware_name"
	puts "device_name:\t$device_name"
	puts "fpga_name:\t$fpga_name"

  return 0
}

proc write_source_hex {name value} {
  global fpga_instances
  write_source_data -instance_index [dict get $fpga_instances $name] -value_in_hex -value $value
}

proc read_source_hex {name} {
  global fpga_instances
  return [read_source_data -value_in_hex -instance_index [dict get $fpga_instances $name]]
}

proc read_probe_hex {name} {
  global fpga_instances
  return [read_probe_data -value_in_hex -instance_index [dict get $fpga_instances $name]]
}

puts cmdline::argc

fpga_init

#set ret [instance_exists INVW]
#puts "exists 1: $ret"

#write_instance INVW 44
#set ret [read_instance INVW]
#puts "ret: $ret"

#set ret [read_instance OUTV]
#puts "ret: $ret"

puts ""

puts -nonewline "INVW source: "
puts [read_source_hex INVW]
puts -nonewline "INVW probe: "
puts [read_probe_hex INVW]

write_source_hex INVW 46
puts ""

puts -nonewline "INVW source: "
puts [read_source_hex INVW]
puts -nonewline "INVW probe: "
puts [read_probe_hex INVW]

end_insystem_source_probe
