webtalk_init -webtalk_dir E:/xillinx_latest/lift_2/lift_2.sim/sim_1/behav/xsim/xsim.dir/tb_lift_behav/webtalk/
webtalk_register_client -client project
webtalk_add_data -client project -key date_generated -value "Wed Feb 26 18:34:03 2020" -context "software_version_and_target_device"
webtalk_add_data -client project -key product_version -value "XSIM v2019.1 (64-bit)" -context "software_version_and_target_device"
webtalk_add_data -client project -key build_version -value "2552052" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_platform -value "WIN64" -context "software_version_and_target_device"
webtalk_add_data -client project -key registration_id -value "" -context "software_version_and_target_device"
webtalk_add_data -client project -key tool_flow -value "xsim_vivado" -context "software_version_and_target_device"
webtalk_add_data -client project -key beta -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key route_design -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_family -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_device -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_package -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_speed -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key random_id -value "488a783f-6a12-4fa8-98a0-e141ea8de384" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_id -value "2aa3d692a8bf4e8a9b62827534de8136" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_iteration -value "177" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_name -value "Windows Server 2008 R2 or Windows 7" -context "user_environment"
webtalk_add_data -client project -key os_release -value "Service Pack 1  (build 7601)" -context "user_environment"
webtalk_add_data -client project -key cpu_name -value "Intel(R) Core(TM) i3-4010U CPU @ 1.70GHz" -context "user_environment"
webtalk_add_data -client project -key cpu_speed -value "1696 MHz" -context "user_environment"
webtalk_add_data -client project -key total_processors -value "1" -context "user_environment"
webtalk_add_data -client project -key system_ram -value "6.000 GB" -context "user_environment"
webtalk_register_client -client xsim
webtalk_add_data -client xsim -key Command -value "xsim" -context "xsim\\command_line_options"
webtalk_add_data -client xsim -key trace_waveform -value "true" -context "xsim\\usage"
webtalk_add_data -client xsim -key runtime -value "100 ps" -context "xsim\\usage"
webtalk_add_data -client xsim -key iteration -value "0" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Time -value "0.06_sec" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Memory -value "6608_KB" -context "xsim\\usage"
webtalk_transmit -clientid 1022836275 -regid "" -xml E:/xillinx_latest/lift_2/lift_2.sim/sim_1/behav/xsim/xsim.dir/tb_lift_behav/webtalk/usage_statistics_ext_xsim.xml -html E:/xillinx_latest/lift_2/lift_2.sim/sim_1/behav/xsim/xsim.dir/tb_lift_behav/webtalk/usage_statistics_ext_xsim.html -wdm E:/xillinx_latest/lift_2/lift_2.sim/sim_1/behav/xsim/xsim.dir/tb_lift_behav/webtalk/usage_statistics_ext_xsim.wdm -intro "<H3>XSIM Usage Report</H3><BR>"
webtalk_terminate
