#!/bin/bash
#made by Real-kia :D
# Check if crontab is installed, install if not present
if ! command -v crontab &> /dev/null; then
    echo "Crontab is not installed. Installing now..."
    sudo apt-get update
    sudo apt-get install cron -y
fi

# Define the target directory for the backup script
backup_directory="/var/www/html/wizwizxui-timebot"

# Download the backupwizwiz.sh script
curl -sL -o "$backup_directory/backupwizwiz.sh" https://raw.githubusercontent.com/Real-kia/wizwiztools/main/backupwizwiz.sh

# Make the script executable
chmod +x "$backup_directory/backupwizwiz.sh"

# Ask user for the number of hours
read -p "Enter the number of hours (e.g., 1, 2, 3): " hours

# Create a temporary file for the new crontab entry
cron_file=$(mktemp)

# Append the new crontab entry to the temporary file
echo "0 */$hours * * * bash $backup_directory/backupwizwiz.sh" > "$cron_file"

# Merge the existing crontab entries with the new entry
crontab -l >> "$cron_file"
crontab "$cron_file"

# Clean up the temporary file
rm "$cron_file"

echo "Crontab has been updated to run the command every $hours hours."
