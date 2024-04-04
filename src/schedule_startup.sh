#!/bin/bash
script_path="/opt/boot_trigger.sh"
auto_start_dir="$HOME/.config/autostart/boot_trigger.desktop"

# Remove previous entry if exists
if [ -f $auto_start_dir ]; then
	rm -f $auto_start_dir
	echo "Removed previous entry"
fi

# Add desktop entry
bash -c "echo -e \"\
[Desktop Entry]\n\
Type=Application\n\
Version=1.0\n\
Name=$(basename $script_path)\n\
Comment=Auto-Start script for $(basename $script_path)\n\
Exec=/bin/bash $script_path\n\
StartupNotify=false\n\
Terminal=true\n\
\" > $auto_start_dir"
echo "Added desktop entry: $auto_start_dir"
