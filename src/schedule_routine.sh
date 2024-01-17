#!/bin/bash
# This script set update_task.sh to run as service with systemd, a timer will fire the service to update
#	- fire at boot
#	- fire with timer
# Ref: https://unix.stackexchange.com/questions/48203/run-script-once-a-day-with-systemd
# Ref: https://www.freedesktop.org/software/systemd/man/latest/systemd.timer.html
script_path="${HOME}/Documents/GitHub/update_task.sh"
service_name="update_task.service"
timer_name="update_task.timer"
#sleep_time_min=3
systemd_service_dir="/lib/systemd/system/${service_name}"
systemd_timer_dir="/lib/systemd/system/${timer_name}"

# Add service to systemd
sudo bash -c "echo -e \"\
[Unit]\n\
Description=startup update script with update_task.sh\n\
After=multi-user.target\n\
StartLimitIntervalSec=0\n\
\n\
[Service]\n\
User=$USER\n\
Type=simple\n\
KillMode=mixed\n\
#TimeoutSec=$((60 * (sleep_time_min + 1)))
#ExecStartPre=/bin/sleep $((60 * sleep_time_min))
ExecStart=${script_path}\n\
\n\
[Install]\n\
WantedBy=multi-user.target\n\
\" > $systemd_service_dir"
echo "Added service to systemd: $systemd_service_dir"

# Add timer to systemd
sudo bash -c "echo -e \"\
[Unit]\n\
Description=timer to schedule update_task.service\n\
\n\
[Timer]\n\
OnCalendar=daily\n\
#OnBootSec=1m\n\
#OnUnitActiveSec=1m\n\
Unit=${service_name}\n\
RemainAfterElapse=no\n\
\n\
[Install]\n\
WantedBy=timers.target\n\
\" > $systemd_timer_dir"
echo "Added service to systemd: $systemd_timer_dir"

# Disable Daemon if exists
sudo systemctl stop $service_name
echo "Stopped daemon $service_name"
sudo systemctl stop $timer_name
echo "Stopped daemon $timer_name"

# Reload Daemon
sudo systemctl daemon-reload
echo "Reloaded systemctl daemon"

# Enable Service
sudo systemctl enable $service_name
echo "Enabled daemon $service_name"
sudo systemctl enable $timer_name
echo "Enabled daemon $timer_name"

# Start Service
sudo systemctl start $service_name &
echo "Started daemon $service_name"
sudo systemctl start $timer_name &
echo "Started daemon $timer_name"
