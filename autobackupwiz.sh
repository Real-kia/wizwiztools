#!/bin/bash

# Check if crontab is installed, install if not present
if ! command -v crontab &> /dev/null; then
    echo "Crontab is not installed. Installing now..."
    sudo apt-get update
    sudo apt-get install cron -y
fi

# Ask user for the number of hours
read -p "Enter the number of hours (e.g., 1, 2, 3): " hours

# Create a temporary file for the new crontab entry
cron_file=$(mktemp)

# Append the new crontab entry to the temporary file
sleep 0.1
echo "0 */$hours * * * bash <(curl -s https://raw.githubusercontent.com/Real-kia/wizwiztools/main/backupwizwiz.sh)" > "$cron_file"


# Merge the existing crontab entries with the new entry
sleep 0.1
crontab -l >> "$cron_file"
sleep 0.1
crontab "$cron_file"
sleep 0.1
# Clean up the temporary file
rm "$cron_file"

echo "Crontab has been updated to run the command every $hours hours."
