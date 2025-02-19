#LD_LIBRARY_PATH=/opt/altera/12.1sp1_243/quartus/linux /opt/altera/12.1sp1_243/quartus/linux/quartus_stp -t t2.tcl

set hardware_name "USB-Blaster \[1-2\]"
set device_name "@1: EP2C5 (0x020B10DD)"

# little china guy (doesnt work for stp)
#set hardware_name "USB-Blaster(Altera) \[1-1\]"
#set device_name "@1: EP2C5 (0x020B10DD)"

puts "{<instance Index>, <source width>, <probe width>, <instance name>}"

foreach instance [get_insystem_source_probe_instance_info -hardware_name $hardware_name -device_name $device_name] {
 puts "instance: $instance"
}

#start_insystem_source_probe -hardware_name "USB-Blaster \[2-1\]" -device_name "@1: EP2C5 (0x020B10DD)"
start_insystem_source_probe -hardware_name $hardware_name -device_name $device_name

puts ""

puts "probe data of instance 0"
puts [read_probe_data -instance_index 0 -value_in_hex]
puts "source data of instance 0"
puts [read_source_data -instance_index 0 -value_in_hex]

puts "probe data of instance 1"
puts [read_probe_data -instance_index 1 -value_in_hex]
puts "source data of instance 1"
puts [read_source_data -instance_index 1 -value_in_hex]

#puts "probe data of instance 2"
#puts [read_probe_data -instance_index 2]

puts ""

puts "write source data 0"
write_source_data -instance_index 0 -value "64" -value_in_hex
puts "probe data of instance 0"
puts [read_probe_data -instance_index 0 -value_in_hex]
puts "source data of instance 0"
puts [read_source_data -instance_index 0 -value_in_hex]
puts ""

puts "write source data 1"
write_source_data -instance_index 1 -value "53" -value_in_hex
puts "probe data of instance 1"
puts [read_probe_data -instance_index 1 -value_in_hex]
puts "source data of instance 1"
puts [read_source_data -instance_index 1 -value_in_hex]

end_insystem_source_probe
