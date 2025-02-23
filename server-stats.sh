
#!/bin/bash

# Function to display total CPU usage
cpu_usage() {
    echo "CPU Usage:" 
    top -bn1 | grep "Cpu(s)" | awk '{print "User: "$2"% System: "$4"% Idle: "$8"%"}'
}

# Function to display memory usage
memory_usage() {
    echo "Memory Usage:"
    free -m | awk 'NR==2{printf "Used: %s MB, Free: %s MB (%.2f%% Used)\n", $3, $4, $3*100/$2 }'
}

# Function to display disk usage
disk_usage() {
    echo "Disk Usage:"
    df -h --total | awk '$1 == "total" {print "Used: "$3" Free: "$4 " (" $5 " used)"}'
}

# Function to display top 5 processes by CPU usage
top_processes_cpu() {
    echo "Top 5 Processes by CPU Usage:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -6
}

# Function to display top 5 processes by memory usage
top_processes_mem() {
    echo "Top 5 Processes by Memory Usage:"
    ps -eo pid,comm,%mem --sort=-%mem | head -6
}

# Stretch goal: Additional stats
os_version() {
    echo "OS Version: $(lsb_release -d | cut -f2)"
}

uptime_info() {
    echo "Uptime: $(uptime -p)"
}

load_average() {
    echo "Load Average: $(uptime | awk -F 'load average:' '{print $2}')"
}

logged_in_users() {
    echo "Logged in users:"
    who
}

failed_logins() {
    echo "Failed login attempts:"
    journalctl _SYSTEMD_UNIT=sshd.service | grep 'Failed password' | wc -l
}

# Main function to call all stats
echo "--- Server Performance Stats ---"
os_version
uptime_info
load_average
cpu_usage
memory_usage
disk_usage
top_processes_cpu
top_processes_mem
logged_in_users
failed_logins
