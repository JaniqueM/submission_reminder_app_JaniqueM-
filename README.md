
#Submission Reminder App

#Overview

This is a simple Bash-based app that helps you track student assignment submissions. It reads a list of students and their submission statuses, then reminds you who has not submitted a specified assignment before the deadline.

#Features

- Configurable assignment name and deadline countdown
- Reads student submission data from a CSV file
- Shows reminders for students who have not submitted the assignment
- Easy to set up and run with a simple shell script

#Setup and Installation

1. Run the setup script to create the app folder structure, files, and start the app:
       ./create_environment.sh
When prompted, enter your name. This creates a folder named submission_reminder_<yourname>.

The script will automatically run the app and display reminders.

2. How to Use the App:
To start the app later, open your terminal and navigate to the app folder:

Copy code
cd submission_reminder_<yourname>

3. Run the startup script:

Copy code
./startup.sh

The app will print the assignment name, days remaining, and list students who have not submitted.

#Configuration
Change assignment or deadline:

Edit config/config.env file:

Copy code
ASSIGNMENT=Your Assignment Name
DAYS_REMAINING=Number_of_days_left

#Update student submission data:
Edit the assets/submissions.txt file. It uses CSV format:

Copy code
student, assignment, submission status
Example entries:
John Doe, Shell Navigation, not submitted
Jane Smith, Git, submitted

#File Structure

submission_reminder_<yourname>/
├── app/
│   └── reminder.sh           # Main script to run the reminder
├── assets/
│   └── submissions.txt      # List of students and their submission status
├── config/
│   └── config.env           # Assignment and days remaining configuration
├── modules/
│   └── functions.sh         # Helper functions used by the app
└── startup.sh               # Script to start the app with environment checks

#How It Works (Brief)
The startup.sh script runs first, performing checks then launching reminder.sh.

The reminder.sh script sources configuration and functions, reads student submissions, and calls check_submissions.

The functions.sh script contains the check_submissions function that scans the submissions file and prints reminders for students who have not submitted the specified assignment.

#Requirements
Bash shell (Linux, macOS, Windows with WSL)
Basic command line skills

#Troubleshooting
Make sure you run startup.sh from inside the app folder.
Check that the files exist and have the correct permissions (chmod +x for scripts).
Ensure the config/config.env file has the correct assignment name matching entries in submissions.txt.

Author
Janique Maduray


