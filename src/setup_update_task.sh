#!/bin/bash
# This script set update_task.sh to run as service with systemd
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
TimeoutStartSec=infinity\n\
\n\
[Install]\n\
WantedBy=multi-user.target\n\
\n\
[Timer]\n\
OnBootSec=1min\n\
OnUnitActiveSec=1d\n\
\" > $systemd_dir"
echo "Added service to systemd: $systemd_dir"

# Reload Daemon
sudo systemctl daemon-reload
echo "Reloaded systemctl daemon"

# Enable Service
sudo systemctl enable $daemon_name
echo "Enabled daemon $daemon_name"

# Start Service
sudo systemctl start $daemon_name
echo "Started daemon $daemon_name"
