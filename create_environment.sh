#!/bin/bash

# Setting up the submission reminder app directory and its correct username.
read -p "Enter your name: " username

dir_name="submission_reminder_$username"
mkdir -p "$dir_name"

echo "Directory '$dir_name' has been created successfully."

#Making each individual sub-directory
mkdir -p "$dir_name/app"
mkdir -p "$dir_name/modules"
mkdir -p "$dir_name/assets"
mkdir -p "$dir_name/config"

#Including the script for the reminders
cat > "$dir_name/app/reminder.sh" << 'EOL'
#!/bin/bash

source ./config/config.env
source ./modules/functions.sh

submissions_file="./assets/submissions.txt"

echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "$submissions_file"
EOL
chmod u+x "$dir_name/app/reminder.sh"

#inclduing the script for the functions 
cat > "$dir_name/modules/functions.sh" << 'EOL'
#!/bin/bash

function check_submissions {
    local submissions_file="$1"
    echo "Checking submissions in $submissions_file"

    while IFS=, read -r student assignment status; do
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file")
}
EOL
chmod u+x "$dir_name/modules/functions.sh"

#including the script for the submissions file
cat > "$dir_name/assets/submissions.txt" << 'EOL'
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Jayden, Linux Commands, submitted
Natalie, Shell Navigation, not submitted
Larry, Git, not submitted
John, Shell Navigation, submitted
Angelo, Linux Commands, submitted
Amanda, Shell Navigation, not submitted
EOL

#including the config details
cat > "$dir_name/config/config.env" << 'EOL'
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOL

#Setting up the startup.sh script
cat > "$dir_name/startup.sh" << 'EOL'
#!/bin/bash
set -e

echo "Performing startup checks..."
sleep 1
echo "Checking environment variables and required files"
echo "All system checks are complete... system starting"
pwd

# Since this script runs inside the directory, no cd needed
./app/reminder.sh
EOL
chmod u+x "$dir_name/startup.sh"

# Change into the directory, then run startup.sh
cd "$dir_name" || { echo "Failed to enter $dir_name"; exit 1; }
./startup.sh
