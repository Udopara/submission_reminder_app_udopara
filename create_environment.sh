#!/bin/bash

# Prompt the user for their name
echo -n "Enter your name: "
read user_name

directory_name="submission_reminder_${user_name}"

# Create the main directory and subdirectories
mkdir -p "$directory_name"/{app,modules,assets,config}

# Create and populate files

# config.env
echo "# This is the config file" > "$directory_name/config/config.env"
echo "ASSIGNMENT=\"Shell Navigation\"" >> "$directory_name/config/config.env"
echo "DAYS_REMAINING=2" >> "$directory_name/config/config.env"

# reminder.sh
echo "#!/bin/bash" > "$directory_name/app/reminder.sh"
echo "source ./config/config.env" >> "$directory_name/app/reminder.sh"
echo "source ./modules/functions.sh" >> "$directory_name/app/reminder.sh"
echo "submissions_file=\"./assets/submissions.txt\"" >> "$directory_name/app/reminder.sh"
echo "echo \"Assignment: \$ASSIGNMENT\"" >> "$directory_name/app/reminder.sh"
echo "echo \"Days remaining to submit: \$DAYS_REMAINING days\"" >> "$directory_name/app/reminder.sh"
echo "echo \"--------------------------------------------\"" >> "$directory_name/app/reminder.sh"
echo "check_submissions \$submissions_file" >> "$directory_name/app/reminder.sh"
chmod +x "$directory_name/app/reminder.sh"

# functions.sh
echo "#!/bin/bash" > "$directory_name/modules/functions.sh"
echo "function check_submissions {" >> "$directory_name/modules/functions.sh"
echo "    local submissions_file=\$1" >> "$directory_name/modules/functions.sh"
echo "    echo \"Checking submissions in \$submissions_file\"" >> "$directory_name/modules/functions.sh"
echo "    while IFS=, read -r student assignment status; do" >> "$directory_name/modules/functions.sh"
echo "        student=\$(echo \"\$student\" | xargs)" >> "$directory_name/modules/functions.sh"
echo "        assignment=\$(echo \"\$assignment\" | xargs)" >> "$directory_name/modules/functions.sh"
echo "        status=\$(echo \"\$status\" | xargs)" >> "$directory_name/modules/functions.sh"
echo "        if [[ \"\$assignment\" == \"\$ASSIGNMENT\" && \"\$status\" == \"not submitted\" ]]; then" >> "$directory_name/modules/functions.sh"
echo "            echo \"Reminder: \$student has not submitted the \$ASSIGNMENT assignment!\"" >> "$directory_name/modules/functions.sh"
echo "        fi" >> "$directory_name/modules/functions.sh"
echo "    done < <(tail -n +2 \"\$submissions_file\")" >> "$directory_name/modules/functions.sh"
echo "}" >> "$directory_name/modules/functions.sh"
chmod +x "$directory_name/modules/functions.sh"

# submissions.txt
echo "student, assignment, submission status" > "$directory_name/assets/submissions.txt"
echo "Chinemerem, Shell Navigation, not submitted" >> "$directory_name/assets/submissions.txt"
echo "Chiagoziem, Git, submitted" >> "$directory_name/assets/submissions.txt"
echo "Divine, Shell Navigation, not submitted" >> "$directory_name/assets/submissions.txt"
echo "Anissa, Shell Basics, submitted" >> "$directory_name/assets/submissions.txt"
echo "Lamine, Shell Navigation, not submitted" >> "$directory_name/assets/submissions.txt"
echo "Anthony, Git, submitted" >> "$directory_name/assets/submissions.txt"
echo "Uche, Shell Basics, submitted" >> "$directory_name/assets/submissions.txt"
echo "Peter, Shell Navigation, submitted" >> "$directory_name/assets/submissions.txt"
echo "Roy, Shell Navigation, not submitted" >> "$directory_name/assets/submissions.txt"

# startup.sh
echo "#!/bin/bash" > "$directory_name/startup.sh"
echo "echo \"Starting the Submission Reminder Application...\"" >> "$directory_name/startup.sh"
echo "./app/reminder.sh" >> "$directory_name/startup.sh"
chmod +x "$directory_name/startup.sh"

# Final message
echo "Environment setup complete!"
