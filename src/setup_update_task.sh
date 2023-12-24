#!/bin/bash
# This script set update_task.sh to run as service with systemd
# OnBootSec is set quit large to make sure apt isn't in-use
# The auto-restart function isn't working properly likely due to Raspberry Pi 4 isn't connected with battery powered RTC
# Ref: https://unix.stackexchange.com/questions/48203/run-script-once-a-day-with-systemd
# Ref: https://www.freedesktop.org/software/systemd/man/latest/systemd.timer.html
script_path="${HOME}/Documents/update_task.sh"
daemon_name="update_task.service"
user_name="user"
systemd_dir="/lib/systemd/system/${daemon_name}"

# Add service to systemd
sudo bash -c "echo -e \"\
[Unit]\n\
Description=Daily automatic update script with update_task.sh\n\
After=multi-user.target\n\
StartLimitIntervalSec=0\n\
\n\
[Service]\n\
User=$user_name\n\
Type=simple\n\
KillMode=mixed\n\
ExecStart=${script_path}\n\
\n\
[Timer]\n\
OnBootSec=5min\n\
OnUnitActiveSec=1d\n\
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
sudo systemctl start $daemon_name
echo "Started daemon $daemon_name"
