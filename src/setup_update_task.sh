#!/bin/bash
# This script set update_task.sh to run as service with systemd, whenever system boot up
# The timer isn't working properly likely due to Raspberry Pi 4 isn't connected with battery powered RTC
# Ref: https://unix.stackexchange.com/questions/48203/run-script-once-a-day-with-systemd
# Ref: https://www.freedesktop.org/software/systemd/man/latest/systemd.timer.html
script_path="${HOME}/Documents/update_task.sh"
daemon_name="update_task.service"
user_name="user"
sleep_time_min=3
systemd_dir="/lib/systemd/system/${daemon_name}"

# Add service to systemd
sudo bash -c "echo -e \"\
[Unit]\n\
Description=automatic startup update script with update_task.sh\n\
After=multi-user.target\n\
StartLimitIntervalSec=0\n\
\n\
[Service]\n\
User=$user_name\n\
Type=simple\n\
KillMode=mixed\n\
TimeoutSec=$((60 * (sleep_time_min + 1)))
ExecStartPre=/bin/sleep $((60 * sleep_time_min))
ExecStart=${script_path}\n\
\n\
[Install]\n\
WantedBy=multi-user.target\n\
\" > $systemd_dir"
echo "Added service to systemd: $systemd_dir"

# Disable Daemon if exists
sudo systemctl stop $daemon_name
echo "Stopped daemon $daemon_name"

# Reload Daemon
sudo systemctl daemon-reload
echo "Reloaded systemctl daemon"

# Enable Service
sudo systemctl enable $daemon_name
echo "Enabled daemon $daemon_name"

# Start Service
sudo systemctl start $daemon_name &
echo "Started daemon $daemon_name"
